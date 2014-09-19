
<%@ page import="org.sparsh.arth.pm.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse">
	    			<h2 class="subheader"><g:message code="default.list.label" args="[entityName]" /></h2>
	    			<h4 class="subheader">${projectInstance }</h4>
	    		</div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link action="create" id="${projectInstance?.id }"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
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
							<th><g:message code="task.name.label" default="Name" /></th>
						
							<th><g:message code="task.responsible.label" default="Responsible" /></th>
							
							<th><g:message code="task.status.label" default="Status" /></th>
							
							<th><g:message code="task.progress.label" default="Progress" /></th>
							
							<th><g:message code="task.hours.label" default="Hours" /></th>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${taskInstanceList}" status="i" var="taskInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
												
							<td><g:link action="show" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: taskInstance, field: "responsible")}</td>
						
							<td>${fieldValue(bean: taskInstance, field: "status")}</td>
						
							<td>${fieldValue(bean: taskInstance, field: "progress")}</td>
							
							<td>${fieldValue(bean: taskInstance, field: "hours")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${taskInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
