
<%@ page import="org.sparsh.arth.pm.Project" %>
<%@ page import="org.sparsh.arth.hr.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
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
				
				
					
						<g:if test="${projectInstance?.title}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.title.label" default="Title" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${projectInstance}" field="title"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.description}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.description.label" default="Description" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${projectInstance}" field="description"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.dateRecieved}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.dateRecieved.label" default="Date Recieved" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.dateRecieved}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.deliveryDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.deliveryDate.label" default="Delivery Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.deliveryDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.responsible}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.responsible.label" default="Responsible" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="employee" action="show" id="${projectInstance?.responsible?.id}">${projectInstance?.responsible?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.status}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.status.label" default="Status" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${projectInstance}" field="status"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.dateEnd}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.dateEnd.label" default="Date End" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.dateEnd}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.dateStart}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.dateStart.label" default="Date Start" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.dateStart}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${projectInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="project.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${projectInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${projectInstance?.id}" />
						<a href="#" class="small button" data-reveal-id="pocModal">Assign PoC</a>
						<g:link class="small button" controller="task" action="list" params="[project:projectInstance.id]">Manage Task(s)</g:link>
						<g:link class="small button" action="edit" id="${projectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	    <div id="pocModal" class="reveal-modal medium">				
			<h4>Manage Point of Contact(PoC)</h4>
			<g:if test="${projectInstance.responsible}">
			<div class="row collapse">
				<div class="large-3 columns">
				  <label class="inline"><b><g:message code="employeePoC.projectPoC.label" default="Project PoC" />:</b></label>
				</div>
				<div class="large-9 columns">
					<label class="inline">${projectInstance.responsible}</label>
				</div>
			</div>
			</g:if>
			<g:form action="assignPoC" >
				<fieldset class="form">
				<div class="row collapse">
					<div class="large-3 columns">
					  <label class="inline"><g:message code="employeePoC.projectPoC.label" default="Project PoC" />*</label>
					</div>
					<div class="large-9 columns">
						<g:select id="responsible" name="responsible.id" from="${Employee.findAllByArchiveAndTenant(false,loggedInUser.tenant)}" optionKey="id" required="" value="" class="many-to-one"/>
					</div>
				</div>
				<g:hiddenField name="id" value="${projectInstance?.id}" />
				<g:submitButton name="poc" class="small button" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>			
			<a class="close-reveal-modal">&#215;</a>
		</div>
	</body>
</html>
