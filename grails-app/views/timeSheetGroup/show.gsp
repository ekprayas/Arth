
<%@page import="org.sparsh.arth.tm.TimeSheet"%>
<%@page import="org.sparsh.arth.pm.ProjectResource"%>
<%@ page import="org.sparsh.arth.tm.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				  <li class="right"><span class="radius secondary label"><g:link action="chooseTimeSheet"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
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
						<g:if test="${timeSheetGroupInstance?.weekEndDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.weekEndDate.label" default="Week End Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${timeSheetGroupInstance?.weekEndDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${timeSheetGroupInstance?.weekStartDate}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.weekStartDate.label" default="Week Start Date" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${timeSheetGroupInstance?.weekStartDate}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${timeSheetGroupInstance?.status}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.status.label" default="Status" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:fieldValue bean="${timeSheetGroupInstance}" field="status"/></label>								
							
							</div>
						</div>
						</g:if>
						
						<g:if test="${timeSheetGroupInstance?.totalHrs}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.totalHrs.label" default="Total Hrs" />:</b></label>
							</div>
							<div class="large-9 columns">							
								<label class="inline"><g:fieldValue bean="${timeSheetGroupInstance}" field="totalHrs"/></label>
							</div>
						</div>
						</g:if>
						
						<hr/>
						<div class="row collapse">
							<div class="large-4 columns">			
							  <label class="inline">&nbsp;</label>
							</div>
							<g:each in="${dateSet}" status="i" var="displayDate">
							<div class="large-1 columns">									
							  <center><g:formatDate date="${displayDate}" format="dd-MM"/><br/>${dayNames[i]}</center>			  
							</div>
							</g:each>
							<div class="large-1 columns">			
							  <label class="inline">&nbsp;</label>
							</div>
						</div>						
						<hr/>
						<% def lts = LeaveTimeSheet.findByEmployeeAndWeekStartDate(timeSheetGroupInstance?.employee,timeSheetGroupInstance?.weekStartDate) %>
						<g:if test="${lts}">
							<div class="row collapse">
								<div class="large-3 columns">			
								  <label class="inline"><b>Leaves</b></label>
								</div>
								<div class="large-1 columns">			
								  <label class="inline"></label>
								</div>								
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day1"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day2"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day3"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day4"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day5"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day6"/></label></center>
								</div>
								<div class="large-1 columns">
								  <center><label class="inline"><g:fieldValue bean="${lts}" field="day7"/></label></center>
								</div>
								<div class="large-1 columns">
								  <label class="inline">&nbsp;</label>
								</div>		
							</div>
							<hr/>
						</g:if>
						<g:each in="${TimeSheet.findAllByEmployeeAndWeekStartDate(timeSheetGroupInstance?.employee,timeSheetGroupInstance?.weekStartDate )}" status="i" var="ts">
					
						<div class="row collapse">
							<div class="large-3 columns">			
							  <label class="inline"><b>${ts?.project }</b></label>
							</div>
							<div class="large-1 columns">			
							  <label class="inline"></label>
							</div>								
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day1"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day2"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day3"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day4"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day5"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day6"/></label></center>
							</div>
							<div class="large-1 columns">
							  <center><label class="inline"><g:fieldValue bean="${ts}" field="day7"/></label></center>
							</div>
							<div class="large-1 columns">
							  <label class="inline">&nbsp;</label>
							</div>		
						</div>
						</g:each>
						<hr/>
						<g:if test="${timeSheetGroupInstance?.dateCreated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.dateCreated.label" default="Date Created" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${timeSheetGroupInstance?.dateCreated}" /></label>
							
							</div>
						</div>
						</g:if>
					
						<g:if test="${timeSheetGroupInstance?.lastUpdated}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="timeSheetGroup.lastUpdated.label" default="Last Updated" />:</b></label>
							</div>
							<div class="large-9 columns">
							
								<label class="inline"><g:formatDate date="${timeSheetGroupInstance?.lastUpdated}" /></label>
							
							</div>
						</div>
						</g:if>
						
					
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${timeSheetGroupInstance?.id}" />
						<g:actionSubmit class="small button" action="submitForApproval" value="${message(code: 'default.button.submit.label', default: 'Submit')}" onclick="return confirm('${message(code: 'default.button.submit.confirm.message', default: 'Are you sure?')}');" />
						<g:actionSubmit class="small button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
