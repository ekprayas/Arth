@artifact.package@
import org.sparsh.Tenant;

class @artifact.name@ {

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
}
