package org.sparsh


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class TenantConfigController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_SUPER_ADMIN","ROLE_ADMIN"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_SUPER_ADMIN","ROLE_ADMIN"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        params.max = Math.min(max ?: 10, 100)
        [tenantConfigInstanceList: TenantConfig.findAllByTenant(loggedInUser.tenant,params), tenantConfigInstanceTotal: TenantConfig.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_SUPER_ADMIN"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [tenantConfigInstance: new TenantConfig(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_SUPER_ADMIN"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def tenantConfigInstance = new TenantConfig(params)
		tenantConfigInstance.tenant = loggedInUser.tenant
        if (!tenantConfigInstance.save(flush: true)) {
            render(view: "create", model: [tenantConfigInstance: tenantConfigInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), tenantConfigInstance.id])
        redirect(action: "show", id: tenantConfigInstance.id)
    }

	@Secured(["ROLE_SUPER_ADMIN","ROLE_ADMIN"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def tenantConfigInstance = TenantConfig.get(id)
        if (!tenantConfigInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "list")
            return
        }else if(tenantConfigInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [tenantConfigInstance: tenantConfigInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_SUPER_ADMIN","ROLE_ADMIN"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def tenantConfigInstance = TenantConfig.get(id)
        if (!tenantConfigInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "list")
            return
        }else if(tenantConfigInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [tenantConfigInstance: tenantConfigInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_SUPER_ADMIN","ROLE_ADMIN"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def tenantConfigInstance = TenantConfig.get(id)
        if (!tenantConfigInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "list")
            return
        }else if(tenantConfigInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (tenantConfigInstance.version > version) {
                tenantConfigInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'tenantConfig.label', default: 'TenantConfig')] as Object[],
                          "Another user has updated this TenantConfig while you were editing")
                render(view: "edit", model: [tenantConfigInstance: tenantConfigInstance])
                return
            }
        }

        tenantConfigInstance.properties = params

        if (!tenantConfigInstance.save(flush: true)) {
            render(view: "edit", model: [tenantConfigInstance: tenantConfigInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), tenantConfigInstance.id])
        redirect(action: "show", id: tenantConfigInstance.id)
    }

	@Secured(["ROLE_SUPER_ADMIN"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def tenantConfigInstance = TenantConfig.get(id)
        if (!tenantConfigInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "list")
            return
        }else if(tenantConfigInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            tenantConfigInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tenantConfig.label', default: 'TenantConfig'), id])
            redirect(action: "show", id: id)
        }
    }
}
