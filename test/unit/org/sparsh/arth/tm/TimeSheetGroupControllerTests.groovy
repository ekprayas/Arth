package org.sparsh.arth.tm



import org.junit.*
import grails.test.mixin.*

@TestFor(TimeSheetGroupController)
@Mock(TimeSheetGroup)
class TimeSheetGroupControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/timeSheetGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.timeSheetGroupInstanceList.size() == 0
        assert model.timeSheetGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.timeSheetGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.timeSheetGroupInstance != null
        assert view == '/timeSheetGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/timeSheetGroup/show/1'
        assert controller.flash.message != null
        assert TimeSheetGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/timeSheetGroup/list'

        populateValidParams(params)
        def timeSheetGroup = new TimeSheetGroup(params)

        assert timeSheetGroup.save() != null

        params.id = timeSheetGroup.id

        def model = controller.show()

        assert model.timeSheetGroupInstance == timeSheetGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/timeSheetGroup/list'

        populateValidParams(params)
        def timeSheetGroup = new TimeSheetGroup(params)

        assert timeSheetGroup.save() != null

        params.id = timeSheetGroup.id

        def model = controller.edit()

        assert model.timeSheetGroupInstance == timeSheetGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/timeSheetGroup/list'

        response.reset()

        populateValidParams(params)
        def timeSheetGroup = new TimeSheetGroup(params)

        assert timeSheetGroup.save() != null

        // test invalid parameters in update
        params.id = timeSheetGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/timeSheetGroup/edit"
        assert model.timeSheetGroupInstance != null

        timeSheetGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/timeSheetGroup/show/$timeSheetGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        timeSheetGroup.clearErrors()

        populateValidParams(params)
        params.id = timeSheetGroup.id
        params.version = -1
        controller.update()

        assert view == "/timeSheetGroup/edit"
        assert model.timeSheetGroupInstance != null
        assert model.timeSheetGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/timeSheetGroup/list'

        response.reset()

        populateValidParams(params)
        def timeSheetGroup = new TimeSheetGroup(params)

        assert timeSheetGroup.save() != null
        assert TimeSheetGroup.count() == 1

        params.id = timeSheetGroup.id

        controller.delete()

        assert TimeSheetGroup.count() == 0
        assert TimeSheetGroup.get(timeSheetGroup.id) == null
        assert response.redirectedUrl == '/timeSheetGroup/list'
    }
}
