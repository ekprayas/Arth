package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class DesignationController {

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
        [designationInstanceList: Designation.findAllByTenant(loggedInUser.tenant,params), designationInstanceTotal: Designation.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [designationInstance: new Designation(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def designationInstance = new Designation(params)
		designationInstance.tenant = loggedInUser.tenant
        if (!designationInstance.save(flush: true)) {
            render(view: "create", model: [designationInstance: designationInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'designation.label', default: 'Designation'), designationInstance.id])
        redirect(action: "show", id: designationInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def designationInstance = Designation.get(id)
        if (!designationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "list")
            return
        }else if(designationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [designationInstance: designationInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def designationInstance = Designation.get(id)
        if (!designationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "list")
            return
        }else if(designationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [designationInstance: designationInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def designationInstance = Designation.get(id)
        if (!designationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "list")
            return
        }else if(designationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (designationInstance.version > version) {
                designationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'designation.label', default: 'Designation')] as Object[],
                          "Another user has updated this Designation while you were editing")
                render(view: "edit", model: [designationInstance: designationInstance])
                return
            }
        }

        designationInstance.properties = params

        if (!designationInstance.save(flush: true)) {
            render(view: "edit", model: [designationInstance: designationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'designation.label', default: 'Designation'), designationInstance.id])
        redirect(action: "show", id: designationInstance.id)
    }

	@Secured(["ROLE_ADMIN"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def designationInstance = Designation.get(id)
        if (!designationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "list")
            return
        }else if(designationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            designationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'designation.label', default: 'Designation'), id])
            redirect(action: "show", id: id)
        }
    }
}
