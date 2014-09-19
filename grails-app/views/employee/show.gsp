
<%@ page import="org.sparsh.arth.hr.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
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
					
						<g:if test="${employeeInstance?.employeeNumber}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.employeeNumber.label" default="Employee Number" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="employeeNumber"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.dateOfJoining}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.dateOfJoining.label" default="Date Of Joining" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeInstance?.dateOfJoining}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.department}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.department.label" default="Department" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="department" action="show" id="${employeeInstance?.department?.id}">${employeeInstance?.department?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.designation}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.designation.label" default="Designation" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="designation" action="show" id="${employeeInstance?.designation?.id}">${employeeInstance?.designation?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.emailAddress}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.emailAddress.label" default="Email Address" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="emailAddress"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.firstName}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.firstName.label" default="First Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="firstName"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.middleName}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.middleName.label" default="Middle Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="middleName"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.lastName}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.lastName.label" default="Last Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="lastName"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.dateOfBirth}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.dateOfBirth.label" default="Date Of Birth" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeInstance?.dateOfBirth}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.sex}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.sex.label" default="Sex" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="sex"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.bloodGroup}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.bloodGroup.label" default="Blood Group" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="bloodGroup"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.nationality}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.nationality.label" default="Nationality" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="nationality"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.language}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.language.label" default="Language" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="language"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.religion}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.religion.label" default="Religion" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="religion"/></label>								
							
							</div>
						</div>
						</g:if>
						
						<g:if test="${employeeInstance?.user}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.user.label" default="User" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:link controller="user" action="show" id="${employeeInstance?.user?.id}">${employeeInstance?.user?.encodeAsHTML()}</g:link></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.addressLine1}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.addressLine1.label" default="Address Line1" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="addressLine1"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.addressLine2}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.addressLine2.label" default="Address Line2" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="addressLine2"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.addressLine3}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.addressLine3.label" default="Address Line3" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="addressLine3"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.city}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.city.label" default="City" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="city"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.state}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.state.label" default="State" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="state"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.pinCode}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.pinCode.label" default="Pin Code" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="pinCode"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.country}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.country.label" default="Country" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="country"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.homePhone}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.homePhone.label" default="Home Phone" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="homePhone"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.mobile}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.mobile.label" default="Mobile" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="mobile"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.officePhone}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.officePhone.label" default="Office Phone" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeInstance}" field="officePhone"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employee.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${employeeInstance?.id}" />
						<a href="#" class="small button" data-reveal-id="pocModal">Assign PoC</a>
						<g:link class="small button" action="edit" id="${employeeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	    <div id="pocModal" class="reveal-modal medium">				
			<h4>Manage Point of Contact(PoC)</h4>
			<g:if test="${EmployeePoC.findByEmployee(employeeInstance)}">
			<div class="row collapse">
				<div class="large-3 columns">
				  <label class="inline"><b><g:message code="employeePoC.projectPoC.label" default="Project PoC" />:</b></label>
				</div>
				<div class="large-9 columns">
					<label class="inline">${EmployeePoC.findByEmployee(employeeInstance)?.projectPoC}</label>
				</div>
			</div>
			<div class="row collapse">
				<div class="large-3 columns">
				  <label class="inline"><b><g:message code="employeePoC.hrPoC.label" default="HR PoC" />:</b></label>
				</div>
				<div class="large-9 columns">
					<label class="inline">${EmployeePoC.findByEmployee(employeeInstance)?.hrPoC}</label>
				</div>
			</div>
			</g:if>
			<g:form action="assignPoC" >
				<fieldset class="form">
				<div class="row collapse">
					<div class="large-3 columns">
					  <label class="inline"><g:message code="employeePoC.projectPoC.label" default="Project PoC" />*</label>
					</div>
					<div class="large-9 columns">
						<g:select id="projectPoC" name="projectPoC.id" from="${Employee.findAllByArchiveAndTenant(false,loggedInUser.tenant)}" optionKey="id" required="" value="" class="many-to-one"/>
					</div>
				</div>
				<div class="row collapse">
					<div class="large-3 columns">
					  <label class="inline"><g:message code="employeePoC.hrPoC.label" default="HR PoC" />*</label>
					</div>
					<div class="large-9 columns">
						<g:select id="hrPoC" name="hrPoC.id" from="${Employee.findAllByArchiveAndTenant(false,loggedInUser.tenant)}" optionKey="id" required="" value="" class="many-to-one"/>
					</div>
				</div>
				<g:hiddenField name="id" value="${employeeInstance?.id}" />
				<g:hiddenField id="employee" name="employee.id" value="${employeeInstance?.id}" />
				<g:submitButton name="poc" class="small button" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>			
			<a class="close-reveal-modal">&#215;</a>
		</div>
	</body>
</html>
