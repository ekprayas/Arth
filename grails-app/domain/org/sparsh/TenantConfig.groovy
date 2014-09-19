package org.sparsh
import org.apache.commons.lang.RandomStringUtils;
import org.sparsh.Tenant;

class TenantConfig {
    
    String name
    String value

    Tenant tenant
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        name blank:false, nullable:false, unique:['tenant']
        value nullable:false 
        tenant nullable:false
    }
	
	static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    static TenantConfig createWithDefaultValue(Tenant tenant){
        //create all config data with default value- If you add and remove something from here update views as well
        new TenantConfig(name:TenantConfigConstants.ORGANISATION_CODE, value:RandomStringUtils.randomAlphabetic(2), tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.WORKING_HRS_PER_DAY, value:'8', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.CALENDAR_END_DAY, value:'31', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.CALENDAR_END_MONTH, value:'12', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.AUTO_INCREMENT_EMPLOYEE_NUMBER, value:'true', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.NEXT_EMPLOYEE_NUMBER, value:'1001', tenant:tenant).save(flush: true, insert: true)
        
        new TenantConfig(name:TenantConfigConstants.ADVANCE_TIMESHEET_ALLOWED_DAYS, value:'15', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.WORKING_DAYS, value:'2,3,4,5,6', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.LEAVE_APPROVAL, value:'HRPOC,PRPOC', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.TIMESHEET_APPROVAL, value:'HRPOC,PRPOC', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.EXPENSE_APPROVAL, value:'HRPOC', tenant:tenant).save(flush: true, insert: true)
        new TenantConfig(name:TenantConfigConstants.CAPSULE_WEEKENDS, value:'false', tenant:tenant).save(flush: true, insert: true)
    }
    
}
