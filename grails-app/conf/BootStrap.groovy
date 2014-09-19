import org.sparsh.*

class BootStrap {

    def init = { servletContext ->
        Authority.findByAuthority('ROLE_SUPER_ADMIN') ?: new Authority(authority: 'ROLE_SUPER_ADMIN', description:'SUPER ADMIN').save(failOnError: true)
        Authority.findByAuthority('ROLE_ADMIN') ?: new Authority(authority: 'ROLE_ADMIN',description:'Admin Role').save(failOnError: true)        
        Authority.findByAuthority('ROLE_EMPLOYEE') ?: new Authority(authority: 'ROLE_EMPLOYEE', description:'Default Employee Role').save(failOnError: true)

        //Module specific
        Authority.findByAuthority('ROLE_HR') ?: new Authority(authority: 'ROLE_HR', description:'Default HR MODULE Role').save(failOnError: true)
        Authority.findByAuthority('ROLE_PM') ?: new Authority(authority: 'ROLE_PM', description:'Default PM MODULE Role').save(failOnError: true)
        Authority.findByAuthority('ROLE_TM') ?: new Authority(authority: 'ROLE_TM', description:'Default TM MODULE Role').save(failOnError: true)
        Authority.findByAuthority('ROLE_EM') ?: new Authority(authority: 'ROLE_EM', description:'Default EM MODULE Role').save(failOnError: true)
        Authority.findByAuthority('ROLE_IM') ?: new Authority(authority: 'ROLE_IM', description:'Default IM MODULE Role').save(failOnError: true)
        
        def superComp = Tenant.findByName('Arth by Cube Hut')?: new Tenant(name: 'Arth by Cube Hut', url:'http://cubehut.in' , email:'support@cubehut.in', address:'Dummy Address').save(failOnError: true)

        def superUser = User.findByUsername('admin')?: new User(tenant: superComp, username: 'admin', enabled: true, password: 'admin', firstname:"Super", lastname:"Admin", email:'support@cubehut.in' ).save(failOnError: true)

        if(!superUser.authorities.contains(Authority.findByAuthority('ROLE_SUPER_ADMIN'))){
            UserAuthority.createSuperAdmin(superUser)
        }
        def tenant = Tenant.get(2)
              
        
    }
    def destroy = {
    }
}
