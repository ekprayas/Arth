package org.sparsh.arth.hr

import org.sparsh.Tenant;

class EmployeePoC {
    
    Employee employee
    Employee projectPoC
    Employee hrPoC

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        employee nullable:false, unique:true
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
