package org.sparsh

class Authority {

	String authority
    String description
    static mapping = { cache true }

    static constraints = {
        authority blank: false, unique: true
        description blank:false
    }

    @Override
    public String toString() {
        // TODO Auto-generated method stub
        return authority + ' - ' +description;
    }
}
