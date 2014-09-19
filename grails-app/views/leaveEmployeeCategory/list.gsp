
<%@ page import="org.sparsh.arth.hr.LeaveEmployeeCategory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'leaveEmployeeCategory.label', default: 'LeaveEmployeeCategory')}" />
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
						
							<th><g:message code="leaveEmployeeCategory.leaveMaster.label" default="Leave Master" /></th>
						
							<th><g:message code="leaveEmployeeCategory.employeeCategory.label" default="Employee Category" /></th>
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'leaveEmployeeCategory.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'leaveEmployeeCategory.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${leaveEmployeeCategoryInstanceList}" status="i" var="leaveEmployeeCategoryInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${leaveEmployeeCategoryInstance.id}">${fieldValue(bean: leaveEmployeeCategoryInstance, field: "leaveMaster")}</g:link></td>
						
							<td>${fieldValue(bean: leaveEmployeeCategoryInstance, field: "employeeCategory")}</td>
						
							<td><g:formatDate date="${leaveEmployeeCategoryInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${leaveEmployeeCategoryInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${leaveEmployeeCategoryInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
