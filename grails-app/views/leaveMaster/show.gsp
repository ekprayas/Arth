
<%@ page import="org.sparsh.arth.hr.LeaveMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'leaveMaster.label', default: 'LeaveMaster')}" />
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
					
						<g:if test="${leaveMasterInstance?.name}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.name.label" default="Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${leaveMasterInstance}" field="name"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${leaveMasterInstance?.description}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.description.label" default="Description" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${leaveMasterInstance}" field="description"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${leaveMasterInstance?.cutOffDay}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.cutOffDay.label" default="Cut Off Day" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${leaveMasterInstance}" field="cutOffDay"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${leaveMasterInstance?.carryForward}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.carryForward.label" default="Carry Forward" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${leaveMasterInstance?.carryForward}" /></label>								
							
							</div>
						</div>
						</g:if>
						
						<g:if test="${leaveMasterInstance?.approvalRequired}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.approvalRequired.label" default="Approval Required" />:</b></label>
							</div>
							<div class="large-9 columns">							
								<label class="inline"><g:formatBoolean boolean="${leaveMasterInstance?.approvalRequired}" /></label>
							</div>
						</div>
						</g:if>					
						
					
						<g:if test="${leaveMasterInstance?.hoursPerMonth}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.hoursPerMonth.label" default="Hours Per Month" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${leaveMasterInstance}" field="hoursPerMonth"/></label>								
							
							</div>
						</div>
						</g:if>
						<g:if test="${leaveMasterInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${leaveMasterInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${leaveMasterInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="leaveMaster.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${leaveMasterInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${leaveMasterInstance?.id}" />
						<g:link class="small button" action="edit" id="${leaveMasterInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
