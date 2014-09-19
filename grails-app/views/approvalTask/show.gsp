
<%@page import="org.sparsh.arth.tm.TimeSheetGroup"%>
<%@page import="org.sparsh.arth.hr.EmployeeLeave"%>
<%@page import="org.sparsh.arth.hr.EmployeeLeaveTransaction"%>
<%@ page import="org.sparsh.arth.wf.ApprovalTask" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'approvalTask.label', default: 'ApprovalTask')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
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
				
						<g:if test="${approvalTaskInstance?.message}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.message.label" default="Message" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${approvalTaskInstance}" field="message"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.requestDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.requestDate.label" default="Request Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${approvalTaskInstance?.requestDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.requestor}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.requestor.label" default="Requestor" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="employee" action="show" id="${approvalTaskInstance?.requestor?.id}">${approvalTaskInstance?.requestor?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.comments}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.comments.label" default="Comments" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${approvalTaskInstance}" field="comments"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.approveDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.approveDate.label" default="Approve Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${approvalTaskInstance?.approveDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.approved}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.approved.label" default="Approved" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${approvalTaskInstance?.approved}" /></label>								
							
							</div>
						</div>
						</g:if>						
					
						<g:if test="${approvalTaskInstance?.type && (approvalTaskInstance?.type.equals('LEAVE'))}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.type.label" default="Type" />:</b></label>
							</div>
							<div class="large-9 columns">
								<% def tmpELT = EmployeeLeaveTransaction.get(approvalTaskInstance.remoteId) %>							
								<label class="inline"><g:fieldValue bean="${approvalTaskInstance}" field="type"/>
								&nbsp;[${tmpELT?.leaveMaster } / ${EmployeeLeave.findByEmployeeAndLeaveMaster(approvalTaskInstance.requestor, tmpELT?.leaveMaster).balance }]
								<g:if test="${tmpELT.comments}">
								<br/><small>${tmpELT.comments }</small>
								</g:if>
								</label>
							</div>
						</div>
						</g:if>
						
						<g:if test="${approvalTaskInstance?.type && (approvalTaskInstance?.type.equals('TIMESHEET'))}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.type.label" default="Type" />:</b></label>
							</div>
							<div class="large-9 columns">					
								<label class="inline"><g:link controller="timeSheetGroup" action="show" id="${approvalTaskInstance.remoteId }"><g:fieldValue bean="${approvalTaskInstance}" field="type"/></g:link></label>
							</div>
						</div>
						</g:if>
						
						<g:if test="${approvalTaskInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${approvalTaskInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${approvalTaskInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="approvalTask.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">							
								<label class="inline"><g:formatDate date="${approvalTaskInstance?.lastUpdated}" /></label>							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<a href="#" class="small button" data-reveal-id="approveRejectModal">Take Action</a>
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	    <div id="approveRejectModal" class="reveal-modal medium">				
			<h4>Approve/Reject</h4>
			<g:form>
			<fieldset>
			<div class="row collapse">
				<div class="large-3 columns">			
				  <label class="inline"><g:message code="approvalTask.comments.label" default="Comments" /></label>
				</div>
				<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'comments', 'error')} ">
				  <g:textArea name="comments" cols="40" rows="5" maxlength="512" value="${approvalTaskInstance?.comments}"/>
				</div>
			</div>
			<g:hiddenField name="id" value="${approvalTaskInstance?.id}" />
			<g:actionSubmit class="small button" action="approve" value="${message(code: 'default.button.approve.label', default: 'Approve')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			<g:actionSubmit class="small button" action="reject" value="${message(code: 'default.button.reject.label', default: 'Reject')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			</fieldset>
			</g:form>			
			<a class="close-reveal-modal">&#215;</a>
		</div>
	</body>
</html>
