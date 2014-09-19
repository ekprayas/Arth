<%@ page import="org.sparsh.Tenant" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenant.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${tenantInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenant.url.label" default="Url" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantInstance, field: 'url', 'error')} required">
			  <g:field type="url" name="url" maxlength="128" required="" value="${tenantInstance?.url}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenant.email.label" default="Email" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantInstance, field: 'email', 'error')} required">
			  <g:field type="email" name="email" maxlength="128" required="" value="${tenantInstance?.email}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="tenant.address.label" default="Address" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: tenantInstance, field: 'address', 'error')} required">
			  <g:textArea name="address" cols="40" rows="5" maxlength="512" required="" value="${tenantInstance?.address}"/>
			</div>
		</div>

