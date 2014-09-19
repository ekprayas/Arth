package org.sparsh;

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured

class TenantController {

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    @Secured(["ROLE_SUPER_ADMIN"])
    def index() {
        redirect(action: "list", params: params)
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def list(Integer max) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        params.max = Math.min(max ?: 10, 100)
        [tenantInstanceList: Tenant.findAll(params), tenantInstanceTotal: Tenant.count(), loggedInUser: loggedInUser]
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def create() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        [tenantInstance: new Tenant(params), loggedInUser: loggedInUser]
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def save() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = new Tenant(params)
        if (!tenantInstance.save(flush: true)) {
            render(view: "create", model: [tenantInstance: tenantInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.created.message', args: [
            message(code: 'tenant.label', default: 'Tenant'),
            tenantInstance.id
        ])

        //create a default user for this tenant with admin role
        def user = User.findByUsername(tenantInstance.email) ?: new User(tenant:tenantInstance, username: tenantInstance.email, enabled: true, password: 'arth', firstname:"Company", lastname:"Admin", email:tenantInstance.email ).save(failOnError: true)
        UserAuthority.createAdmin(user)
        
        //create default configs
        TenantConfig.createWithDefaultValue(tenantInstance)

        redirect(action: "show", id: tenantInstance.id)
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def show(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = Tenant.get(id)
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "list")
            return
        }
        [tenantInstance: tenantInstance, loggedInUser: loggedInUser]
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def edit(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = Tenant.get(id)
        if (!tenantInstance) {
            tenantInstance = loggedInUser.tenant
        }
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "list")
            return
        }
        [tenantInstance: tenantInstance, loggedInUser: loggedInUser]
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def update(Long id, Long version) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = Tenant.get(id)
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tenantInstance.version > version) {
                tenantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [
                            message(code: 'tenant.label', default: 'Tenant')] as Object[],
                        "Another user has updated this Tenant while you were editing")
                render(view: "edit", model: [tenantInstance: tenantInstance])
                return
            }
        }

        tenantInstance.properties = params

        if (!tenantInstance.save(flush: true)) {
            render(view: "edit", model: [tenantInstance: tenantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [
            message(code: 'tenant.label', default: 'Tenant'),
            tenantInstance.id
        ])
        redirect(action: "show", id: tenantInstance.id)
    }

    @Secured(["ROLE_SUPER_ADMIN"])
    def delete(Long id) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = Tenant.get(id)
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "list")
            return
        }

        try {
            tenantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect(action: "show", id: id)
        }
    }

    @Secured(["ROLE_ADMIN"])
    def editProfile() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = loggedInUser.tenant
        if (!tenantInstance) {
            tenantInstance = loggedInUser.tenant
        }
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect controller: 'login', action: 'auth'
            return
        }
        [tenantInstance: tenantInstance, loggedInUser: loggedInUser]
    }

    @Secured(["ROLE_ADMIN"])
    def updateProfile(Long id, Long version) {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        def tenantInstance = Tenant.get(id)
        if (!tenantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                message(code: 'tenant.label', default: 'Tenant'),
                id
            ])
            redirect controller: 'login', action: 'auth'
            return
        }

        if (version != null) {
            if (tenantInstance.version > version) {
                tenantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [
                            message(code: 'tenant.label', default: 'Tenant')] as Object[],
                        "Another user has updated this Tenant while you were editing")
                render(view: "editProfile", model: [tenantInstance: tenantInstance, loggedInUser: loggedInUser])
                return
            }
        }

        tenantInstance.properties = params

        if (!tenantInstance.save(flush: true)) {
            render(view: "editProfile", model: [tenantInstance: tenantInstance, loggedInUser: loggedInUser])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [
            message(code: 'tenant.label', default: 'Tenant'),
            tenantInstance.id
        ])
        redirect controller: 'login', action: 'auth'
    }
}
