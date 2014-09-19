<%@ page import="org.sparsh.User" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.username.label" default="Username" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
			  <g:textField name="username" required="" value="${userInstance?.username}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.password.label" default="Password" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
			  <g:textField name="password" required="" value="${userInstance?.password}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.firstname.label" default="Firstname" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'firstname', 'error')} ">
			  <g:textField name="firstname" maxlength="128" value="${userInstance?.firstname}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.lastname.label" default="Lastname" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'lastname', 'error')} ">
			  <g:textField name="lastname" maxlength="128" value="${userInstance?.lastname}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.email.label" default="Email" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'email', 'error')} ">
			  <g:field type="email" name="email" maxlength="128" value="${userInstance?.email}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.tenant.label" default="Tenant" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'tenant', 'error')} required">
			  <g:select id="tenant" name="tenant.id" from="${org.sparsh.Tenant.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${userInstance?.tenant?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.accountExpired.label" default="Account Expired" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
			  <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.accountLocked.label" default="Account Locked" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
			  <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.enabled.label" default="Enabled" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
			  <g:checkBox name="enabled" value="${userInstance?.enabled}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="user.passwordExpired.label" default="Password Expired" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
			  <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
			</div>
		</div>

