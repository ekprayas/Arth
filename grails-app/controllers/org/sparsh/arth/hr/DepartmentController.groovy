package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class DepartmentController {

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
        [departmentInstanceList: Department.findAllByTenant(loggedInUser.tenant,params), departmentInstanceTotal: Department.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [departmentInstance: new Department(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def departmentInstance = new Department(params)
		departmentInstance.tenant = loggedInUser.tenant
        if (!departmentInstance.save(flush: true)) {
            render(view: "create", model: [departmentInstance: departmentInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
        redirect(action: "show", id: departmentInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def departmentInstance = Department.get(id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "list")
            return
        }else if(departmentInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [departmentInstance: departmentInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def departmentInstance = Department.get(id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "list")
            return
        }else if(departmentInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [departmentInstance: departmentInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def departmentInstance = Department.get(id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "list")
            return
        }else if(departmentInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (departmentInstance.version > version) {
                departmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'department.label', default: 'Department')] as Object[],
                          "Another user has updated this Department while you were editing")
                render(view: "edit", model: [departmentInstance: departmentInstance])
                return
            }
        }

        departmentInstance.properties = params

        if (!departmentInstance.save(flush: true)) {
            render(view: "edit", model: [departmentInstance: departmentInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
        redirect(action: "show", id: departmentInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def departmentInstance = Department.get(id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "list")
            return
        }else if(departmentInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            departmentInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'department.label', default: 'Department'), id])
            redirect(action: "show", id: id)
        }
    }
}
