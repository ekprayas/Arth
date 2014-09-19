
<%@ page import="org.sparsh.arth.hr.Department" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'department.label', default: 'Department')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'department.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="code" title="${message(code: 'department.code.label', default: 'Code')}" />						
							
							<g:sortableColumn property="isActive" title="${message(code: 'department.isActive.label', default: 'Is Active')}" />
							
							<g:sortableColumn property="dateCreated" title="${message(code: 'department.dateCreated.label', default: 'Date Created')}" />
												
							<g:sortableColumn property="lastUpdated" title="${message(code: 'department.lastUpdated.label', default: 'Last Updated')}" />
							
						</tr>
					</thead>
					<tbody>
					<g:each in="${departmentInstanceList}" status="i" var="departmentInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${departmentInstance.id}">${fieldValue(bean: departmentInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: departmentInstance, field: "code")}</td>
						
							<td><g:formatBoolean boolean="${departmentInstance.isActive}" /></td>
						
							<td><g:formatDate date="${departmentInstance.lastUpdated}" /></td>
						
							<td><g:formatDate date="${departmentInstance.dateCreated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${departmentInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
