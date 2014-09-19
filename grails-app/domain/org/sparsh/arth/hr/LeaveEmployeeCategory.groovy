package org.sparsh.arth.hr


import org.sparsh.Tenant;

class LeaveEmployeeCategory {
    LeaveMaster leaveMaster
    EmployeeCategory employeeCategory
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        leaveMaster nullable:false
        employeeCategory nullable:false , unique:['leaveMaster', 'tenant']
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
