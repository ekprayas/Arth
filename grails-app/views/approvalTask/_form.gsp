<%@ page import="org.sparsh.arth.wf.ApprovalTask" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.comments.label" default="Comments" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'comments', 'error')} ">
			  <g:textArea name="comments" cols="40" rows="5" maxlength="512" value="${approvalTaskInstance?.comments}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.tenant.label" default="Tenant" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'tenant', 'error')} required">
			  <g:select id="tenant" name="tenant.id" from="${org.sparsh.Tenant.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${approvalTaskInstance?.tenant?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.approveDate.label" default="Approve Date" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'approveDate', 'error')} ">
			  <g:datePicker name="approveDate" precision="day"  value="${approvalTaskInstance?.approveDate}" default="none" noSelection="['': '']" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.approved.label" default="Approved" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'approved', 'error')} ">
			  <g:checkBox name="approved" value="${approvalTaskInstance?.approved}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.approver.label" default="Approver" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'approver', 'error')} required">
			  <g:select id="approver" name="approver.id" from="${org.sparsh.arth.hr.Employee.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${approvalTaskInstance?.approver?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.message.label" default="Message" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'message', 'error')} ">
			  <g:textField name="message" value="${approvalTaskInstance?.message}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.requestDate.label" default="Request Date" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'requestDate', 'error')} required">
			  <g:datePicker name="requestDate" precision="day"  value="${approvalTaskInstance?.requestDate}"  />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.requestor.label" default="Requestor" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'requestor', 'error')} required">
			  <g:select id="requestor" name="requestor.id" from="${org.sparsh.arth.hr.Employee.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${approvalTaskInstance?.requestor?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="approvalTask.type.label" default="Type" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: approvalTaskInstance, field: 'type', 'error')} ">
			  <g:textField name="type" value="${approvalTaskInstance?.type}"/>
			</div>
		</div>

