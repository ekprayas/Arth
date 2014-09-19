
<%@ page import="org.sparsh.arth.pm.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse">
	    			<h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2>
	    			<h4 class="subheader">${taskInstance?.project }</h4>
	    		</div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list" params="[project:taskInstance?.project?.id]"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				  <li class="right"><span class="radius secondary label"><g:link class="create" action="create" id="${taskInstance?.project?.id }"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
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
				
						<g:if test="${taskInstance?.name}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.name.label" default="Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${taskInstance}" field="name"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.description}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.description.label" default="Description" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${taskInstance}" field="description"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.responsible}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.responsible.label" default="Responsible" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="employee" action="show" id="${taskInstance?.responsible?.id}">${taskInstance?.responsible?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.status}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.status.label" default="Status" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${taskInstance}" field="status"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.dateStart}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.dateStart.label" default="Date Start" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${taskInstance?.dateStart}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.dateEnd}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.dateEnd.label" default="Date End" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${taskInstance?.dateEnd}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.progress}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.progress.label" default="Progress" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${taskInstance}" field="progress"/></label>								
							
							</div>
						</div>
						</g:if>
						
						<g:if test="${taskInstance?.hours}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.hours.label" default="Hours" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${taskInstance}" field="hours"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.milestone}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.milestone.label" default="Milestone" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${taskInstance?.milestone}" /></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.parent}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.parent.label" default="Parent" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="task" action="show" id="${taskInstance?.parent?.id}">${taskInstance?.parent?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${taskInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${taskInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="task.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${taskInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${taskInstance?.id}" />
						<g:link class="small button" action="edit" id="${taskInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
