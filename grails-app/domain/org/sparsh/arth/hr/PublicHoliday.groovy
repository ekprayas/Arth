package org.sparsh.arth.hr

import org.sparsh.Tenant;

class PublicHoliday {
    String name
    String type
    
    Date holidayDate
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        name blank:false,nullable:false
        holidayDate blank:false, nullable:false, unique:['tenant'] 
        type nullable:false, blank:false, inList:['Mandatory', 'Optional']
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
