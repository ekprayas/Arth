
<%@ page import="org.sparsh.arth.wf.Notification" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				  <li class="right"><span class="radius secondary label"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
	    	<div class="large-12 columns">
	    		<g:if test="${flash.message}">
				<div class="alert-box" role="status">${flash.message}</div>
				</g:if>
				<div class="panel">
					
										
						<g:if test="${notificationInstance?.message}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="notification.message.label" default="Message" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${notificationInstance}" field="message"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${notificationInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="notification.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${notificationInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${notificationInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="notification.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${notificationInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${notificationInstance?.id}" />						
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
