package org.sparsh.arth.tm


import org.sparsh.Tenant;
import org.sparsh.arth.hr.Employee;

class TimeSheetGroup {
    
    Employee employee
    int totalHrs
    Date weekStartDate
    Date weekEndDate
    String status

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        employee nullable:false, unique:['tenant', 'weekStartDate'] 
        status inList:['Saved','Submitted', 'Approved', 'Rejected']
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
