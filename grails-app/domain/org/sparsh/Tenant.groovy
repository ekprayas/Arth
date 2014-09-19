package org.sparsh

class Tenant {
    String name
    String url
    String email
    String address    

    Date dateCreated
    Date lastUpdated

    static constraints = {
        name blank: false,nullable:false , maxSize: 128
        url blank: false,nullable:false, url:true , maxSize: 128
        email blank: false,nullable:false, email:true ,  maxSize: 128, unique:true
        address blank:false,nullable:false, maxSize: 512
    }

    @Override
    public String toString() {
        return name
    }
}
