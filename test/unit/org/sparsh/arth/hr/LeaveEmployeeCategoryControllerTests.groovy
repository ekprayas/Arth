package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(LeaveEmployeeCategoryController)
@Mock(LeaveEmployeeCategory)
class LeaveEmployeeCategoryControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/leaveEmployeeCategory/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.leaveEmployeeCategoryInstanceList.size() == 0
        assert model.leaveEmployeeCategoryInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.leaveEmployeeCategoryInstance != null
    }

    void testSave() {
        controller.save()

        assert model.leaveEmployeeCategoryInstance != null
        assert view == '/leaveEmployeeCategory/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/leaveEmployeeCategory/show/1'
        assert controller.flash.message != null
        assert LeaveEmployeeCategory.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveEmployeeCategory/list'

        populateValidParams(params)
        def leaveEmployeeCategory = new LeaveEmployeeCategory(params)

        assert leaveEmployeeCategory.save() != null

        params.id = leaveEmployeeCategory.id

        def model = controller.show()

        assert model.leaveEmployeeCategoryInstance == leaveEmployeeCategory
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveEmployeeCategory/list'

        populateValidParams(params)
        def leaveEmployeeCategory = new LeaveEmployeeCategory(params)

        assert leaveEmployeeCategory.save() != null

        params.id = leaveEmployeeCategory.id

        def model = controller.edit()

        assert model.leaveEmployeeCategoryInstance == leaveEmployeeCategory
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/leaveEmployeeCategory/list'

        response.reset()

        populateValidParams(params)
        def leaveEmployeeCategory = new LeaveEmployeeCategory(params)

        assert leaveEmployeeCategory.save() != null

        // test invalid parameters in update
        params.id = leaveEmployeeCategory.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/leaveEmployeeCategory/edit"
        assert model.leaveEmployeeCategoryInstance != null

        leaveEmployeeCategory.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/leaveEmployeeCategory/show/$leaveEmployeeCategory.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        leaveEmployeeCategory.clearErrors()

        populateValidParams(params)
        params.id = leaveEmployeeCategory.id
        params.version = -1
        controller.update()

        assert view == "/leaveEmployeeCategory/edit"
        assert model.leaveEmployeeCategoryInstance != null
        assert model.leaveEmployeeCategoryInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/leaveEmployeeCategory/list'

        response.reset()

        populateValidParams(params)
        def leaveEmployeeCategory = new LeaveEmployeeCategory(params)

        assert leaveEmployeeCategory.save() != null
        assert LeaveEmployeeCategory.count() == 1

        params.id = leaveEmployeeCategory.id

        controller.delete()

        assert LeaveEmployeeCategory.count() == 0
        assert LeaveEmployeeCategory.get(leaveEmployeeCategory.id) == null
        assert response.redirectedUrl == '/leaveEmployeeCategory/list'
    }
}
