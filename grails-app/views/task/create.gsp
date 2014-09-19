<%@ page import="org.sparsh.arth.pm.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse">
	    			<h2 class="subheader"><g:message code="default.create.label" args="[entityName]" /></h2>
	    			<h4 class="subheader">${taskInstance?.project }</h4>
	    		</div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link action="list" params="[project:taskInstance?.project?.id]"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
    		<div class="large-12 columns">
				<g:if test="${flash.message}">
				<div class="alert-box" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${taskInstance}">
					<div class="alert-box alert" role="alert">
						<ul role="alert">
							<g:eachError bean="${taskInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
							</g:eachError>
						</ul>
					</div>
				</g:hasErrors>
				<g:form action="save" >
					<fieldset class="form">
						<g:render template="form"/>
						<g:hiddenField id="project" name="project.id" value="${taskInstance?.project?.id}" />
						<g:submitButton name="create" class="small button" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
