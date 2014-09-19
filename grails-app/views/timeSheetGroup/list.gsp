
<%@ page import="org.sparsh.arth.tm.TimeSheetGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.list.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link action="chooseTimeSheet"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
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
							<th>TimeSheet</th>
													
							<g:sortableColumn property="status" title="${message(code: 'timeSheetGroup.status.label', default: 'Status')}" />
							
							<g:sortableColumn property="totalHrs" title="${message(code: 'timeSheetGroup.totalHrs.label', default: 'Total Hrs')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'timeSheetGroup.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'timeSheetGroup.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${timeSheetGroupInstanceList}" status="i" var="timeSheetGroupInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${timeSheetGroupInstance.id}"><g:formatDate date="${timeSheetGroupInstance.weekStartDate}" format="dd-MM-yyyy" /> <> <g:formatDate date="${timeSheetGroupInstance.weekEndDate}" format="dd-MM-yyyy"/></g:link></td>
						
							<td>${fieldValue(bean: timeSheetGroupInstance, field: "status")}</td>
							
							<td>${fieldValue(bean: timeSheetGroupInstance, field: "totalHrs")}</td>
						
							<td><g:formatDate date="${timeSheetGroupInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${timeSheetGroupInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${timeSheetGroupInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
