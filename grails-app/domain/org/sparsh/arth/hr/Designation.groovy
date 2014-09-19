package org.sparsh.arth.hr

import org.sparsh.Tenant;

class Designation {
    EmployeeCategory employeeCategory
    String name
    String code
    
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        employeeCategory nullable:false
        name blank:false , maxSize: 128
        code blank:false , maxSize: 32, unique:'tenant'
        tenant nullable: false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    public String toString() {
        return code + " [" + name + "]";
    }
}
