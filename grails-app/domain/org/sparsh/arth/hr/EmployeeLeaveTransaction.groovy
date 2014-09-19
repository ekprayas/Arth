package org.sparsh.arth.hr

import org.sparsh.Tenant

class EmployeeLeaveTransaction {
    Employee employee
    LeaveMaster leaveMaster
    
    int appliedHours
    String comments
    Date startDate
    String status
    
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        employee nullable:false 
        leaveMaster nullable:false 
        appliedHours nullable:false , blank:false, min:1
        startDate nullable:false, blank:false
        comments blank:true, nullable:true, maxSize:512                 
        status inList:['Saved','Submitted', 'Approved', 'Rejected'] 
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
