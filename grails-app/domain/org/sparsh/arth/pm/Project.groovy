package org.sparsh.arth.pm

import java.util.Date;

import org.sparsh.Tenant;
import org.sparsh.User;
import org.sparsh.arth.hr.Employee;

class Project {
    String title
    String description
    
    String status
    String progress        
    Employee responsible
    
    Date dateRecieved
    Date deliveryDate
    Date dateStart
    Date dateEnd

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        dateRecieved nullable:false, validator: {val, obj -> val <= obj.properties['deliveryDate']} 
        deliveryDate nullable:false 
        title blank:false, nullable: false, maxSize:128
        description blank:false, nullable:false, maxSize:512
        responsible nullable:true 
        status blank:false, inList:['New', 'Started', 'In-Progress','Completed', 'Delivered']
        dateStart nullable:true 
        dateEnd nullable:true
        progress inList:['0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%']
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    @Override
    public String toString() {
        return title;
    }
}
