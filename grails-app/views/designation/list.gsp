
<%@ page import="org.sparsh.arth.hr.Designation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'designation.label', default: 'Designation')}" />
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
							<g:sortableColumn property="name" title="${message(code: 'designation.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="code" title="${message(code: 'designation.code.label', default: 'Code')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'designation.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'designation.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${designationInstanceList}" status="i" var="designationInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${designationInstance.id}">${fieldValue(bean: designationInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: designationInstance, field: "code")}</td>
						
							<td><g:formatDate date="${designationInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${designationInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${designationInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
