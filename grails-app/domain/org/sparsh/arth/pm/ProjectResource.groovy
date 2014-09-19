package org.sparsh.arth.pm

import org.sparsh.Tenant
import org.sparsh.User
import org.sparsh.arth.hr.Employee;

class ProjectResource {
    Project project
    Employee user
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        project nullable:false 
        user nullable:false , unique:['tenant', 'project']
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    @Override
    public String toString() {        
        return user.toString();
    }
}
