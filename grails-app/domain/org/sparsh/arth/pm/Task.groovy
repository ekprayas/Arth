package org.sparsh.arth.pm
import java.util.Date;
import org.sparsh.User;
import org.sparsh.Tenant;
import org.sparsh.arth.hr.Employee;

class Task {
    
    String name
    int hours
    Task parent
    boolean milestone
    
    Project project
    Employee responsible
    
    Date dateStart
    Date dateEnd
    
    String description
    
    String status
    String progress

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
        name blank:false, nullable: false, maxSize:128, unique:['project','tenant']
        description blank:false, nullable:false, maxSize:512
        project nullable:false
        responsible nullable:true
        status blank:false, inList:['New', 'Started', 'In-Progress','Completed', 'Delivered']
        dateStart nullable:true
        dateEnd nullable:true
        progress inList:['0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%']
        parent nullable:true 
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    @Override
    public String toString() {
        return name;
    }
}
