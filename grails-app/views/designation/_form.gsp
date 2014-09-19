<%@ page import="org.sparsh.arth.hr.Designation" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="designation.employeeCategory.label" default="Employee Category" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: designationInstance, field: 'employeeCategory', 'error')} required">
			  <g:select id="employeeCategory" name="employeeCategory.id" from="${org.sparsh.arth.hr.EmployeeCategory.findAllByTenantAndIsActive(loggedInUser.tenant, true)}" optionKey="id" required="" value="${designationInstance?.employeeCategory?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="designation.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: designationInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${designationInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="designation.code.label" default="Code" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: designationInstance, field: 'code', 'error')} required">
			  <g:textField name="code" maxlength="32" required="" value="${designationInstance?.code}"/>
			</div>
		</div>
