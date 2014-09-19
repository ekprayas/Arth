<%@page import="org.sparsh.arth.hr.PublicHoliday"%>
<%@page import="java.lang.Integer"%>
<%@page import="org.sparsh.arth.pm.ProjectResource"%>
<%@ page import="org.sparsh.arth.tm.TimeSheet" %>

		<script type="text/javascript">
	    	$(document).ready(function() {
	    		$("input[id*=':']").change(function(){
		    		if($(this).val()=="" || parseInt($(this).val()) < 0){
			    		alert('Please enter a valid positive number');
			    		 $(this).val(0);
			    		return;
			    	}
	    			fillAllTotals();
	    			fillSubTotals();		
	    			fillGrandTotal();
		    	});
	    		$("input[id*=':']").on("click", function () {
	    			$(this).select();
	    		});		    	
	    	});
	    	
	    	function fillAllTotals(){
		    	for(var i=1; i<=7; i++){			    	
			    	var elementArr = $("input[id*='key:"+i+"']");
			    	var tmpTotal = 0;
			    	for(var j=0; j< elementArr.size();j++){
			    		tmpTotal = tmpTotal + parseInt(elementArr[j].value);
				    }
			    	$("input[id='grand:total:"+i+"']").val(tmpTotal);
			    }

		    	var elementArr = $("input[id*='sub:total:']");
		    	var tmpTotal = 0;
		    	for(var j=0; j< elementArr.size();j++){
		    		tmpTotal = tmpTotal + parseInt(elementArr[j].value);
			    }
		    	$("input[id='grand:total:total']").val(tmpTotal);
		    }

	    	function fillSubTotals(){
	    		var elementArr = $("input[id*='sub:total']");
		    	for(var i=0; i<elementArr.size(); i++){
			    	var prodId = elementArr[i].name.split(':')[2];
			    	var tmpTotal = 0;			    	
			    	for(var j=1;j<=7;j++){
			    		tmpTotal = tmpTotal + parseInt($("input[id='"+prodId+":key:"+j+"']").val());
				    }
			    	elementArr[i].value = tmpTotal;
			    }
		    }

	    	function fillGrandTotal(){
	    		var elementArr = $("input[id*='grand:total']");
	    		elementArr[elementArr.size()-1].value = 0;
	    		var tmpTotal = 0;
		    	for(var i=0; i<elementArr.size()-1; i++){			    	
			    	tmpTotal = tmpTotal + parseInt(elementArr[i].value);
				}
			    elementArr[elementArr.size()-1].value = tmpTotal;			    
		    }
		</script>
		<input type="hidden" name="weekStartDate" value="date.struct" />
		<input type="hidden" name="weekStartDate_month" value="<g:formatDate date="${timeSheetInstance.weekStartDate}" format="MM"/>"/>
		<input type="hidden" name="weekStartDate_day" value="<g:formatDate date="${timeSheetInstance.weekStartDate}" format="dd"/>" />
		<input type="hidden" name="weekStartDate_year" value="<g:formatDate date="${timeSheetInstance.weekStartDate}" format="yyyy"/>" />
		
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline">&nbsp;</label>
			</div>
			<div class="large-1 columns">			
			  <label class="inline"></label>
			</div>
			<% def greenDays = '0'%>
			<g:each in="${dateSet}" status="i" var="displayDate">
			<div class="large-1 columns">
			<%          		
          		for(PublicHoliday ph:pubHoli){
          			if(ph.holidayDate.compareTo(displayDate) == 0){
          				greenDays = greenDays + ','+(i+1)
          			}
          		}
           		%>			
			  <center><g:formatDate date="${displayDate}" format="dd-MM"/><br/>${dayNames[i]}</center>			  
			</div>
			</g:each>
			<div class="large-1 columns">			
			  <label class="inline">&nbsp;</label>
			</div>
		</div>
		<hr/>
		
		<g:each in="${ProjectResource.findAllByUser(timeSheetInstance?.employee)}" status="i" var="projectResourceInstance">
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline"><strong>${projectResourceInstance?.project }</strong></label>
			</div>
			<div class="large-1 columns">			
			  <label class="inline"></label>
			</div>
			<g:each in="${(1..7) }" var="dayName">
			<% 
                def tmpBool = true
                for(String s:workingDays){
                	if(dayName == Integer.parseInt(s).intValue()){
                		tmpBool = false
                	}                
            	}
            
            	def greenBool = false
                for(String s:greenDays.split(",")){
                	if(dayName == Integer.parseInt(s).intValue()){
                		greenBool = true
                	}                
            	}
            	tmpBool = greenBool?greenBool:tmpBool
            %>			
			<div class="large-1 columns">
			  <input type="number" name="${projectResourceInstance.id}:key:${dayName}" id="${projectResourceInstance.id}:key:${dayName}" value="0" <g:if test="${tmpBool}">disabled</g:if>/>
			</div>			
			</g:each>
			<div class="large-1 columns">			
			  <input type="text" name="sub:total:${projectResourceInstance.id}" id="sub:total:${projectResourceInstance.id}" readOnly value="0"/>
			</div>			
		</div>
		</g:each>
		<hr/>
		<div class="row collapse">
			<div class="large-3 columns">			
			  <label class="inline">&nbsp;</label>
			</div>
			<div class="large-1 columns">			
			  <label class="inline"></label>
			</div>
			<g:each in="${(1..7) }" var="dayName">
			<div class="large-1 columns">
			  <input type="text" name="grand:total:${dayName}" id="grand:total:${dayName}" readOnly value="0"/>
			</div>
			</g:each>
			<div class="large-1 columns">			
			  <input type="text" name="grand:total:total" id="grand:total:total" readOnly value="0"/>
			</div>
		</div>

