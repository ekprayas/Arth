
<%@ page import="org.sparsh.arth.hr.Employee" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
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
						
							<g:sortableColumn property="employeeNumber" title="${message(code: 'employee.employee.label', default: 'Employee')}" />
						
							<g:sortableColumn property="dateOfJoining" title="${message(code: 'employee.dateOfJoining.label', default: 'Date Of Joining')}" />
						
							<g:sortableColumn property="emailAddress" title="${message(code: 'employee.emailAddress.label', default: 'Email Address')}" />
						
							<g:sortableColumn property="firstName" title="${message(code: 'employee.dateOfBirth.label', default: 'Date of Birth')}" />
						
							<g:sortableColumn property="middleName" title="${message(code: 'employee.mobile.label', default: 'Mobile')}" />
						
							<g:sortableColumn property="lastName" title="${message(code: 'employee.user.label', default: 'User')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${employeeInstanceList}" status="i" var="employeeInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${employeeInstance.id}">${employeeInstance}</g:link></td>
						
							<td><g:formatDate date="${employeeInstance.dateOfJoining}" /></td>
						
							<td>${fieldValue(bean: employeeInstance, field: "emailAddress")}</td>
						
							<td><g:formatDate date="${employeeInstance.dateOfBirth}" /></td>
						
							<td>${fieldValue(bean: employeeInstance, field: "mobile")}</td>
						
							<td>${fieldValue(bean: employeeInstance, field: "user")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${employeeInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
