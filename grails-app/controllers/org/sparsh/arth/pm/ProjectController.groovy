package org.sparsh.arth.pm


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class ProjectController {

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
        [projectInstanceList: Project.findAllByTenant(loggedInUser.tenant,params), projectInstanceTotal: Project.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [projectInstance: new Project(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectInstance = new Project(params)
		projectInstance.tenant = loggedInUser.tenant
        projectInstance.status = 'New'
        projectInstance.progress = '0%'
        if (!projectInstance.save(flush: true)) {
            render(view: "create", model: [projectInstance: projectInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
        redirect(action: "show", id: projectInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }else if(projectInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [projectInstance: projectInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }else if(projectInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [projectInstance: projectInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }else if(projectInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (projectInstance.version > version) {
                projectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'project.label', default: 'Project')] as Object[],
                          "Another user has updated this Project while you were editing")
                render(view: "edit", model: [projectInstance: projectInstance])
                return
            }
        }

        projectInstance.properties = params

        if (!projectInstance.save(flush: true)) {
            render(view: "edit", model: [projectInstance: projectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
        redirect(action: "show", id: projectInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }else if(projectInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            projectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "show", id: id)
        }
    }
    
    @Secured(["ROLE_ADMIN", "ROLE_PM"])
    def assignPoC(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def projectInstance = Project.get(id)
        
        projectInstance.properties = params
        projectInstance.save(flush: true)
        redirect(action: "show", id: projectInstance.id)
    }
}
