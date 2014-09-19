<%@page import="org.sparsh.arth.hr.Employee"%>
<%@ page import="org.sparsh.arth.pm.ProjectResource" %>



		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="projectResource.project.label" default="Project" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectResourceInstance, field: 'project', 'error')} required">
			  <g:select id="project" name="project.id" from="${org.sparsh.arth.pm.Project.safeList(loggedInUser.tenant)}" optionKey="id" required="" value="${projectResourceInstance?.project?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="projectResource.user.label" default="User" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: projectResourceInstance, field: 'user', 'error')} required">
			  <g:select id="user" name="user.id" from="${Employee.findAllByArchiveAndTenant(false,loggedInUser.tenant)}" optionKey="id" required="" value="${projectResourceInstance?.user?.id}" class="many-to-one"/>
			</div>
		</div>

