
<%@ page import="org.sparsh.arth.hr.EmployeeCategory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employeeCategory.label', default: 'EmployeeCategory')}" />
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
					
						<g:if test="${employeeCategoryInstance?.name}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeCategory.name.label" default="Name" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeCategoryInstance}" field="name"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeCategoryInstance?.code}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeCategory.code.label" default="Code" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${employeeCategoryInstance}" field="code"/></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeCategoryInstance?.isActive}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeCategory.isActive.label" default="Is Active" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatBoolean boolean="${employeeCategoryInstance?.isActive}" /></label>								
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeCategoryInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeCategory.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeCategoryInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${employeeCategoryInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="employeeCategory.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${employeeCategoryInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${employeeCategoryInstance?.id}" />
						<g:link class="small button" action="edit" id="${employeeCategoryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
