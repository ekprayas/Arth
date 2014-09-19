
<%@ page import="org.sparsh.arth.pm.ProjectResource" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'projectResource.label', default: 'ProjectResource')}" />
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
					
						<g:if test="${projectResourceInstance?.project}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="projectResource.project.label" default="Project" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="project" action="show" id="${projectResourceInstance?.project?.id}">${projectResourceInstance?.project?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectResourceInstance?.user}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="projectResource.user.label" default="User" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="employee" action="show" id="${projectResourceInstance?.user?.id}">${projectResourceInstance?.user?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectResourceInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="projectResource.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectResourceInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectResourceInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="projectResource.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectResourceInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${projectResourceInstance?.id}" />
						<g:link class="small button" action="edit" id="${projectResourceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
