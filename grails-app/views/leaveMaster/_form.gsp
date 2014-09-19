<%@ page import="org.sparsh.arth.hr.LeaveMaster" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${leaveMasterInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.description.label" default="Description" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'description', 'error')} required">
			  <g:textArea name="description" cols="40" rows="5" maxlength="512" required="" value="${leaveMasterInstance?.description}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.cutOffDay.label" default="Cut Off Day" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'cutOffDay', 'error')} required">
			  <g:select name="cutOffDay" from="${0..30}" class="range" required="" value="${fieldValue(bean: leaveMasterInstance, field: 'cutOffDay')}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.carryForward.label" default="Carry Forward" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'carryForward', 'error')} ">
			  <g:checkBox name="carryForward" value="${leaveMasterInstance?.carryForward}" />
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.approvalRequired.label" default="Approval Required" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'approvalRequired', 'error')} ">
			  <g:checkBox name="approvalRequired" value="${leaveMasterInstance?.approvalRequired}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveMaster.hoursPerMonth.label" default="Hours Per Month" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveMasterInstance, field: 'hoursPerMonth', 'error')} required">
			  <g:field name="hoursPerMonth" type="number" value="${leaveMasterInstance.hoursPerMonth}" required=""/>
			</div>
		</div>

