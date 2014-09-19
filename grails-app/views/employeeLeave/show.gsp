
<%@ page import="org.sparsh.arth.hr.EmployeeLeave" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employeeLeave.label', default: 'EmployeeLeave')}" />
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
					
						<g:if test="${employeeLeaveInstance?.employee}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeave.employee.label" default="Employee" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="employee" action="show" id="${employeeLeaveInstance?.employee?.id}">${employeeLeaveInstance?.employee?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveInstance?.leaveMaster}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeave.leaveMaster.label" default="Leave Master" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="leaveMaster" action="show" id="${employeeLeaveInstance?.leaveMaster?.id}">${employeeLeaveInstance?.leaveMaster?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveInstance?.balance}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeave.balance.label" default="Balance" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeLeaveInstance}" field="balance"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeave.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeLeaveInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeave.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeLeaveInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${employeeLeaveInstance?.id}" />
						<g:link class="small button" action="edit" id="${employeeLeaveInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
