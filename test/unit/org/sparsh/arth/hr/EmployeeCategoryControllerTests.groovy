package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(EmployeeCategoryController)
@Mock(EmployeeCategory)
class EmployeeCategoryControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/employeeCategory/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.employeeCategoryInstanceList.size() == 0
        assert model.employeeCategoryInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.employeeCategoryInstance != null
    }

    void testSave() {
        controller.save()

        assert model.employeeCategoryInstance != null
        assert view == '/employeeCategory/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/employeeCategory/show/1'
        assert controller.flash.message != null
        assert EmployeeCategory.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeCategory/list'

        populateValidParams(params)
        def employeeCategory = new EmployeeCategory(params)

        assert employeeCategory.save() != null

        params.id = employeeCategory.id

        def model = controller.show()

        assert model.employeeCategoryInstance == employeeCategory
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeCategory/list'

        populateValidParams(params)
        def employeeCategory = new EmployeeCategory(params)

        assert employeeCategory.save() != null

        params.id = employeeCategory.id

        def model = controller.edit()

        assert model.employeeCategoryInstance == employeeCategory
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeCategory/list'

        response.reset()

        populateValidParams(params)
        def employeeCategory = new EmployeeCategory(params)

        assert employeeCategory.save() != null

        // test invalid parameters in update
        params.id = employeeCategory.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/employeeCategory/edit"
        assert model.employeeCategoryInstance != null

        employeeCategory.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/employeeCategory/show/$employeeCategory.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        employeeCategory.clearErrors()

        populateValidParams(params)
        params.id = employeeCategory.id
        params.version = -1
        controller.update()

        assert view == "/employeeCategory/edit"
        assert model.employeeCategoryInstance != null
        assert model.employeeCategoryInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/employeeCategory/list'

        response.reset()

        populateValidParams(params)
        def employeeCategory = new EmployeeCategory(params)

        assert employeeCategory.save() != null
        assert EmployeeCategory.count() == 1

        params.id = employeeCategory.id

        controller.delete()

        assert EmployeeCategory.count() == 0
        assert EmployeeCategory.get(employeeCategory.id) == null
        assert response.redirectedUrl == '/employeeCategory/list'
    }
}
