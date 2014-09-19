
<%@ page import="org.sparsh.Tenant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tenant.label', default: 'Tenant')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'tenant.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="url" title="${message(code: 'tenant.url.label', default: 'Url')}" />
						
							<g:sortableColumn property="email" title="${message(code: 'tenant.email.label', default: 'Email')}" />
						
							<g:sortableColumn property="address" title="${message(code: 'tenant.address.label', default: 'Address')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'tenant.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'tenant.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${tenantInstanceList}" status="i" var="tenantInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${tenantInstance.id}">${fieldValue(bean: tenantInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: tenantInstance, field: "url")}</td>
						
							<td>${fieldValue(bean: tenantInstance, field: "email")}</td>
						
							<td>${fieldValue(bean: tenantInstance, field: "address")}</td>
						
							<td><g:formatDate date="${tenantInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${tenantInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${tenantInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
