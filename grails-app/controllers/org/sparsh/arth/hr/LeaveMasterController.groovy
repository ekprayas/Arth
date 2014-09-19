package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class LeaveMasterController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_ADMIN"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        params.max = Math.min(max ?: 10, 100)
        [leaveMasterInstanceList: LeaveMaster.findAllByTenant(loggedInUser.tenant,params), leaveMasterInstanceTotal: LeaveMaster.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [leaveMasterInstance: new LeaveMaster(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveMasterInstance = new LeaveMaster(params)
		leaveMasterInstance.tenant = loggedInUser.tenant
        if (!leaveMasterInstance.save(flush: true)) {
            render(view: "create", model: [leaveMasterInstance: leaveMasterInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), leaveMasterInstance.id])
        redirect(action: "show", id: leaveMasterInstance.id)
    }

	@Secured(["ROLE_ADMIN"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveMasterInstance = LeaveMaster.get(id)
        if (!leaveMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "list")
            return
        }else if(leaveMasterInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [leaveMasterInstance: leaveMasterInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveMasterInstance = LeaveMaster.get(id)
        if (!leaveMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "list")
            return
        }else if(leaveMasterInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [leaveMasterInstance: leaveMasterInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveMasterInstance = LeaveMaster.get(id)
        if (!leaveMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "list")
            return
        }else if(leaveMasterInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (leaveMasterInstance.version > version) {
                leaveMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'leaveMaster.label', default: 'LeaveMaster')] as Object[],
                          "Another user has updated this LeaveMaster while you were editing")
                render(view: "edit", model: [leaveMasterInstance: leaveMasterInstance])
                return
            }
        }

        leaveMasterInstance.properties = params

        if (!leaveMasterInstance.save(flush: true)) {
            render(view: "edit", model: [leaveMasterInstance: leaveMasterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), leaveMasterInstance.id])
        redirect(action: "show", id: leaveMasterInstance.id)
    }

	@Secured(["ROLE_ADMIN"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def leaveMasterInstance = LeaveMaster.get(id)
        if (!leaveMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "list")
            return
        }else if(leaveMasterInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            leaveMasterInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'leaveMaster.label', default: 'LeaveMaster'), id])
            redirect(action: "show", id: id)
        }
    }
}
