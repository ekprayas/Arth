package org.sparsh.arth.wf


import org.apache.commons.lang.StringUtils;
import org.sparsh.Tenant;
import org.sparsh.arth.hr.Employee;

class Notification {
    Employee employee
    String message
    
    boolean isRead
    
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        employee nullable:false
        message nullable:false, maxSize:256 
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    @Override
    public String toString() {       
        return StringUtils.substring(message, 0, 20) + '...' ;
    }
}
