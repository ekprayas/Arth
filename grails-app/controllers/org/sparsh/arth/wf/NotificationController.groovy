package org.sparsh.arth.wf


import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;
import org.sparsh.arth.hr.Employee;

class NotificationController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_EMPLOYEE"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        params.max = Math.min(max ?: 10, 100)
        [notificationInstanceList: Notification.findAllByTenantAndEmployee(loggedInUser.tenant,employeeInstance,params), notificationInstanceTotal: Notification.countByTenantAndEmployee(loggedInUser.tenant,employeeInstance), loggedInUser: loggedInUser]
    }

	
	@Secured(["ROLE_EMPLOYEE"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def notificationInstance = Notification.get(id)
        if (!notificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), id])
            redirect(action: "list")
            return
        }else if(notificationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(notificationInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }
        
        notificationInstance.isRead = true
        notificationInstance.save(flush:true)
        
        [notificationInstance: notificationInstance, loggedInUser: loggedInUser]
    }


	@Secured(["ROLE_EMPLOYEE"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def notificationInstance = Notification.get(id)
        if (!notificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), id])
            redirect(action: "list")
            return
        }else if(notificationInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(notificationInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }

        try {
            notificationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'notification.label', default: 'Notification'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'notification.label', default: 'Notification'), id])
            redirect(action: "show", id: id)
        }
    }
}
