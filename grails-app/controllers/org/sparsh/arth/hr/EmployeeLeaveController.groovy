package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class EmployeeLeaveController {

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
        [employeeLeaveInstanceList: EmployeeLeave.findAllByTenant(loggedInUser.tenant,params), employeeLeaveInstanceTotal: EmployeeLeave.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [employeeLeaveInstance: new EmployeeLeave(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveInstance = new EmployeeLeave(params)
		employeeLeaveInstance.tenant = loggedInUser.tenant
        if (!employeeLeaveInstance.save(flush: true)) {
            render(view: "create", model: [employeeLeaveInstance: employeeLeaveInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), employeeLeaveInstance.id])
        redirect(action: "show", id: employeeLeaveInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveInstance = EmployeeLeave.get(id)
        if (!employeeLeaveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeLeaveInstance: employeeLeaveInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveInstance = EmployeeLeave.get(id)
        if (!employeeLeaveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeLeaveInstance: employeeLeaveInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveInstance = EmployeeLeave.get(id)
        if (!employeeLeaveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (employeeLeaveInstance.version > version) {
                employeeLeaveInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'employeeLeave.label', default: 'EmployeeLeave')] as Object[],
                          "Another user has updated this EmployeeLeave while you were editing")
                render(view: "edit", model: [employeeLeaveInstance: employeeLeaveInstance])
                return
            }
        }

        employeeLeaveInstance.properties = params

        if (!employeeLeaveInstance.save(flush: true)) {
            render(view: "edit", model: [employeeLeaveInstance: employeeLeaveInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), employeeLeaveInstance.id])
        redirect(action: "show", id: employeeLeaveInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeLeaveInstance = EmployeeLeave.get(id)
        if (!employeeLeaveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "list")
            return
        }else if(employeeLeaveInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            employeeLeaveInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employeeLeave.label', default: 'EmployeeLeave'), id])
            redirect(action: "show", id: id)
        }
    }
}
