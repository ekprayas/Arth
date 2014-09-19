
<%@ page import="org.sparsh.arth.hr.EmployeeLeave" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employeeLeave.label', default: 'EmployeeLeave')}" />
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
						
							<th><g:message code="employeeLeave.employee.label" default="Employee" /></th>
						
							<th><g:message code="employeeLeave.leaveMaster.label" default="Leave Master" /></th>
						
							<g:sortableColumn property="balance" title="${message(code: 'employeeLeave.balance.label', default: 'Balance')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'employeeLeave.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'employeeLeave.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${employeeLeaveInstanceList}" status="i" var="employeeLeaveInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${employeeLeaveInstance.id}">${fieldValue(bean: employeeLeaveInstance, field: "employee")}</g:link></td>
						
							<td>${fieldValue(bean: employeeLeaveInstance, field: "leaveMaster")}</td>
						
							<td>${fieldValue(bean: employeeLeaveInstance, field: "balance")}</td>
						
							<td><g:formatDate date="${employeeLeaveInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${employeeLeaveInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${employeeLeaveInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
