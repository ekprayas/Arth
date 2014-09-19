package org.sparsh


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class UserController {

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
        [userInstanceList: User.findAllByTenant(loggedInUser.tenant,params), userInstanceTotal: User.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [userInstance: new User(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def userInstance = new User(params)
		userInstance.tenant = loggedInUser.tenant
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

	@Secured(["ROLE_ADMIN"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }else if(userInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [userInstance: userInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }else if(userInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [userInstance: userInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }else if(userInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

	@Secured(["ROLE_ADMIN"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }else if(userInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
    
    @Secured([
        "ROLE_ADMIN",
        "ROLE_SUPER_ADMIN",
        "ROLE_EMPLOYEE"
    ])
    def changePassword(){
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        [loggedInUser: loggedInUser]
    }

    @Secured([
        "ROLE_ADMIN",
        "ROLE_SUPER_ADMIN",
        "ROLE_EMPLOYEE"
    ])
    def updatePassword () {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        String password = params.oldPassword
        String newPassword = params.newPassword
        String newPassword2 = params.confirmPassword
        if (!password || !newPassword || !newPassword2 || newPassword != newPassword2) {
            flash.message = 'Please enter your current password and a valid new password'
            render view: 'changePassword', model: [loggedInUser: loggedInUser]
            return
        }

        User user = loggedInUser
        if (!springSecurityService.encodePassword(password).equals(user.password)) {
            flash.message = 'Current password is incorrect'
            render view: 'changePassword', model: [loggedInUser: loggedInUser]
            return
        }

        if (springSecurityService.encodePassword(newPassword).equals(user.password)) {
            flash.message = 'Please choose a different password from your current one'
            render view: 'changePassword', model: [loggedInUser: loggedInUser]
            return
        }

        user.password = newPassword
        user.passwordExpired = false
        user.save() // if you have password constraints check them here

        redirect controller: 'login', action: 'auth'
    }
}
