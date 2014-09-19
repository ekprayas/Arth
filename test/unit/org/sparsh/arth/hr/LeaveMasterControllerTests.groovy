package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(LeaveMasterController)
@Mock(LeaveMaster)
class LeaveMasterControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/leaveMaster/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.leaveMasterInstanceList.size() == 0
        assert model.leaveMasterInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.leaveMasterInstance != null
    }

    void testSave() {
        controller.save()

        assert model.leaveMasterInstance != null
        assert view == '/leaveMaster/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/leaveMaster/show/1'
        assert controller.flash.message != null
        assert LeaveMaster.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveMaster/list'

        populateValidParams(params)
        def leaveMaster = new LeaveMaster(params)

        assert leaveMaster.save() != null

        params.id = leaveMaster.id

        def model = controller.show()

        assert model.leaveMasterInstance == leaveMaster
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveMaster/list'

        populateValidParams(params)
        def leaveMaster = new LeaveMaster(params)

        assert leaveMaster.save() != null

        params.id = leaveMaster.id

        def model = controller.edit()

        assert model.leaveMasterInstance == leaveMaster
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveMaster/list'

        response.reset()

        populateValidParams(params)
        def leaveMaster = new LeaveMaster(params)

        assert leaveMaster.save() != null

        // test invalid parameters in update
        params.id = leaveMaster.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/leaveMaster/edit"
        assert model.leaveMasterInstance != null

        leaveMaster.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/leaveMaster/show/$leaveMaster.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        leaveMaster.clearErrors()

        populateValidParams(params)
        params.id = leaveMaster.id
        params.version = -1
        controller.update()

        assert view == "/leaveMaster/edit"
        assert model.leaveMasterInstance != null
        assert model.leaveMasterInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/leaveMaster/list'

        response.reset()

        populateValidParams(params)
        def leaveMaster = new LeaveMaster(params)

        assert leaveMaster.save() != null
        assert LeaveMaster.count() == 1

        params.id = leaveMaster.id

        controller.delete()

        assert LeaveMaster.count() == 0
        assert LeaveMaster.get(leaveMaster.id) == null
        assert response.redirectedUrl == '/leaveMaster/list'
    }
}
