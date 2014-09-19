package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class LeaveEmployeeCategoryController {

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
        [leaveEmployeeCategoryInstanceList: LeaveEmployeeCategory.findAllByTenant(loggedInUser.tenant,params), leaveEmployeeCategoryInstanceTotal: LeaveEmployeeCategory.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [leaveEmployeeCategoryInstance: new LeaveEmployeeCategory(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveEmployeeCategoryInstance = new LeaveEmployeeCategory(params)
		leaveEmployeeCategoryInstance.tenant = loggedInUser.tenant
        if (!leaveEmployeeCategoryInstance.save(flush: true)) {
            render(view: "create", model: [leaveEmployeeCategoryInstance: leaveEmployeeCategoryInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), leaveEmployeeCategoryInstance.id])
        redirect(action: "show", id: leaveEmployeeCategoryInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveEmployeeCategoryInstance = LeaveEmployeeCategory.get(id)
        if (!leaveEmployeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(leaveEmployeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [leaveEmployeeCategoryInstance: leaveEmployeeCategoryInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveEmployeeCategoryInstance = LeaveEmployeeCategory.get(id)
        if (!leaveEmployeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(leaveEmployeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [leaveEmployeeCategoryInstance: leaveEmployeeCategoryInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveEmployeeCategoryInstance = LeaveEmployeeCategory.get(id)
        if (!leaveEmployeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(leaveEmployeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (leaveEmployeeCategoryInstance.version > version) {
                leaveEmployeeCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory')] as Object[],
                          "Another user has updated this LeaveEmployeeCategory while you were editing")
                render(view: "edit", model: [leaveEmployeeCategoryInstance: leaveEmployeeCategoryInstance])
                return
            }
        }

        leaveEmployeeCategoryInstance.properties = params

        if (!leaveEmployeeCategoryInstance.save(flush: true)) {
            render(view: "edit", model: [leaveEmployeeCategoryInstance: leaveEmployeeCategoryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), leaveEmployeeCategoryInstance.id])
        redirect(action: "show", id: leaveEmployeeCategoryInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveEmployeeCategoryInstance = LeaveEmployeeCategory.get(id)
        if (!leaveEmployeeCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "list")
            return
        }else if(leaveEmployeeCategoryInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            leaveEmployeeCategoryInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory'), id])
            redirect(action: "show", id: id)
        }
    }
}
