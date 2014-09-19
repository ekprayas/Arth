package org.sparsh

import java.util.Date;
import java.util.Set;

import org.sparsh.arth.hr.Employee;

class User {
	transient springSecurityService

    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    String firstname
    String lastname
    String email
    
    Date dateCreated
    Date lastUpdated

    Tenant tenant
    static constraints = {
        username blank: false, unique: true
        password blank: false
        firstname nullable:false , maxSize: 128
        lastname nullable:false , maxSize: 128       
        email email:true , maxSize: 128, nullable:false
        tenant nullable:false
    }

    static mapping = { password column: '`password`' }

    Set<Authority> getAuthorities() {
        UserAuthority.findAllByUser(this).collect { it.authority } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }

    public String toString() {

        return username + " [" + firstname + " " +lastname + "]"
    }

    static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
}
