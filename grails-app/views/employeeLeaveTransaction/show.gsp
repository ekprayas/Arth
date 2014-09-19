
<%@ page import="org.sparsh.arth.hr.EmployeeLeaveTransaction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employeeLeaveTransaction.label', default: 'EmployeeLeaveTransaction')}" />
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
					
						<g:if test="${employeeLeaveTransactionInstance?.leaveMaster}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.leaveMaster.label" default="Leave Master" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="leaveMaster" action="show" id="${employeeLeaveTransactionInstance?.leaveMaster?.id}">${employeeLeaveTransactionInstance?.leaveMaster?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.appliedHours}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.appliedHours.label" default="Applied Hours" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeLeaveTransactionInstance}" field="appliedHours"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.startDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.startDate.label" default="Start Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeLeaveTransactionInstance?.startDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.comments}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.comments.label" default="Comments" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeLeaveTransactionInstance}" field="comments"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.status}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.status.label" default="Status" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeLeaveTransactionInstance}" field="status"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeLeaveTransactionInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeLeaveTransactionInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeLeaveTransaction.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeLeaveTransactionInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${employeeLeaveTransactionInstance?.id}" />
						<g:actionSubmit class="small button" action="submitForApproval" value="${message(code: 'default.button.submit.label', default: 'Submit')}" onclick="return confirm('${message(code: 'default.button.delete.submit.message', default: 'Are you sure?')}');" />
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
