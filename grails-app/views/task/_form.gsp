<%@ page import="org.sparsh.arth.pm.Task" %>


		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.name.label" default="Name" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'name', 'error')} required">
			  <g:textField name="name" maxlength="128" required="" value="${taskInstance?.name}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.description.label" default="Description" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'description', 'error')} required">
			  <g:textArea name="description" cols="40" rows="5" maxlength="512" required="" value="${taskInstance?.description}"/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.hours.label" default="Hours" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'hours', 'error')} required">
			  <g:textField name="hours" maxlength="5" required="" value="${taskInstance?.hours}"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.responsible.label" default="Responsible" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'responsible', 'error')} required">
			  <g:select id="responsible" name="responsible.id" from="${resources}" optionKey="id" value="${taskInstance?.responsible?.id}" class="many-to-one"/>
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.status.label" default="Status" />*</label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'status', 'error')} required">
			  <g:select name="status" from="${taskInstance.constraints.status.inList}" required="" value="${taskInstance?.status}" valueMessagePrefix="task.status"/>
			</div>
		</div>
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.milestone.label" default="Milestone" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'milestone', 'error')} ">
			  <g:checkBox name="milestone" value="${taskInstance?.milestone}" />
			</div>
		</div>

		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><g:message code="task.parent.label" default="Parent" /></label>
			</div>
			<div class="large-9 columns ${hasErrors(bean: taskInstance, field: 'parent', 'error')}">
			  <g:select id="parent" name="parent.id" from="${parentTask}" optionKey="id" value="${taskInstance?.parent?.id}" class="many-to-one" noSelection="['':'-Choose Parent Task-']"/>
			</div>
		</div>

