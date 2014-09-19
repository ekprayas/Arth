<%@ page import="org.sparsh.arth.hr.EmployeeLeaveTransaction" %>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeaveTransaction.leaveMaster.label" default="Leave Master" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveTransactionInstance, field: 'leaveMaster', 'error')} required">
			  <g:select id="leaveMaster" name="leaveMaster.id" from="${org.sparsh.arth.hr.LeaveMaster.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${employeeLeaveTransactionInstance?.leaveMaster?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeaveTransaction.appliedHours.label" default="Applied Hours" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveTransactionInstance, field: 'appliedHours', 'error')} required">
			  <g:field name="appliedHours" type="number" min="1" value="${employeeLeaveTransactionInstance.appliedHours}" required=""/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			   <label class="inline"><g:message code="employeeLeaveTransaction.startDate.label" default="Start Date" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveTransactionInstance, field: 'startDate', 'error')} required">
			  <g:textField name="startDate_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#startDate_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#startDate_month").attr("value",$("#startDate_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#startDate_day").attr("value",$("#startDate_Dummy").datepicker("getDate").getDate());
			    	        $("#startDate_year").attr("value",$("#startDate_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${employeeLeaveTransactionInstance?.startDate}"format="dd-MM-yyyy"/>');
			    	  var startDate = $("#startDate_Dummy").datepicker( "getDate" );
			    	  if(startDate){
			    		  $("#startDate_month").attr("value",startDate.getMonth() +1);
			    	      $("#startDate_day").attr("value",startDate.getDate());
			    	      $("#startDate_year").attr("value",startDate.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="startDate" value="date.struct" />
				<input type="hidden" name="startDate_month" id="startDate_month" />
				<input type="hidden" name="startDate_day" id="startDate_day" />
				<input type="hidden" name="startDate_year" id="startDate_year" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employeeLeaveTransaction.comments.label" default="Comments" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeLeaveTransactionInstance, field: 'comments', 'error')} ">
			  <g:textArea name="comments" cols="40" rows="5" maxlength="512" value="${employeeLeaveTransactionInstance?.comments}"/>
			</div>
		</div>


