package org.sparsh.arth.wf

import org.sparsh.Tenant;
import org.sparsh.arth.hr.Employee;

class ApprovalTask {
    String message
    Employee requestor
    Employee approver
    Date requestDate
    Date approveDate
    boolean approved
    String comments
    String type
    
    Long remoteId

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        comments blank:true, nullable:true, maxSize:512
        tenant nullable:false
        approveDate nullable:true
        remoteId nullable:false 
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
