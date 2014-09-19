<%@ page import="org.sparsh.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="user.changePassword.label" default="Change Password" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="user.changePassword.label" default="Change Password" /></h2></div>
				<ul class="inline-list"></ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
    		<div class="large-12 columns">
				<g:if test="${flash.message}">
				<div class="alert-box alert" role="status">${flash.message}</div>
				</g:if>
				<g:form method="post" >
					<fieldset class="form">
						<div class="row collapse">
							<div class="large-2 columns">			
							  <label class="inline"><g:message code="user.oldPassword.label" default="Old Password" />*</label>
							</div>
							<div class="large-10 columns required">
							  <g:passwordField name="oldPassword" required="" value=""/>
							</div>
						</div>
						<div class="row collapse">
							<div class="large-2 columns">			
							  <label class="inline"><g:message code="user.newPassword.label" default="New Password" />*</label>
							</div>
							<div class="large-10 columns required">
							  <g:passwordField name="newPassword" required="" value=""/>
							</div>
						</div>
						<div class="row collapse">
							<div class="large-2 columns">			
							  <label class="inline"><g:message code="user.confirmPassword.label" default="Confirm Password" />*</label>
							</div>
							<div class="large-10 columns required">
							  <g:passwordField name="confirmPassword" required="" value=""/>
							</div>
						</div>
						<g:actionSubmit class="small button" action="updatePassword" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					</fieldset>
				</g:form>				
			</div>
		</div>
	</body>
</html>
