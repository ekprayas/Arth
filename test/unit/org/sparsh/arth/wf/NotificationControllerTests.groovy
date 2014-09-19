package org.sparsh.arth.wf



import org.junit.*
import grails.test.mixin.*

@TestFor(NotificationController)
@Mock(Notification)
class NotificationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/notification/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.notificationInstanceList.size() == 0
        assert model.notificationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.notificationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.notificationInstance != null
        assert view == '/notification/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/notification/show/1'
        assert controller.flash.message != null
        assert Notification.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/notification/list'

        populateValidParams(params)
        def notification = new Notification(params)

        assert notification.save() != null

        params.id = notification.id

        def model = controller.show()

        assert model.notificationInstance == notification
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/notification/list'

        populateValidParams(params)
        def notification = new Notification(params)

        assert notification.save() != null

        params.id = notification.id

        def model = controller.edit()

        assert model.notificationInstance == notification
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/notification/list'

        response.reset()

        populateValidParams(params)
        def notification = new Notification(params)

        assert notification.save() != null

        // test invalid parameters in update
        params.id = notification.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/notification/edit"
        assert model.notificationInstance != null

        notification.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/notification/show/$notification.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        notification.clearErrors()

        populateValidParams(params)
        params.id = notification.id
        params.version = -1
        controller.update()

        assert view == "/notification/edit"
        assert model.notificationInstance != null
        assert model.notificationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/notification/list'

        response.reset()

        populateValidParams(params)
        def notification = new Notification(params)

        assert notification.save() != null
        assert Notification.count() == 1

        params.id = notification.id

        controller.delete()

        assert Notification.count() == 0
        assert Notification.get(notification.id) == null
        assert response.redirectedUrl == '/notification/list'
    }
}
