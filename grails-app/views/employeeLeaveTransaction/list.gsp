
<%@ page import="org.sparsh.arth.hr.EmployeeLeaveTransaction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction')}" />
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
							<g:sortableColumn property="id" title="${message(code: 'employeeLeaveTransaction.leaveMaster.label', default: 'Leave')}" />
						
							<g:sortableColumn property="appliedHours" title="${message(code: 'employeeLeaveTransaction.appliedHours.label', default: 'Applied Hours')}" />
						
							<g:sortableColumn property="startDate" title="${message(code: 'employeeLeaveTransaction.startDate.label', default: 'Start Date')}" />
						
							<g:sortableColumn property="comments" title="${message(code: 'employeeLeaveTransaction.comments.label', default: 'Comments')}" />
							
							<g:sortableColumn property="status" title="${message(code: 'employeeLeaveTransaction.status.label', default: 'Status')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${employeeLeaveTransactionInstanceList}" status="i" var="employeeLeaveTransactionInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
												
							<td><g:link action="show" id="${employeeLeaveTransactionInstance.id}">${fieldValue(bean: employeeLeaveTransactionInstance, field: "leaveMaster")}</g:link></td>
						
							<td>${fieldValue(bean: employeeLeaveTransactionInstance, field: "appliedHours")}</td>
						
							<td><g:formatDate date="${employeeLeaveTransactionInstance.startDate}" /></td>
						
							<td>${fieldValue(bean: employeeLeaveTransactionInstance, field: "comments")}</td>
							
							<td>${fieldValue(bean: employeeLeaveTransactionInstance, field: "status")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${employeeLeaveTransactionInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
