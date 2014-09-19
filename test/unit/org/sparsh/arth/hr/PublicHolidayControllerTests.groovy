package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(PublicHolidayController)
@Mock(PublicHoliday)
class PublicHolidayControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/publicHoliday/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.publicHolidayInstanceList.size() == 0
        assert model.publicHolidayInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.publicHolidayInstance != null
    }

    void testSave() {
        controller.save()

        assert model.publicHolidayInstance != null
        assert view == '/publicHoliday/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/publicHoliday/show/1'
        assert controller.flash.message != null
        assert PublicHoliday.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/publicHoliday/list'

        populateValidParams(params)
        def publicHoliday = new PublicHoliday(params)

        assert publicHoliday.save() != null

        params.id = publicHoliday.id

        def model = controller.show()

        assert model.publicHolidayInstance == publicHoliday
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/publicHoliday/list'

        populateValidParams(params)
        def publicHoliday = new PublicHoliday(params)

        assert publicHoliday.save() != null

        params.id = publicHoliday.id

        def model = controller.edit()

        assert model.publicHolidayInstance == publicHoliday
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/publicHoliday/list'

        response.reset()

        populateValidParams(params)
        def publicHoliday = new PublicHoliday(params)

        assert publicHoliday.save() != null

        // test invalid parameters in update
        params.id = publicHoliday.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/publicHoliday/edit"
        assert model.publicHolidayInstance != null

        publicHoliday.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/publicHoliday/show/$publicHoliday.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        publicHoliday.clearErrors()

        populateValidParams(params)
        params.id = publicHoliday.id
        params.version = -1
        controller.update()

        assert view == "/publicHoliday/edit"
        assert model.publicHolidayInstance != null
        assert model.publicHolidayInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/publicHoliday/list'

        response.reset()

        populateValidParams(params)
        def publicHoliday = new PublicHoliday(params)

        assert publicHoliday.save() != null
        assert PublicHoliday.count() == 1

        params.id = publicHoliday.id

        controller.delete()

        assert PublicHoliday.count() == 0
        assert PublicHoliday.get(publicHoliday.id) == null
        assert response.redirectedUrl == '/publicHoliday/list'
    }
}
