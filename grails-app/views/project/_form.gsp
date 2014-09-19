<%@ page import="org.sparsh.arth.pm.Project" %>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="project.title.label" default="Title" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectInstance, field: 'title', 'error')} required">
			  <g:textField name="title" maxlength="128" required="" value="${projectInstance?.title}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="project.description.label" default="Description" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectInstance, field: 'description', 'error')} required">
			  <g:textArea name="description" cols="40" rows="5" maxlength="512" required="" value="${projectInstance?.description}"/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="project.dateRecieved.label" default="Date Recieved" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectInstance, field: 'dateRecieved', 'error')} required">
			  <g:textField name="dateRecieved_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#dateRecieved_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#dateRecieved_month").attr("value",$("#dateRecieved_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#dateRecieved_day").attr("value",$("#dateRecieved_Dummy").datepicker("getDate").getDate());
			    	        $("#dateRecieved_year").attr("value",$("#dateRecieved_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${projectInstance?.dateRecieved}"format="dd-MM-yyyy"/>');
			    	  var dateRecieved = $("#dateRecieved_Dummy").datepicker( "getDate" );
			    	  if(dateRecieved){
			    		  $("#dateRecieved_month").attr("value",dateRecieved.getMonth() +1);
			    	      $("#dateRecieved_day").attr("value",dateRecieved.getDate());
			    	      $("#dateRecieved_year").attr("value",dateRecieved.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="dateRecieved" value="date.struct" />
				<input type="hidden" name="dateRecieved_month" id="dateRecieved_month" />
				<input type="hidden" name="dateRecieved_day" id="dateRecieved_day" />
				<input type="hidden" name="dateRecieved_year" id="dateRecieved_year" />
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="project.deliveryDate.label" default="Delivery Date" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectInstance, field: 'deliveryDate', 'error')} required">
			  <g:textField name="deliveryDate_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#deliveryDate_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#deliveryDate_month").attr("value",$("#deliveryDate_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#deliveryDate_day").attr("value",$("#deliveryDate_Dummy").datepicker("getDate").getDate());
			    	        $("#deliveryDate_year").attr("value",$("#deliveryDate_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${projectInstance?.deliveryDate}" format="dd-MM-yyyy"/>');
			    	  var deliveryDate = $("#deliveryDate_Dummy").datepicker( "getDate" );
			    	  if(deliveryDate){
			    		  $("#deliveryDate_month").attr("value",deliveryDate.getMonth() +1);
			    	      $("#deliveryDate_day").attr("value",deliveryDate.getDate());
			    	      $("#deliveryDate_year").attr("value",deliveryDate.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="deliveryDate" value="date.struct" />
				<input type="hidden" name="deliveryDate_month" id="deliveryDate_month" />
				<input type="hidden" name="deliveryDate_day" id="deliveryDate_day" />
				<input type="hidden" name="deliveryDate_year" id="deliveryDate_year" />
			</div>
		</div>

		

