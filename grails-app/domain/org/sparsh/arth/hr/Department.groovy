package org.sparsh.arth.hr

import java.util.Date;

import org.sparsh.Tenant;

class Department {

    String name
    String code

    boolean isActive
    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        name blank:false , maxSize: 128
        code blank:false , maxSize: 32, unique :'tenant'
        tenant nullable:false
    }

    static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }

    public String toString() {
        return code + " [" + name + "]";
    }
}
