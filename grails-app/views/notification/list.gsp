
<%@ page import="org.sparsh.arth.wf.Notification" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
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
							<g:sortableColumn property="message" title="${message(code: 'notification.message.label', default: 'Message')}" />
							
							<g:sortableColumn property="isRead" title="${message(code: 'notification.isRead.label', default: 'Status')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'notification.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'notification.lastUpdated.label', default: 'Last Updated')}" />
							
							<!-- <th>Actions</th>	 -->
						</tr>
					</thead>
					<tbody>
					<g:each in="${notificationInstanceList}" status="i" var="notificationInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${notificationInstance.id}"> ${notificationInstance}</g:link></td>
							
							<td>${notificationInstance.isRead?'Read':'UnRead' }</td>
						
							<td><g:formatDate date="${notificationInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${notificationInstance.lastUpdated}" /></td>
							
							<!-- <td><g:link class="small button" action="delete" id="${notificationInstance?.id}"><g:message code="default.button.delete.label" default="Delete" /></g:link></td> -->
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${notificationInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
