<%@ page import="org.sparsh.arth.hr.PublicHoliday" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="publicHoliday.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: publicHolidayInstance, field: 'name', 'error')} required">
			  <g:textField name="name" required="" value="${publicHolidayInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="publicHoliday.type.label" default="Type" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: publicHolidayInstance, field: 'type', 'error')} required">
			  <g:select name="type" from="${publicHolidayInstance.constraints.type.inList}" required="" value="${publicHolidayInstance?.type}" valueMessagePrefix="publicHoliday.type"/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="publicHoliday.holidayDate.label" default="Holiday Date" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: publicHolidayInstance, field: 'holidayDate', 'error')} required">
			  <g:textField name="holidayDate_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#holidayDate_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#holidayDate_month").attr("value",$("#holidayDate_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#holidayDate_day").attr("value",$("#holidayDate_Dummy").datepicker("getDate").getDate());
			    	        $("#holidayDate_year").attr("value",$("#holidayDate_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${publicHolidayInstance?.holidayDate}" "format="dd-MM-yyyy"/>');
			    	  var date = $("#holidayDate_Dummy").datepicker( "getDate" );
			    	  if(date){
			    		  $("#holidayDate_month").attr("value",date.getMonth() +1);
			    	      $("#holidayDate_day").attr("value",date.getDate());
			    	      $("#holidayDate_year").attr("value",date.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="holidayDate" value="date.struct" />
				<input type="hidden" name="holidayDate_month" id="holidayDate_month" />
				<input type="hidden" name="holidayDate_day" id="holidayDate_day" />
				<input type="hidden" name="holidayDate_year" id="holidayDate_year" />
			</div>
		</div>

