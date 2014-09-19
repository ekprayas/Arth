package org.sparsh.arth.pm


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class ProjectResourceController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        params.max = Math.min(max ?: 10, 100)
        [projectResourceInstanceList: ProjectResource.findAllByTenant(loggedInUser.tenant,params), projectResourceInstanceTotal: ProjectResource.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [projectResourceInstance: new ProjectResource(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectResourceInstance = new ProjectResource(params)
		projectResourceInstance.tenant = loggedInUser.tenant
        if (!projectResourceInstance.save(flush: true)) {
            render(view: "create", model: [projectResourceInstance: projectResourceInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), projectResourceInstance.id])
        redirect(action: "show", id: projectResourceInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectResourceInstance = ProjectResource.get(id)
        if (!projectResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "list")
            return
        }else if(projectResourceInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [projectResourceInstance: projectResourceInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectResourceInstance = ProjectResource.get(id)
        if (!projectResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "list")
            return
        }else if(projectResourceInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [projectResourceInstance: projectResourceInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectResourceInstance = ProjectResource.get(id)
        if (!projectResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "list")
            return
        }else if(projectResourceInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (projectResourceInstance.version > version) {
                projectResourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'projectResource.label', default: 'ProjectResource')] as Object[],
                          "Another user has updated this ProjectResource while you were editing")
                render(view: "edit", model: [projectResourceInstance: projectResourceInstance])
                return
            }
        }

        projectResourceInstance.properties = params

        if (!projectResourceInstance.save(flush: true)) {
            render(view: "edit", model: [projectResourceInstance: projectResourceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), projectResourceInstance.id])
        redirect(action: "show", id: projectResourceInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectResourceInstance = ProjectResource.get(id)
        if (!projectResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "list")
            return
        }else if(projectResourceInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            projectResourceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'projectResource.label', default: 'ProjectResource'), id])
            redirect(action: "show", id: id)
        }
    }
}
