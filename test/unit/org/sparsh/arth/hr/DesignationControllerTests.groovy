package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(DesignationController)
@Mock(Designation)
class DesignationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/designation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.designationInstanceList.size() == 0
        assert model.designationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.designationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.designationInstance != null
        assert view == '/designation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/designation/show/1'
        assert controller.flash.message != null
        assert Designation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/designation/list'

        populateValidParams(params)
        def designation = new Designation(params)

        assert designation.save() != null

        params.id = designation.id

        def model = controller.show()

        assert model.designationInstance == designation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/designation/list'

        populateValidParams(params)
        def designation = new Designation(params)

        assert designation.save() != null

        params.id = designation.id

        def model = controller.edit()

        assert model.designationInstance == designation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/designation/list'

        response.reset()

        populateValidParams(params)
        def designation = new Designation(params)

        assert designation.save() != null

        // test invalid parameters in update
        params.id = designation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/designation/edit"
        assert model.designationInstance != null

        designation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/designation/show/$designation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        designation.clearErrors()

        populateValidParams(params)
        params.id = designation.id
        params.version = -1
        controller.update()

        assert view == "/designation/edit"
        assert model.designationInstance != null
        assert model.designationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/designation/list'

        response.reset()

        populateValidParams(params)
        def designation = new Designation(params)

        assert designation.save() != null
        assert Designation.count() == 1

        params.id = designation.id

        controller.delete()

        assert Designation.count() == 0
        assert Designation.get(designation.id) == null
        assert response.redirectedUrl == '/designation/list'
    }
}
