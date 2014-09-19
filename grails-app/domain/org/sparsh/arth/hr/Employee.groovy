package org.sparsh.arth.hr

import org.sparsh.Tenant
import org.sparsh.User

class Employee{
    String employeeNumber

    String firstName
    String middleName
    String lastName

    Date dateOfBirth
    Date dateOfJoining

    String sex
    String religion
    String bloodGroup
    String nationality
    String language
    
    String addressLine1
    String addressLine2
    String addressLine3

    String city
    String state
    String country

    String pinCode
    
    String homePhone
    String officePhone
    String mobile
    
    String emailAddress

    Department department
    Designation designation
    
    boolean archive
    
    User user
    Tenant tenant

    Date dateCreated
    Date lastUpdated

    static constraints = {
        employeeNumber blank:false, unique: 'tenant'
        dateOfJoining nullable:false
        emailAddress email:true , blank:false
        firstName blank:false , maxSize: 128
        middleName maxSize: 128
        lastName blank:false , maxSize: 128
        dateOfBirth nullable:false
        sex blank:false, inList:['Male', 'Female', 'Other']
        bloodGroup blank:true , MaxSize: 5
        nationality blank:true , maxSize : 128
        language blank:true , maxSize : 128
        religion blank:true , maxSize : 128
        department nullable:false
        designation nullable:false
        tenant nullable:false
        user nullable:true
        
        pinCode matches:'^([0-9]{6})$'
        country blank:false , inList:["India"]
        tenant nullable:true
    }

    static safeList(Tenant tenant){
        findAllByTenant(tenant);
    }
    
    public String toString() {
        return firstName + " " + lastName +" [" + employeeNumber +"]";
    }
}
