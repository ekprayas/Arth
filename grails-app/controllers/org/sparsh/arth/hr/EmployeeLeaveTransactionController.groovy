package org.sparsh.arth.hr


import org.sparsh.TenantConfig
import org.sparsh.TenantConfigConstants
import org.sparsh.User
import org.sparsh.arth.tm.TimeSheetGroupController;
import org.sparsh.arth.wf.ApprovalTask
import org.sparsh.arth.wf.Notification
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured

class EmployeeLeaveTransactionController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_EMPLOYEE"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        params.max = Math.min(max ?: 10, 100)
        [employeeLeaveTransactionInstanceList: EmployeeLeaveTransaction.findAllByTenantAndEmployee(loggedInUser.tenant,employeeInstance,params), employeeLeaveTransactionInstanceTotal: EmployeeLeaveTransaction.countByTenantAndEmployee(loggedInUser.tenant,employeeInstance), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_EMPLOYEE"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def employeeLeaveTransactionInstance = new EmployeeLeaveTransaction(params)
        employeeLeaveTransactionInstance.employee = employeeInstance
        [employeeLeaveTransactionInstance: employeeLeaveTransactionInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_EMPLOYEE"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def employeeLeaveTransactionInstance = new EmployeeLeaveTransaction(params)
		employeeLeaveTransactionInstance.tenant = loggedInUser.tenant
        employeeLeaveTransactionInstance.employee = employeeInstance
        employeeLeaveTransactionInstance.status = 'Saved'
        //validate for balance
        if(EmployeeLeave.findByLeaveMasterAndEmployee(employeeLeaveTransactionInstance.leaveMaster, employeeInstance)){
            if(employeeLeaveTransactionInstance.appliedHours > EmployeeLeave.findByLeaveMasterAndEmployee(employeeLeaveTransactionInstance.leaveMaster, employeeInstance).balance){
                flash.message = 'You do not have enough balance to these much hours.'
                render(view: "create", model: [employeeLeaveTransactionInstance: employeeLeaveTransactionInstance, loggedInUser: loggedInUser])
                return
            }
        }else{
            flash.message = 'You are not eligible for this leave type.'
            render(view: "create", model: [employeeLeaveTransactionInstance: employeeLeaveTransactionInstance, loggedInUser: loggedInUser])
            return
        }        
        
        if (!employeeLeaveTransactionInstance.save(flush: true)) {
            render(view: "create", model: [employeeLeaveTransactionInstance: employeeLeaveTransactionInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), employeeLeaveTransactionInstance.id])
        redirect(action: "show", id: employeeLeaveTransactionInstance.id)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveTransactionInstance = EmployeeLeaveTransaction.get(id)
        if (!employeeLeaveTransactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveTransactionInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeLeaveTransactionInstance: employeeLeaveTransactionInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_EMPLOYEE"])
    def submitForApproval(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def employeeLeaveTransactionInstance = EmployeeLeaveTransaction.get(id)
        if (!employeeLeaveTransactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveTransactionInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(employeeLeaveTransactionInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(!employeeLeaveTransactionInstance.status.equalsIgnoreCase("Saved")){
            flash.message = 'You can not re-submit this request.'
            redirect(action: "list")
            return
        }
        //check if approval required
        if(employeeLeaveTransactionInstance?.leaveMaster?.approvalRequired){
            def employeePoCInstance = EmployeePoC.findByEmployee(employeeInstance)
            //check if employee have POC
            if(!employeePoCInstance){
                flash.message = 'Your Point of Contact are not available. Contact Administrator.'
                redirect(action: "show", id: employeeLeaveTransactionInstance.id)
                return
            }else{
                //read system value
                def confVal = TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.LEAVE_APPROVAL).value.toString().split(",")
                for(String s: confVal){
                    if('HRPOC'.equalsIgnoreCase(s)){
                        def approvalTaskInstance = new ApprovalTask(type:'LEAVE',requestor:employeeInstance, requestDate:new Date(), tenant:loggedInUser.tenant)
                        approvalTaskInstance.message = message(code: 'default.leave.request', args:[employeeInstance,employeeLeaveTransactionInstance.appliedHours,employeeLeaveTransactionInstance.startDate])
                        approvalTaskInstance.approver = employeePoCInstance?.hrPoC
                        approvalTaskInstance.remoteId = employeeLeaveTransactionInstance.id
                        approvalTaskInstance.save(flush:true)
                        new Notification(employee:approvalTaskInstance.approver, message:approvalTaskInstance.message, tenant:loggedInUser.tenant).save(flush:true)
                    }else if('PRPOC'.equalsIgnoreCase(s)){
                        def approvalTaskInstance = new ApprovalTask(type:'LEAVE',requestor:employeeInstance, requestDate:new Date(), tenant:loggedInUser.tenant)
                        approvalTaskInstance.message = message(code: 'default.leave.request', args:[employeeInstance,employeeLeaveTransactionInstance.appliedHours,employeeLeaveTransactionInstance.startDate])
                        approvalTaskInstance.approver = employeePoCInstance?.projectPoC
                        approvalTaskInstance.remoteId = employeeLeaveTransactionInstance.id
                        approvalTaskInstance.save(flush:true)
                        new Notification(employee:approvalTaskInstance.approver, message:approvalTaskInstance.message, tenant:loggedInUser.tenant).save(flush:true)
                    }
                }
                employeeLeaveTransactionInstance.status = 'Submitted'
           }
        }else{
            def tmp = EmployeeLeave.findByLeaveMasterAndEmployee(employeeLeaveTransactionInstance.leaveMaster, employeeInstance)
            tmp.balance = tmp.balance - employeeLeaveTransactionInstance.appliedHours
            tmp.save(flush:true)
            
            employeeLeaveTransactionInstance.status = 'Approved'
            TimeSheetGroupController.complexLeaveTimeSheetGeneration(employeeLeaveTransactionInstance);
        }
        employeeLeaveTransactionInstance.save(flush:true)
        
        redirect(action: "show", id: employeeLeaveTransactionInstance.id)
    }


	@Secured(["ROLE_EMPLOYEE"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def employeeLeaveTransactionInstance = EmployeeLeaveTransaction.get(id)
        if (!employeeLeaveTransactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveTransactionInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(employeeLeaveTransactionInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(!employeeLeaveTransactionInstance.status.equalsIgnoreCase("Saved")){
            flash.message = 'You can not delete this request.'
            redirect(action: "list")
            return
        }

        try {
            employeeLeaveTransactionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction'), id])
            redirect(action: "show", id: id)
        }
    }
}
