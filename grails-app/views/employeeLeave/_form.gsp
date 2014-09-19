<%@ page import="org.sparsh.arth.hr.EmployeeLeave" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeave.employee.label" default="Employee" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveInstance, field: 'employee', 'error')} required">
			  <g:select id="employee" name="employee.id" from="${org.sparsh.arth.hr.Employee.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${employeeLeaveInstance?.employee?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeave.leaveMaster.label" default="Leave Master" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveInstance, field: 'leaveMaster', 'error')} required">
			  <g:select id="leaveMaster" name="leaveMaster.id" from="${org.sparsh.arth.hr.LeaveMaster.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${employeeLeaveInstance?.leaveMaster?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeave.balance.label" default="Balance" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveInstance, field: 'balance', 'error')} required">
			  <g:field name="balance" type="number" value="${employeeLeaveInstance.balance}" required=""/>
			</div>
		</div>

