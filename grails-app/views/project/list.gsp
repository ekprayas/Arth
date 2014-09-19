
<%@ page import="org.sparsh.arth.pm.Project" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
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
							<g:sortableColumn property="title" title="${message(code: 'project.title.label', default: 'Title')}" />
							
							<g:sortableColumn property="deliveryDate" title="${message(code: 'project.status.label', default: 'Status')}" />	
												
							<g:sortableColumn property="dateRecieved" title="${message(code: 'project.dateRecieved.label', default: 'Date Recieved')}" />
						
							<g:sortableColumn property="deliveryDate" title="${message(code: 'project.deliveryDate.label', default: 'Delivery Date')}" />
						
							<g:sortableColumn property="deliveryDate" title="${message(code: 'project.dateStart.label', default: 'Start Date')}" />
							
							<g:sortableColumn property="deliveryDate" title="${message(code: 'project.dateEnd.label', default: 'End Date')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${projectInstanceList}" status="i" var="projectInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "title")}</g:link></td>
						
							<td>${fieldValue(bean: projectInstance, field: "status")}</td>
							
							<td><g:formatDate date="${projectInstance.dateRecieved}" /></td>
						
							<td><g:formatDate date="${projectInstance.deliveryDate}" /></td>
						
							<td><g:formatDate date="${projectInstance.dateStart}" /></td>
							
							<td><g:formatDate date="${projectInstance.dateEnd}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${projectInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
