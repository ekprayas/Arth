package org.sparsh.arth.hr

import org.sparsh.Tenant;

class LeaveMaster {
    String name
    String description
    
    int hoursPerMonth
    int cutOffDay
    boolean carryForward   
    
    boolean approvalRequired
    
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        name blank:false, nullable: false, maxSize:128, unique:['tenant']
        description blank:false, nullable:false, maxSize:512
        cutOffDay range:0..30 
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    @Override
    public String toString() {
        return name;
    }
}
