<%@ page import="org.sparsh.arth.tm.TimeSheet" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'timeSheet.label', default: 'TimeSheet')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<script type="text/javascript">
		$(function() {
		    var startDate;
		    var endDate;
		
		    var selectCurrentWeek = function() {
		        window.setTimeout(function () {
		            $('.week-picker').find('.ui-datepicker-current-day a').addClass('ui-state-active')
		        }, 1);
		    }
		
		    $('.week-picker').datepicker( {
		        showOtherMonths: true,
		        selectOtherMonths: true,
		        onSelect: function(dateText, inst) { 
		            var date = $(this).datepicker('getDate');
		            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
		            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
		            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
		            $('#startDate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
		            $('#endDate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));
		
		            selectCurrentWeek();
		        },
		        beforeShowDay: function(date) {
		            var cssClass = '';
		            if(date >= startDate && date <= endDate)
		                cssClass = 'ui-datepicker-current-day';
		            return [true, cssClass];
		        },
		        onChangeMonthYear: function(year, month, inst) {
		            selectCurrentWeek();
		        }
		    });
		
		    $('.week-picker .ui-datepicker-calendar tr').live('mousemove', function() { $(this).find('td a').addClass('ui-state-hover'); });
		    $('.week-picker .ui-datepicker-calendar tr').live('mouseleave', function() { $(this).find('td a').removeClass('ui-state-hover'); });
		});
		</script>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.create.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
					<li class="right"><span class="radius secondary label"><g:link action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
    		<div class="large-12 columns">
				<g:if test="${flash.message}">
				<div class="alert-box" role="status">${flash.message}</div>
				</g:if>
				<g:form action="chooseTimeSheet" >
					<fieldset class="form">
						<div class="row collapse">
							<div class="large-3 columns">			
							  <label class="inline"><strong>Choose Week for Time-Sheet</strong>
							  <br/>You can file time-sheet ${rangeAllowed} day(s) in advance only.
							  </label>
							</div>
							<div class="large-9 columns">			
							  <div class="week-picker"></div>
							</div>			
						</div>
						<g:hiddenField name="startDate" id="startDate" value="" />
						<g:hiddenField name="endDate" id="endDate" value="" />
						<g:submitButton name="chooseTimeSheet" class="small button" value="${message(code: 'default.button.next.label', default: 'Next')}" />
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
