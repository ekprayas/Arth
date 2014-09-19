package org.sparsh



import org.junit.*
import grails.test.mixin.*

@TestFor(TenantConfigController)
@Mock(TenantConfig)
class TenantConfigControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tenantConfig/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.tenantConfigInstanceList.size() == 0
        assert model.tenantConfigInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.tenantConfigInstance != null
    }

    void testSave() {
        controller.save()

        assert model.tenantConfigInstance != null
        assert view == '/tenantConfig/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tenantConfig/show/1'
        assert controller.flash.message != null
        assert TenantConfig.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tenantConfig/list'

        populateValidParams(params)
        def tenantConfig = new TenantConfig(params)

        assert tenantConfig.save() != null

        params.id = tenantConfig.id

        def model = controller.show()

        assert model.tenantConfigInstance == tenantConfig
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tenantConfig/list'

        populateValidParams(params)
        def tenantConfig = new TenantConfig(params)

        assert tenantConfig.save() != null

        params.id = tenantConfig.id

        def model = controller.edit()

        assert model.tenantConfigInstance == tenantConfig
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tenantConfig/list'

        response.reset()

        populateValidParams(params)
        def tenantConfig = new TenantConfig(params)

        assert tenantConfig.save() != null

        // test invalid parameters in update
        params.id = tenantConfig.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tenantConfig/edit"
        assert model.tenantConfigInstance != null

        tenantConfig.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tenantConfig/show/$tenantConfig.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tenantConfig.clearErrors()

        populateValidParams(params)
        params.id = tenantConfig.id
        params.version = -1
        controller.update()

        assert view == "/tenantConfig/edit"
        assert model.tenantConfigInstance != null
        assert model.tenantConfigInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tenantConfig/list'

        response.reset()

        populateValidParams(params)
        def tenantConfig = new TenantConfig(params)

        assert tenantConfig.save() != null
        assert TenantConfig.count() == 1

        params.id = tenantConfig.id

        controller.delete()

        assert TenantConfig.count() == 0
        assert TenantConfig.get(tenantConfig.id) == null
        assert response.redirectedUrl == '/tenantConfig/list'
    }
}
