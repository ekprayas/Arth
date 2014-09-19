
<%@ page import="org.sparsh.arth.pm.ProjectResource" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'projectResource.label', default: 'ProjectResource')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.list.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
	    	<div class="large-12 columns">
	    		<g:if test="${flash.message}">
				<div class="alert-box" role="status">${flash.message}</div>
				</g:if>
				<table width="100%">
					<thead>
						<tr>
						
							<th><g:message code="projectResource.project.label" default="Project" /></th>
						
							<th><g:message code="projectResource.user.label" default="User" /></th>
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'projectResource.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'projectResource.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${projectResourceInstanceList}" status="i" var="projectResourceInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
												
							<td><g:link action="show" id="${projectResourceInstance.id}">${fieldValue(bean: projectResourceInstance, field: "project")}</g:link></td>
						
							<td>${fieldValue(bean: projectResourceInstance, field: "user")}</td>
						
							<td><g:formatDate date="${projectResourceInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${projectResourceInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${projectResourceInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
