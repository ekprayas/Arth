<%@ page import="org.sparsh.arth.hr.EmployeeCategory" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeCategory.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeCategoryInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${employeeCategoryInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeCategory.code.label" default="Code" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeCategoryInstance, field: 'code', 'error')} required">
			  <g:textField name="code" maxlength="32" required="" value="${employeeCategoryInstance?.code}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeCategory.isActive.label" default="Is Active" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeCategoryInstance, field: 'isActive', 'error')} ">
			  <g:checkBox name="isActive" value="${employeeCategoryInstance?.isActive}" />
			</div>
		</div>

