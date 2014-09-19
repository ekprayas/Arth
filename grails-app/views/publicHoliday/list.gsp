
<%@ page import="org.sparsh.arth.hr.PublicHoliday" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'publicHoliday.label', default: 'PublicHoliday')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'publicHoliday.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="holidayDate" title="${message(code: 'publicHoliday.holidayDate.label', default: 'Holiday Date')}" />
						
							<g:sortableColumn property="type" title="${message(code: 'publicHoliday.type.label', default: 'Type')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'publicHoliday.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'publicHoliday.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${publicHolidayInstanceList}" status="i" var="publicHolidayInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${publicHolidayInstance.id}">${fieldValue(bean: publicHolidayInstance, field: "name")}</g:link></td>
						
							<td><g:formatDate date="${publicHolidayInstance.holidayDate}" /></td>
						
							<td>${fieldValue(bean: publicHolidayInstance, field: "type")}</td>
						
							<td><g:formatDate date="${publicHolidayInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${publicHolidayInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${publicHolidayInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
