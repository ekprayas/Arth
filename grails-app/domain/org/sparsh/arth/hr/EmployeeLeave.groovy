package org.sparsh.arth.hr
import org.sparsh.Tenant;

class EmployeeLeave {
    Employee employee
    LeaveMaster leaveMaster
    
    int balance
    
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        employee nullable:false , unique:['tenant', 'leaveMaster'] 
        leaveMaster nullable:false
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
