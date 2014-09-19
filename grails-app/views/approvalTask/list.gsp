
<%@ page import="org.sparsh.arth.wf.ApprovalTask" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'approvalTask.label', default: 'ApprovalTask')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.list.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
					<li class="right"><span class="radius secondary label"><g:link action="fullList">All Tasks</g:link></span></li>
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
							<th><g:message code="approvalTask.requestor.label" default="Requestor" /></th>
							
							<g:sortableColumn property="type" title="${message(code: 'approvalTask.type.label', default: 'Type')}" />
							
							<g:sortableColumn property="requestDate" title="${message(code: 'approvalTask.requestDate.label', default: 'Request Date')}" />
											
							<g:sortableColumn property="approveDate" title="${message(code: 'approvalTask.approveDate.label', default: 'Approve Date')}" />
						
							<g:sortableColumn property="approved" title="${message(code: 'approvalTask.approved.label', default: 'Approved')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'approvalTask.dateCreated.label', default: 'Date Created')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${approvalTaskInstanceList}" status="i" var="approvalTaskInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td>${fieldValue(bean: approvalTaskInstance, field: "requestor")}</td>
							<td><g:link action="show" id="${approvalTaskInstance.id}">${fieldValue(bean: approvalTaskInstance, field: "type")}</g:link></td>
							<td><g:formatDate date="${approvalTaskInstance.requestDate}" /></td>
							<td><g:formatDate date="${approvalTaskInstance.approveDate}" /></td>						
							<td><g:formatBoolean boolean="${approvalTaskInstance.approved}" /></td>						
							<td><g:formatDate date="${approvalTaskInstance.dateCreated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${approvalTaskInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
