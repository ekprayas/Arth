package org.sparsh.arth.tm

import org.sparsh.Tenant;
import org.sparsh.arth.hr.Employee;
import org.sparsh.arth.pm.Project;

class LeaveTimeSheet {
    
    Employee employee
    Date weekStartDate
    int day1
    int day2
    int day3
    int day4
    int day5
    int day6
    int day7
    
    String status
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        employee nullable:false, unique:['employee', 'weekStartDate'] 
        weekStartDate nullable:false
        tenant nullable:false
        status inList:['Saved','Submitted', 'Approved', 'Rejected']
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
