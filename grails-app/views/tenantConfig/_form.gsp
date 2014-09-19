<%@ page import="org.sparsh.TenantConfig" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenantConfig.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantConfigInstance, field: 'name', 'error')} required">
			  <g:textField name="name" required="" value="${tenantConfigInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenantConfig.value.label" default="Value" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantConfigInstance, field: 'value', 'error')} ">
			  <g:textField name="value" value="${tenantConfigInstance?.value}"/>
			</div>
		</div>

