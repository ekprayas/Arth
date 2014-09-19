package org.sparsh

import org.springframework.security.access.annotation.Secured



class DashboardController {
    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    @Secured([
        "ROLE_ADMIN",
        "ROLE_SUPER_ADMIN",
        "ROLE_EMPLOYEE"
    ])
    def index() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)

        [loggedInUser: loggedInUser]
    }
}
