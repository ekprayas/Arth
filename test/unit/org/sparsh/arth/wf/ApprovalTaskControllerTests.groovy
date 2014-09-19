package org.sparsh.arth.wf



import org.junit.*
import grails.test.mixin.*

@TestFor(ApprovalTaskController)
@Mock(ApprovalTask)
class ApprovalTaskControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/approvalTask/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.approvalTaskInstanceList.size() == 0
        assert model.approvalTaskInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.approvalTaskInstance != null
    }

    void testSave() {
        controller.save()

        assert model.approvalTaskInstance != null
        assert view == '/approvalTask/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/approvalTask/show/1'
        assert controller.flash.message != null
        assert ApprovalTask.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/approvalTask/list'

        populateValidParams(params)
        def approvalTask = new ApprovalTask(params)

        assert approvalTask.save() != null

        params.id = approvalTask.id

        def model = controller.show()

        assert model.approvalTaskInstance == approvalTask
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/approvalTask/list'

        populateValidParams(params)
        def approvalTask = new ApprovalTask(params)

        assert approvalTask.save() != null

        params.id = approvalTask.id

        def model = controller.edit()

        assert model.approvalTaskInstance == approvalTask
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/approvalTask/list'

        response.reset()

        populateValidParams(params)
        def approvalTask = new ApprovalTask(params)

        assert approvalTask.save() != null

        // test invalid parameters in update
        params.id = approvalTask.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/approvalTask/edit"
        assert model.approvalTaskInstance != null

        approvalTask.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/approvalTask/show/$approvalTask.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        approvalTask.clearErrors()

        populateValidParams(params)
        params.id = approvalTask.id
        params.version = -1
        controller.update()

        assert view == "/approvalTask/edit"
        assert model.approvalTaskInstance != null
        assert model.approvalTaskInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/approvalTask/list'

        response.reset()

        populateValidParams(params)
        def approvalTask = new ApprovalTask(params)

        assert approvalTask.save() != null
        assert ApprovalTask.count() == 1

        params.id = approvalTask.id

        controller.delete()

        assert ApprovalTask.count() == 0
        assert ApprovalTask.get(approvalTask.id) == null
        assert response.redirectedUrl == '/approvalTask/list'
    }
}
