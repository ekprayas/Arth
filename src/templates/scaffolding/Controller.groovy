<%=packageName ? "package ${packageName}\n\n" : ''%>
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured;
import org.sparsh.User;

class ${className}Controller {

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
        [${propertyName}List: ${className}.findAllByTenant(loggedInUser.tenant,params), ${propertyName}Total: ${className}.countByTenant(loggedInUser.tenant), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [${propertyName}: new ${className}(params), loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def save() {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def ${propertyName} = new ${className}(params)
		${propertyName}.tenant = loggedInUser.tenant
        if (!${propertyName}.save(flush: true)) {
            render(view: "create", model: [${propertyName}: ${propertyName}, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

	@Secured(["ROLE_ADMIN"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }else if(${propertyName}.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [${propertyName}: ${propertyName}, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def edit(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }else if(${propertyName}.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        [${propertyName}: ${propertyName}, loggedInUser: loggedInUser]
    }

	@Secured(["ROLE_ADMIN"])
    def update(Long id, Long version) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }else if(${propertyName}.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        if (version != null) {
            if (${propertyName}.version > version) {<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
                ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[],
                          "Another user has updated this ${className} while you were editing")
                render(view: "edit", model: [${propertyName}: ${propertyName}])
                return
            }
        }

        ${propertyName}.properties = params

        if (!${propertyName}.save(flush: true)) {
            render(view: "edit", model: [${propertyName}: ${propertyName}])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

	@Secured(["ROLE_ADMIN"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }else if(${propertyName}.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }

        try {
            ${propertyName}.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "show", id: id)
        }
    }
}
