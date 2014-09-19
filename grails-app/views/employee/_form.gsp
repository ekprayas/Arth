<%@page import="org.sparsh.*"%>
<%@ page import="org.sparsh.arth.hr.Employee" %>


		<g:if test="${TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.AUTO_INCREMENT_EMPLOYEE_NUMBER).value.toString().toLowerCase().equals("false") }">
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.employeeNumber.label" default="Employee Number" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'employeeNumber', 'error')} required">
			  <g:textField name="employeeNumber" required="" value="${employeeInstance?.employeeNumber}"/>
			</div>
		</div>
		</g:if>
		<g:else>
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.employeeNumber.label" default="Employee Number" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'employeeNumber', 'error')} required">
			  <label class="inline"><b>Auto Assignment</b></label>
			</div>
		</div>	
		</g:else>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.dateOfJoining.label" default="Date Of Joining" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'dateOfJoining', 'error')} required">
			  <g:textField name="dateOfJoining_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#dateOfJoining_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#dateOfJoining_month").attr("value",$("#dateOfJoining_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#dateOfJoining_day").attr("value",$("#dateOfJoining_Dummy").datepicker("getDate").getDate());
			    	        $("#dateOfJoining_year").attr("value",$("#dateOfJoining_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${employeeInstance?.dateOfJoining}"/>');
			    	  var dateOfJoining = $("#dateOfJoining_Dummy").datepicker( "getDate" );
			    	  if(dateOfJoining){
			    		  $("#dateOfJoining_month").attr("value",dateOfJoining.getMonth() +1);
			    	      $("#dateOfJoining_day").attr("value",dateOfJoining.getDate());
			    	      $("#dateOfJoining_year").attr("value",dateOfJoining.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="dateOfJoining" value="date.struct" />
				<input type="hidden" name="dateOfJoining_month" id="dateOfJoining_month" />
				<input type="hidden" name="dateOfJoining_day" id="dateOfJoining_day" />
				<input type="hidden" name="dateOfJoining_year" id="dateOfJoining_year" />
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.department.label" default="Department" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'department', 'error')} required">
			  <g:select id="department" name="department.id" from="${org.sparsh.arth.hr.Department.findAllByTenantAndIsActive(loggedInUser.tenant,true)}" optionKey="id" required="" value="${employeeInstance?.department?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.designation.label" default="Designation" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'designation', 'error')} required">
			  <g:select id="designation" name="designation.id" from="${org.sparsh.arth.hr.Designation.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${employeeInstance?.designation?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.emailAddress.label" default="Email Address" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'emailAddress', 'error')} required">
			  <g:field type="email" name="emailAddress" required="" value="${employeeInstance?.emailAddress}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.firstName.label" default="First Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'firstName', 'error')} required">
			  <g:textField name="firstName" maxlength="128" required="" value="${employeeInstance?.firstName}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.middleName.label" default="Middle Name" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'middleName', 'error')} ">
			  <g:textField name="middleName" maxlength="128" value="${employeeInstance?.middleName}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.lastName.label" default="Last Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'lastName', 'error')} required">
			  <g:textField name="lastName" maxlength="128" required="" value="${employeeInstance?.lastName}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.dateOfBirth.label" default="Date Of Birth" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'dateOfBirth', 'error')} required">
			  <g:textField name="dateOfBirth_Dummy" required="" />
			    <script type="text/javascript">
			    	$(document).ready(function() {    	 
			    	  $("#dateOfBirth_Dummy").datepicker({
			    	      onClose: function(dateText, inst) {
			    	        $("#dateOfBirth_month").attr("value",$("#dateOfBirth_Dummy").datepicker("getDate").getMonth() +1);
			    	        $("#dateOfBirth_day").attr("value",$("#dateOfBirth_Dummy").datepicker("getDate").getDate());
			    	        $("#dateOfBirth_year").attr("value",$("#dateOfBirth_Dummy").datepicker("getDate").getFullYear());
			    	      }
			    	  }).datepicker( "option", "dateFormat", "dd-mm-yy" )
			    	  .datepicker('setDate','<g:formatDate date="${employeeInstance?.dateOfBirth}"/>');
			    	  var dateOfBirth = $("#dateOfBirth_Dummy").datepicker( "getDate" );
			    	  if(dateOfBirth){
			    		  $("#dateOfBirth_month").attr("value",dateOfBirth.getMonth() +1);
			    	      $("#dateOfBirth_day").attr("value",dateOfBirth.getDate());
			    	      $("#dateOfBirth_year").attr("value",dateOfBirth.getFullYear());
				      }
			    	});
				</script>
				<input type="hidden" name="dateOfBirth" value="date.struct" />
				<input type="hidden" name="dateOfBirth_month" id="dateOfBirth_month" />
				<input type="hidden" name="dateOfBirth_day" id="dateOfBirth_day" />
				<input type="hidden" name="dateOfBirth_year" id="dateOfBirth_year" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.sex.label" default="Sex" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'sex', 'error')} required">
			  <g:select name="sex" from="${employeeInstance.constraints.sex.inList}" required="" value="${employeeInstance?.sex}" valueMessagePrefix="employee.sex"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.bloodGroup.label" default="Blood Group" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'bloodGroup', 'error')} ">
			  <g:textField name="bloodGroup" maxlength="5" value="${employeeInstance?.bloodGroup}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.nationality.label" default="Nationality" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'nationality', 'error')} ">
			  <g:textField name="nationality" maxlength="128" value="${employeeInstance?.nationality}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.language.label" default="Language" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'language', 'error')} ">
			  <g:textField name="language" maxlength="128" value="${employeeInstance?.language}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.religion.label" default="Religion" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'religion', 'error')} ">
			  <g:textField name="religion" maxlength="128" value="${employeeInstance?.religion}"/>
			</div>
		</div>		

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.addressLine1.label" default="Address Line1" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'addressLine1', 'error')} ">
			  <g:textField name="addressLine1" value="${employeeInstance?.addressLine1}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.addressLine2.label" default="Address Line2" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'addressLine2', 'error')} ">
			  <g:textField name="addressLine2" value="${employeeInstance?.addressLine2}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.addressLine3.label" default="Address Line3" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'addressLine3', 'error')} ">
			  <g:textField name="addressLine3" value="${employeeInstance?.addressLine3}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.city.label" default="City" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'city', 'error')} ">
			  <g:textField name="city" value="${employeeInstance?.city}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.state.label" default="State" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'state', 'error')} ">
			  <g:textField name="state" value="${employeeInstance?.state}"/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.pinCode.label" default="Pin Code" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'pinCode', 'error')} ">
			  <g:textField name="pinCode" pattern="${employeeInstance.constraints.pinCode.matches}" value="${employeeInstance?.pinCode}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.country.label" default="Country" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'country', 'error')} required">
			  <g:select name="country" from="${employeeInstance.constraints.country.inList}" required="" value="${employeeInstance?.country}" valueMessagePrefix="employee.country"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.homePhone.label" default="Home Phone" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'homePhone', 'error')} ">
			  <g:textField name="homePhone" value="${employeeInstance?.homePhone}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.mobile.label" default="Mobile" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'mobile', 'error')} ">
			  <g:textField name="mobile" value="${employeeInstance?.mobile}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="employee.officePhone.label" default="Office Phone" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: employeeInstance, field: 'officePhone', 'error')} ">
			  <g:textField name="officePhone" value="${employeeInstance?.officePhone}"/>
			</div>
		</div>

