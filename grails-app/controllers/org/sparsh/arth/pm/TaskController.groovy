package org.sparsh.arth.pm


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class TaskController {

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
        def projectInstance = Project.get(Long.parseLong(params.project))
        [taskInstanceList: Task.findAllByTenantAndProject(loggedInUser.tenant,projectInstance,params), taskInstanceTotal: Task.countByTenantAndProject(loggedInUser.tenant, projectInstance), loggedInUser: loggedInUser, projectInstance:projectInstance]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def create(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        if (!id) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'project.label', default: 'Project'),
                id
            ])
            redirect(action: "list", params:params)
            return
        }
        //TODO Add Project Status Related Validations
        
        def projectInstance = Project.get(id)
        
        def taskInstance = new Task(params)
        taskInstance.project = projectInstance
        [taskInstance: taskInstance, loggedInUser: loggedInUser, resources:ProjectResource.findAllByProject(projectInstance).collect { it.user } as Set, parentTask: Task.findAllByProject(projectInstance)]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def taskInstance = new Task(params)
		taskInstance.tenant = loggedInUser.tenant
        taskInstance.progress = '0%'
        
        if (!taskInstance.save(flush: true)) {
            render(view: "create", model: [taskInstance: taskInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        redirect(action: "show", id: taskInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }else if(taskInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [taskInstance: taskInstance, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }else if(taskInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [taskInstance: taskInstance, loggedInUser: loggedInUser, resources:ProjectResource.findAllByProject(taskInstance?.project).collect { it.user } as Set , parentTask: Task.findAllByProject(taskInstance?.project)]
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }else if(taskInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (taskInstance.version > version) {
                taskInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'task.label', default: 'Task')] as Object[],
                          "Another user has updated this Task while you were editing")
                render(view: "edit", model: [taskInstance: taskInstance])
                return
            }
        }

        taskInstance.properties = params

        if (!taskInstance.save(flush: true)) {
            render(view: "edit", model: [taskInstance: taskInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        redirect(action: "show", id: taskInstance.id)
    }

	@Secured(["ROLE_ADMIN", "ROLE_PM"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }else if(taskInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            taskInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "show", id: id)
        }
    }
}
