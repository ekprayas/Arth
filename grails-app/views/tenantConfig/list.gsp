
<%@ page import="org.sparsh.TenantConfig" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tenantConfig.label', default: 'TenantConfig')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.list.label" args="[entityName]" /></h2></div>
				<ul class="inline-list"></ul>
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
						
							<g:sortableColumn property="name" title="${message(code: 'tenantConfig.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="value" title="${message(code: 'tenantConfig.value.label', default: 'Value')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'tenantConfig.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'tenantConfig.lastUpdated.label', default: 'Last Updated')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${tenantConfigInstanceList}" status="i" var="tenantConfigInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${tenantConfigInstance.id}">${fieldValue(bean: tenantConfigInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: tenantConfigInstance, field: "value")}</td>
						
							<td><g:formatDate date="${tenantConfigInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${tenantConfigInstance.lastUpdated}" /></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<ul class="pagination">
					<g:paginate total="${tenantConfigInstanceTotal}" />
				</ul>
	    	</div>    	
	    </div>			
	</body>
</html>
