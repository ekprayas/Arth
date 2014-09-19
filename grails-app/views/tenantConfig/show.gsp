
<%@ page import="org.sparsh.TenantConfig" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tenantConfig.label', default: 'TenantConfig')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
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
					
						<g:if test="${tenantConfigInstance?.name}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="tenantConfig.name.label" default="Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${tenantConfigInstance}" field="name"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${tenantConfigInstance?.value}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="tenantConfig.value.label" default="Value" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${tenantConfigInstance}" field="value"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${tenantConfigInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="tenantConfig.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${tenantConfigInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${tenantConfigInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="tenantConfig.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${tenantConfigInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${tenantConfigInstance?.id}" />
						<g:link class="small button" action="edit" id="${tenantConfigInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
