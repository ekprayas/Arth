package org.sparsh.arth.wf


import org.sparsh.User
import org.sparsh.arth.hr.Employee
import org.sparsh.arth.hr.EmployeeLeave;
import org.sparsh.arth.hr.EmployeeLeaveTransaction
import org.sparsh.arth.tm.TimeSheet;
import org.sparsh.arth.tm.TimeSheetGroup;
import org.sparsh.arth.tm.TimeSheetGroupController
import org.springframework.security.access.annotation.Secured

class ApprovalTaskController {

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
		
        params.max = Math.min(max ?: 10, 100)
        //get employee instance
        def employeeInstance = Employee.findByUser(loggedInUser)
        [approvalTaskInstanceList: ApprovalTask.findAllByTenantAndApproverAndApproveDate(loggedInUser.tenant,employeeInstance, null,params), approvalTaskInstanceTotal: ApprovalTask.countByTenantAndApproverAndApproveDate(loggedInUser.tenant, employeeInstance, null), loggedInUser: loggedInUser]
    }
    
    @Secured(["ROLE_EMPLOYEE"])
    def fullList(Integer max) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        
        params.max = Math.min(max ?: 10, 100)
        //get employee instance
        def employeeInstance = Employee.findByUser(loggedInUser)
        render(view:"list", model:[approvalTaskInstanceList: ApprovalTask.findAllByTenantAndApprover(loggedInUser.tenant,employeeInstance,params), approvalTaskInstanceTotal: ApprovalTask.countByTenantAndApprover(loggedInUser.tenant, employeeInstance), loggedInUser: loggedInUser])      
    }

	@Secured(["ROLE_EMPLOYEE"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def approvalTaskInstance = ApprovalTask.get(id)
        if (!approvalTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'approvalTask.label', default: 'ApprovalTask'), id])
            redirect(action: "list")
            return
        }else if(approvalTaskInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [approvalTaskInstance: approvalTaskInstance, loggedInUser: loggedInUser]
    }
    
    @Secured(["ROLE_EMPLOYEE"])
    def approve(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        
        def approvalTaskInstance = ApprovalTask.get(id)
        if (!approvalTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'approvalTask.label', default: 'ApprovalTask'), id])
            redirect(action: "list")
            return
        }else if(approvalTaskInstance.tenant != loggedInUser.tenant){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(approvalTaskInstance.approver != Employee.findByUser(loggedInUser)){
            flash.message = 'You are not the approver of this task.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }
        
        if(approvalTaskInstance.approveDate){
            flash.message = 'You have been already performed your action.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }else{
        
            approvalTaskInstance.comments = params.comments
            approvalTaskInstance.approved = true
            approvalTaskInstance.approveDate = new Date()
            approvalTaskInstance.save(flush:true)
            
            //additional Logic
            if(approvalDone(approvalTaskInstance.type,approvalTaskInstance.remoteId)){
                if(allIsWell(approvalTaskInstance.type,approvalTaskInstance.remoteId)){
                    updateRemoteId(true, approvalTaskInstance)                    
                }
            }
            
            flash.message = 'You have approved this action.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }
    }
    
    @Secured(["ROLE_EMPLOYEE"])
    def reject(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        
        def approvalTaskInstance = ApprovalTask.get(id)
        if (!approvalTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'approvalTask.label', default: 'ApprovalTask'), id])
            redirect(action: "list")
            return
        }else if(approvalTaskInstance.tenant != loggedInUser.tenant){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(approvalTaskInstance.approver != Employee.findByUser(loggedInUser)){
            flash.message = 'You are not the approver of this task.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }
        
        if(approvalTaskInstance.approveDate){
            flash.message = 'You have been already performed your action.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }else{
            approvalTaskInstance.comments = params.comments
            approvalTaskInstance.approved = false
            approvalTaskInstance.approveDate = new Date()
            approvalTaskInstance.save(flush:true)
            
            //additional Logic
            if(approvalDone(approvalTaskInstance.type,approvalTaskInstance.remoteId)){
               updateRemoteId(false, approvalTaskInstance)                
            }
            
            flash.message = 'You have declined this action.'
            redirect(action: "show", id:approvalTaskInstance.id)
            return
        }

    }
    
    private boolean approvalDone(String type, Long id){
        def tmpList = ApprovalTask.findAllByTypeAndRemoteId(type, id)
        for(ApprovalTask at : tmpList){
            if(!at.approveDate){
                return false
            }
        }
        
        return true
    }
    
    private boolean allIsWell(String type, Long id){
        def tmpList = ApprovalTask.findAllByTypeAndRemoteId(type, id)
        for(ApprovalTask at : tmpList){
            if(!at.approved){
                return false
            }
        }        
        return true
    }
    
    private boolean updateRemoteId(boolean status, ApprovalTask instance){
        if(instance.type.equals('LEAVE')){
            def tmp = EmployeeLeaveTransaction.get(instance.remoteId)
            tmp.status = status?'Approved':'Rejected'
            tmp.save(flush:true)
            def message = '['+ tmp.status+'] '+instance.message
            new Notification(employee:tmp.employee, message:message, tenant:tmp.tenant).save(flush:true)
            
            //create timesheet
            if(status){
                TimeSheetGroupController.complexLeaveTimeSheetGeneration(tmp);
                def t1 = EmployeeLeave.findByLeaveMasterAndEmployee(tmp.leaveMaster, tmp.employee)
                t1.balance = t1.balance - tmp.appliedHours
                t1.save(flush:true)
            }
        }else if(instance.type.equals('TIMESHEET')){
            def tmp = TimeSheetGroup.get(instance.remoteId)
            tmp.status = status?'Approved':'Rejected'
            tmp.save(flush:true)
            
            //mark all timesheets
            def listTM = TimeSheet.findAllByEmployeeAndWeekStartDate(tmp.employee, tmp.weekStartDate)
            for(TimeSheet tm: listTM){
                tm.status = tmp.status
                tm.save(flush:true)
            }
            def message = '['+ tmp.status+'] '+instance.message
            new Notification(employee:tmp.employee, message:message, tenant:tmp.tenant).save(flush:true)            
        }
        
    }
}
