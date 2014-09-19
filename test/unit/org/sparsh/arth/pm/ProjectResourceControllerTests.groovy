package org.sparsh.arth.pm



import org.junit.*
import grails.test.mixin.*

@TestFor(ProjectResourceController)
@Mock(ProjectResource)
class ProjectResourceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/projectResource/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.projectResourceInstanceList.size() == 0
        assert model.projectResourceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.projectResourceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.projectResourceInstance != null
        assert view == '/projectResource/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/projectResource/show/1'
        assert controller.flash.message != null
        assert ProjectResource.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/projectResource/list'

        populateValidParams(params)
        def projectResource = new ProjectResource(params)

        assert projectResource.save() != null

        params.id = projectResource.id

        def model = controller.show()

        assert model.projectResourceInstance == projectResource
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/projectResource/list'

        populateValidParams(params)
        def projectResource = new ProjectResource(params)

        assert projectResource.save() != null

        params.id = projectResource.id

        def model = controller.edit()

        assert model.projectResourceInstance == projectResource
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/projectResource/list'

        response.reset()

        populateValidParams(params)
        def projectResource = new ProjectResource(params)

        assert projectResource.save() != null

        // test invalid parameters in update
        params.id = projectResource.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/projectResource/edit"
        assert model.projectResourceInstance != null

        projectResource.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/projectResource/show/$projectResource.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        projectResource.clearErrors()

        populateValidParams(params)
        params.id = projectResource.id
        params.version = -1
        controller.update()

        assert view == "/projectResource/edit"
        assert model.projectResourceInstance != null
        assert model.projectResourceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/projectResource/list'

        response.reset()

        populateValidParams(params)
        def projectResource = new ProjectResource(params)

        assert projectResource.save() != null
        assert ProjectResource.count() == 1

        params.id = projectResource.id

        controller.delete()

        assert ProjectResource.count() == 0
        assert ProjectResource.get(projectResource.id) == null
        assert response.redirectedUrl == '/projectResource/list'
    }
}
