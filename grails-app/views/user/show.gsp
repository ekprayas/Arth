
<%@ page import="org.sparsh.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				  <li class="right"><span class="radius secondary label"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
	    	<div class="large-12 columns">
	    		<g:if test="${flash.message}">
				<div class="alert-box" role="status">${flash.message}</div>
				</g:if>
				<div class="panel">
					
						<g:if test="${userInstance?.username}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.username.label" default="Username" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${userInstance}" field="username"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.password}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.password.label" default="Password" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${userInstance}" field="password"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.firstname}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.firstname.label" default="Firstname" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${userInstance}" field="firstname"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.lastname}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.lastname.label" default="Lastname" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${userInstance}" field="lastname"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.email}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.email.label" default="Email" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${userInstance}" field="email"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.tenant}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.tenant.label" default="Tenant" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="tenant" action="show" id="${userInstance?.tenant?.id}">${userInstance?.tenant?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.accountExpired}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.accountExpired.label" default="Account Expired" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.accountLocked}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.accountLocked.label" default="Account Locked" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${userInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.enabled}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.enabled.label" default="Enabled" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${userInstance?.enabled}" /></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${userInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${userInstance?.passwordExpired}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="user.passwordExpired.label" default="Password Expired" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></label>								
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${userInstance?.id}" />
						<g:link class="small button" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
