<%@ page import="org.sparsh.arth.hr.Department" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="department.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: departmentInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${departmentInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="department.code.label" default="Code" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: departmentInstance, field: 'code', 'error')} required">
			  <g:textField name="code" maxlength="32" required="" value="${departmentInstance?.code}"/>
			</div>
		</div>


		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="department.isActive.label" default="Is Active" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: departmentInstance, field: 'isActive', 'error')} ">
			  <g:checkBox name="isActive" value="${departmentInstance?.isActive}" />
			</div>
		</div>

