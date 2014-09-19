
<%@ page import="org.sparsh.arth.hr.LeaveMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'leaveMaster.label', default: 'LeaveMaster')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'leaveMaster.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="cutOffDay" title="${message(code: 'leaveMaster.cutOffDay.label', default: 'Cut Off Day')}" />
							
							<g:sortableColumn property="carryForward" title="${message(code: 'leaveMaster.carryForward.label', default: 'Carry Forward')}" />
							
							<g:sortableColumn property="approvalRequired" title="${message(code: 'leaveMaster.approvalRequired.label', default: 'Approval Required')}" />
							
							<g:sortableColumn property="hoursPerMonth" title="${message(code: 'leaveMaster.hoursPerMonth.label', default: 'Hours Per Month')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'leaveMaster.dateCreated.label', default: 'Date Created')}" />
							
							<g:sortableColumn property="lastUpdated" title="${message(code: 'leaveMaster.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${leaveMasterInstanceList}" status="i" var="leaveMasterInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${leaveMasterInstance.id}">${fieldValue(bean: leaveMasterInstance, field: "name")}</g:link></td>
												
							<td>${fieldValue(bean: leaveMasterInstance, field: "cutOffDay")}</td>
						
							<td><g:formatBoolean boolean="${leaveMasterInstance.carryForward}" /></td>
							
							<td><g:formatBoolean boolean="${leaveMasterInstance.approvalRequired}" /></td>
							
							<td>${fieldValue(bean: leaveMasterInstance, field: "hoursPerMonth")}</td>
						
							<td><g:formatDate date="${leaveMasterInstance.dateCreated}" /></td>
							
							<td><g:formatDate date="${leaveMasterInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${leaveMasterInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
