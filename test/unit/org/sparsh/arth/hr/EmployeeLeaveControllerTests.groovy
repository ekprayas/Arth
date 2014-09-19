package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(EmployeeLeaveController)
@Mock(EmployeeLeave)
class EmployeeLeaveControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/employeeLeave/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.employeeLeaveInstanceList.size() == 0
        assert model.employeeLeaveInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.employeeLeaveInstance != null
    }

    void testSave() {
        controller.save()

        assert model.employeeLeaveInstance != null
        assert view == '/employeeLeave/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/employeeLeave/show/1'
        assert controller.flash.message != null
        assert EmployeeLeave.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeave/list'

        populateValidParams(params)
        def employeeLeave = new EmployeeLeave(params)

        assert employeeLeave.save() != null

        params.id = employeeLeave.id

        def model = controller.show()

        assert model.employeeLeaveInstance == employeeLeave
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeave/list'

        populateValidParams(params)
        def employeeLeave = new EmployeeLeave(params)

        assert employeeLeave.save() != null

        params.id = employeeLeave.id

        def model = controller.edit()

        assert model.employeeLeaveInstance == employeeLeave
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeave/list'

        response.reset()

        populateValidParams(params)
        def employeeLeave = new EmployeeLeave(params)

        assert employeeLeave.save() != null

        // test invalid parameters in update
        params.id = employeeLeave.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/employeeLeave/edit"
        assert model.employeeLeaveInstance != null

        employeeLeave.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/employeeLeave/show/$employeeLeave.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        employeeLeave.clearErrors()

        populateValidParams(params)
        params.id = employeeLeave.id
        params.version = -1
        controller.update()

        assert view == "/employeeLeave/edit"
        assert model.employeeLeaveInstance != null
        assert model.employeeLeaveInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeave/list'

        response.reset()

        populateValidParams(params)
        def employeeLeave = new EmployeeLeave(params)

        assert employeeLeave.save() != null
        assert EmployeeLeave.count() == 1

        params.id = employeeLeave.id

        controller.delete()

        assert EmployeeLeave.count() == 0
        assert EmployeeLeave.get(employeeLeave.id) == null
        assert response.redirectedUrl == '/employeeLeave/list'
    }
}
