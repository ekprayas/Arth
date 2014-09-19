package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class EmployeeCategoryController {

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
        [employeeCategoryInstanceList: EmployeeCategory.findAllByTenant(loggedInUser.tenant,params), employeeCategoryInstanceTotal: EmployeeCategory.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [employeeCategoryInstance: new EmployeeCategory(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeCategoryInstance = new EmployeeCategory(params)
		employeeCategoryInstance.tenant = loggedInUser.tenant
        if (!employeeCategoryInstance.save(flush: true)) {
            render(view: "create", model: [employeeCategoryInstance: employeeCategoryInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), employeeCategoryInstance.id])
        redirect(action: "show", id: employeeCategoryInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeCategoryInstance = EmployeeCategory.get(id)
        if (!employeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(employeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeCategoryInstance: employeeCategoryInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeCategoryInstance = EmployeeCategory.get(id)
        if (!employeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(employeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [employeeCategoryInstance: employeeCategoryInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeCategoryInstance = EmployeeCategory.get(id)
        if (!employeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(employeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (employeeCategoryInstance.version > version) {
                employeeCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'employeeCategory.label', default: 'EmployeeCategory')] as Object[],
                          "Another user has updated this EmployeeCategory while you were editing")
                render(view: "edit", model: [employeeCategoryInstance: employeeCategoryInstance])
                return
            }
        }

        employeeCategoryInstance.properties = params

        if (!employeeCategoryInstance.save(flush: true)) {
            render(view: "edit", model: [employeeCategoryInstance: employeeCategoryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), employeeCategoryInstance.id])
        redirect(action: "show", id: employeeCategoryInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def employeeCategoryInstance = EmployeeCategory.get(id)
        if (!employeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(employeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            employeeCategoryInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employeeCategory.label', default: 'EmployeeCategory'), id])
            redirect(action: "show", id: id)
        }
    }
}
