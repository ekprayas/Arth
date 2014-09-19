<%@ page import="org.sparsh.arth.hr.LeaveEmployeeCategory" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveEmployeeCategory.leaveMaster.label" default="Leave Master" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveEmployeeCategoryInstance, field: 'leaveMaster', 'error')} required">
			  <g:select id="leaveMaster" name="leaveMaster.id" from="${org.sparsh.arth.hr.LeaveMaster.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${leaveEmployeeCategoryInstance?.leaveMaster?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="leaveEmployeeCategory.employeeCategory.label" default="Employee Category" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: leaveEmployeeCategoryInstance, field: 'employeeCategory', 'error')} required">
			  <g:select id="employeeCategory" name="employeeCategory.id" from="${org.sparsh.arth.hr.EmployeeCategory.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${leaveEmployeeCategoryInstance?.employeeCategory?.id}" class="many-to-one"/>
			</div>
		</div>

