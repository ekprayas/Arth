<%@page import="org.sparsh.arth.wf.ApprovalTask"%>
<%@page import="org.sparsh.arth.wf.Notification"%>
<%@page import="org.sparsh.arth.hr.*"%>
<%@page import="org.sparsh.arth.tm.TimeSheetGroupController"%>
<%@page import="org.sparsh.arth.tm.TimeSheetGroup"%>
<%@page import="org.sparsh.*"%>
<html>
<head>
	<meta name='layout' content='main'/>
	<script type="text/javascript" src="//www.google.com/jsapi"></script>
    <script type="text/javascript">google.load('visualization', '1', {packages: ['corechart']});</script>    
</head>
<body>
	<div class="row"> 
	<!-- Navigation -->    	
		<div class="large-12 columns">
			<div class="row collapse">
				<% def employeeInstance = Employee.findByUser(loggedInUser)
                	def cal = Calendar.getInstance()
    				cal.setTime(TimeSheetGroupController.getFirstDayOfTheWeek(new Date()))						
                 %>				
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_EMPLOYEE')}">
				<script type="text/javascript">
			      function drawVisualization() {
			        // Create and populate the data table.
			        var data = google.visualization.arrayToDataTable([
			          ['x', 'Hrs']
			          <g:each in="${(1..5) }" var="dayName">
			          	<% def tmp = TimeSheetGroup.findByEmployeeAndWeekStartDateLessThanEquals(employeeInstance,cal.getTime()) %>
			          	,['<g:formatDate date="${cal.getTime()}" format="dd-MM"/>',${tmp?tmp.totalHrs:0}]
			          	<% cal.add(Calendar.DAY_OF_YEAR, -7) %>
			          </g:each>
			        ]);
			      
			        // Create and draw the visualization.
			        new google.visualization.LineChart(document.getElementById('workingHrs')).
			            draw(data, {curveType: "function", vAxis: {maxValue: 10}});
			        
			      }
			      google.setOnLoadCallback(drawVisualization);
			    </script>
				<div class="large-5 columns">
					<form><fieldset><legend>Last TimeSheet Hours</legend><div id="workingHrs"></div></fieldset></form>
				</div>
				<div class="large-2 columns">
				  <label class="inline"></label>
				</div>				
				<div class="large-5 columns">
				<script type="text/javascript">
				function drawAlerts() {
			        var wrapper = new google.visualization.ChartWrapper({
			          chartType: 'ColumnChart',
			          dataTable: [['', 'Read', 'UnRead'],
			                      ['', ${Notification.countByEmployeeAndIsRead(employeeInstance,true)}, ${Notification.countByEmployeeAndIsRead(employeeInstance,false)}]],
			          
			          containerId: 'alerts'
			        });
			        wrapper.draw();
			      }
				google.setOnLoadCallback(drawAlerts);
				</script>				
					<form><fieldset><legend>Alerts</legend><div id="alerts"></div></fieldset></form>	
				</div>
				<div class="row collapse">
					<div class="large-5 columns">
					<% def types = '' 
                    def balance = ''
					%>
					<g:each in="${LeaveMaster.findAllByTenant(loggedInUser.tenant) }" var="lm">
						<% types = types + ','+ '"'+ lm.name +'"' %>
						<% balance = balance + "," + EmployeeLeave.findByEmployeeAndLeaveMaster(employeeInstance, lm)?.balance %>
					</g:each>
					<script type="text/javascript">
					function drawx() {
				        var wrapper = new google.visualization.ChartWrapper({
				          chartType: 'ColumnChart',
				          dataTable: [['' ${types}],['' ${balance}]],
				          containerId: 'x'
				        });
				        wrapper.draw();
				      }
					google.setOnLoadCallback(drawx);
					</script>
						<form><fieldset><legend>Leaves Balance</legend><div id="x"></div></fieldset></form>
					</div>
					<div class="large-2 columns">
					  <label class="inline"></label>
					</div>
					<div class="large-5 columns">
					<script type="text/javascript">
					function drawy() {
				        var wrapper = new google.visualization.ChartWrapper({
				          chartType: 'ColumnChart',
				          dataTable: [['', 'Pending', 'Approved', 'Rejected'],
				                      ['', 
				                      ${ApprovalTask.countByApproverAndApproveDate(employeeInstance,null)}, 
				                      ${ApprovalTask.countByApproverAndApproved(employeeInstance,true)},
				                      ${ApprovalTask.countByApproverAndApproved(employeeInstance,false)}
				                      ]],
				          
				          containerId: 'y'
				        });
				        wrapper.draw();
				      }
					google.setOnLoadCallback(drawy);
					</script>
						<form><fieldset><legend>Actions</legend><div id="y"></div></fieldset></form>
					</div>
				</div>
				</g:if>
				<g:else>
				<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
					<div class="large-2 columns panel radius callout" class="has-tip" title="${c.fullName }">						
						<h1 class="text-center">${c.logicalPropertyName.toUpperCase().toCharArray()[0]}${c.logicalPropertyName.toCharArray()[1]}</h1>
					</div>
				<div class="large-1 columns">&nbsp;</div>			
				</g:each>
				</g:else>
			</div>
		</div>
	</div>
</body>
</html>