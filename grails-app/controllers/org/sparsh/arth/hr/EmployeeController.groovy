package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.Authority;
import org.sparsh.TenantConfig;
import org.sparsh.TenantConfigConstants;
import org.sparsh.User;
import org.sparsh.UserAuthority;

class EmployeeController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        params.max = Math.min(max ?: 10, 100)
        [employeeInstanceList: Employee.findAllByTenant(loggedInUser.tenant,params), employeeInstanceTotal: Employee.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [employeeInstance: new Employee(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeInstance = new Employee(params)
		employeeInstance.tenant = loggedInUser.tenant
        
        //additional logic
        if(TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.AUTO_INCREMENT_EMPLOYEE_NUMBER).value.toString().toLowerCase().equals("true")){
            int nextEmpId =Integer.parseInt(TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.NEXT_EMPLOYEE_NUMBER).value.toString())
            employeeInstance.employeeNumber = String.valueOf(nextEmpId)
            
            //update DB
            def tmpInstance = TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.NEXT_EMPLOYEE_NUMBER)
            tmpInstance.value = String.valueOf(nextEmpId + 1)
            tmpInstance.save(flush:true)
        }
        
        if (!employeeInstance.save(flush: true)) {
            render(view: "create", model: [employeeInstance: employeeInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
        
        def userInstance = new User()
        userInstance.firstname = employeeInstance.firstName
        userInstance.lastname = employeeInstance.lastName
        userInstance.email = employeeInstance.emailAddress
        
        userInstance.username = TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.ORGANISATION_CODE).value.toString().toLowerCase() + employeeInstance.employeeNumber
        userInstance.password = 'arth'
        userInstance.tenant = employeeInstance.tenant
        userInstance.enabled = true
        userInstance.save(flush:true)
           
        UserAuthority.create userInstance, Authority.findByAuthority('ROLE_EMPLOYEE'), true
        
        employeeInstance.user = userInstance
        employeeInstance.save(flush: true)
        
        redirect(action: "show", id: employeeInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeInstance = Employee.get(id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "list")
            return
        }else if(employeeInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeInstance: employeeInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeInstance = Employee.get(id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "list")
            return
        }else if(employeeInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeInstance: employeeInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeInstance = Employee.get(id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "list")
            return
        }else if(employeeInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (employeeInstance.version > version) {
                employeeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'employee.label', default: 'Employee')] as Object[],
                          "Another user has updated this Employee while you were editing")
                render(view: "edit", model: [employeeInstance: employeeInstance])
                return
            }
        }

        employeeInstance.properties = params

        if (!employeeInstance.save(flush: true)) {
            render(view: "edit", model: [employeeInstance: employeeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
        redirect(action: "show", id: employeeInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeInstance = Employee.get(id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "list")
            return
        }else if(employeeInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            employeeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), id])
            redirect(action: "show", id: id)
        }
    }
    
    @Secured(["ROLE_ADMIN", "ROLE_HR"])
    def assignPoC(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.get(id)
        if(EmployeePoC.findByEmployee(employeeInstance)){
          def tmpInstance =  EmployeePoC.findByEmployee(employeeInstance)
          tmpInstance.delete(flush: true)
        }
        
        def employeePoCInstance = new EmployeePoC(params)
        employeePoCInstance.tenant = loggedInUser.tenant
        employeePoCInstance.save(flush: true)            
        redirect(action: "show", id: employeeInstance.id)
    }
}
