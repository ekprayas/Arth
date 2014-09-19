package org.sparsh.arth.hr


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class PublicHolidayController {

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
        [publicHolidayInstanceList: PublicHoliday.findAllByTenant(loggedInUser.tenant,params), publicHolidayInstanceTotal: PublicHoliday.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [publicHolidayInstance: new PublicHoliday(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def publicHolidayInstance = new PublicHoliday(params)
		publicHolidayInstance.tenant = loggedInUser.tenant
        if (!publicHolidayInstance.save(flush: true)) {
            render(view: "create", model: [publicHolidayInstance: publicHolidayInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), publicHolidayInstance.id])
        redirect(action: "show", id: publicHolidayInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def publicHolidayInstance = PublicHoliday.get(id)
        if (!publicHolidayInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "list")
            return
        }else if(publicHolidayInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [publicHolidayInstance: publicHolidayInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def publicHolidayInstance = PublicHoliday.get(id)
        if (!publicHolidayInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "list")
            return
        }else if(publicHolidayInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [publicHolidayInstance: publicHolidayInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def publicHolidayInstance = PublicHoliday.get(id)
        if (!publicHolidayInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "list")
            return
        }else if(publicHolidayInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (publicHolidayInstance.version > version) {
                publicHolidayInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'publicHoliday.label', default: 'PublicHoliday')] as Object[],
                          "Another user has updated this PublicHoliday while you were editing")
                render(view: "edit", model: [publicHolidayInstance: publicHolidayInstance])
                return
            }
        }

        publicHolidayInstance.properties = params

        if (!publicHolidayInstance.save(flush: true)) {
            render(view: "edit", model: [publicHolidayInstance: publicHolidayInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), publicHolidayInstance.id])
        redirect(action: "show", id: publicHolidayInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_HR"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def publicHolidayInstance = PublicHoliday.get(id)
        if (!publicHolidayInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "list")
            return
        }else if(publicHolidayInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            publicHolidayInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'publicHoliday.label', default: 'PublicHoliday'), id])
            redirect(action: "show", id: id)
        }
    }
}
