package org.sparsh.arth.hr



import org.junit.*
import grails.test.mixin.*

@TestFor(EmployeeLeaveTransactionController)
@Mock(EmployeeLeaveTransaction)
class EmployeeLeaveTransactionControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/employeeLeaveTransaction/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.employeeLeaveTransactionInstanceList.size() == 0
        assert model.employeeLeaveTransactionInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.employeeLeaveTransactionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.employeeLeaveTransactionInstance != null
        assert view == '/employeeLeaveTransaction/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/employeeLeaveTransaction/show/1'
        assert controller.flash.message != null
        assert EmployeeLeaveTransaction.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeaveTransaction/list'

        populateValidParams(params)
        def employeeLeaveTransaction = new EmployeeLeaveTransaction(params)

        assert employeeLeaveTransaction.save() != null

        params.id = employeeLeaveTransaction.id

        def model = controller.show()

        assert model.employeeLeaveTransactionInstance == employeeLeaveTransaction
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeaveTransaction/list'

        populateValidParams(params)
        def employeeLeaveTransaction = new EmployeeLeaveTransaction(params)

        assert employeeLeaveTransaction.save() != null

        params.id = employeeLeaveTransaction.id

        def model = controller.edit()

        assert model.employeeLeaveTransactionInstance == employeeLeaveTransaction
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeaveTransaction/list'

        response.reset()

        populateValidParams(params)
        def employeeLeaveTransaction = new EmployeeLeaveTransaction(params)

        assert employeeLeaveTransaction.save() != null

        // test invalid parameters in update
        params.id = employeeLeaveTransaction.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/employeeLeaveTransaction/edit"
        assert model.employeeLeaveTransactionInstance != null

        employeeLeaveTransaction.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/employeeLeaveTransaction/show/$employeeLeaveTransaction.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        employeeLeaveTransaction.clearErrors()

        populateValidParams(params)
        params.id = employeeLeaveTransaction.id
        params.version = -1
        controller.update()

        assert view == "/employeeLeaveTransaction/edit"
        assert model.employeeLeaveTransactionInstance != null
        assert model.employeeLeaveTransactionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/employeeLeaveTransaction/list'

        response.reset()

        populateValidParams(params)
        def employeeLeaveTransaction = new EmployeeLeaveTransaction(params)

        assert employeeLeaveTransaction.save() != null
        assert EmployeeLeaveTransaction.count() == 1

        params.id = employeeLeaveTransaction.id

        controller.delete()

        assert EmployeeLeaveTransaction.count() == 0
        assert EmployeeLeaveTransaction.get(employeeLeaveTransaction.id) == null
        assert response.redirectedUrl == '/employeeLeaveTransaction/list'
    }
}
