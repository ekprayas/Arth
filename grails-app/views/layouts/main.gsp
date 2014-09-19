<!DOCTYPE html>
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.sparsh.*"%>
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- Set the viewport width to device width for mobile -->
<meta name="viewport" content="width=device-width" />
<title><g:layoutTitle default="Welcome to Arth | Cube Hut &copy;" /></title>
<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'normalize.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'foundation.css')}" type="text/css">
<script src="${resource(dir: 'js', file: 'vendor/custom.modernizr.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.1.10.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.3.custom.min.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.10.3.custom.min.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'arth.sparsh.js')}"></script>
<g:layoutHead />
<r:layoutResources />
</head>
<body>
	<!-- Header and Nav -->
	<nav class="top-bar">
		<ul class="title-area">
			<!-- Title Area -->
			<li class="name"><g:if
					test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_SUPER_ADMIN') }">
					<!-- Define Super Admin Title -->
					<h1>
						<a href="#">Arth &copy; By Sparsh Foundation &copy;</a>
					</h1>
				</g:if><g:else>
					<h1>
						<a href="${loggedInUser?.tenant?.url }" target="_blank">
						${loggedInUser?.tenant?.name }</a>
					</h1>
				</g:else></li>
			<li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
		</ul>
		<section class="top-bar-section">
			<!-- Left Nav Section -->
			<ul class="left">
				<li class="divider"></li>
				<li><g:link controller="dashboard">Dashboard</g:link></li>				
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id,'ROLE_EMPLOYEE') }">
				<!-- Define Employee Menu -->
				<li class="divider"></li>
				<li><g:link controller="employeeLeaveTransaction">My Leaves</g:link></li>
				<li class="divider"></li>
				<li><g:link controller="approvalTask">My Actions</g:link></li>
				<li class="divider"></li>
				<li><g:link controller="timeSheetGroup">My TimeSheets</g:link></li>
				<li class="divider"></li>
				<li><g:link controller="notification">My Alerts</g:link></li>
				</g:if>
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_SUPER_ADMIN') }">
					<!-- Define Super Admin Menu -->
					<li class="divider"></li>
					<li><g:link controller="tenant">Tenant</g:link></li>
				</g:if>
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_HR') }">
				<!-- Define Super HR Menu -->
				<li class="divider"></li>
				<li class="has-dropdown"><a href="#">HRM</a>
					<ul class="dropdown">
						<li><g:link controller="department">Manage Departments</g:link></li>
						<li><g:link controller="designation">Manage Designations</g:link></li>
						<li><g:link controller="employee">Manage Employees</g:link></li>
						<li><g:link controller="employeeCategory">Manage Employee Categories</g:link></li>
						<li><g:link controller="employeeLeave">Manage Employee Leaves(Deprecated)</g:link></li>
						<li class="divider"></li>
						<li><g:link controller="publicHoliday">Manage Public Holidays</g:link></li>
						<li><g:link controller="leaveMaster">Manage Leaves</g:link></li>
						<li><g:link controller="leaveEmployeeCategory">Manage Employee Category & Leave</g:link></li>
					</ul>
				</li>
				</g:if>
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_PM') }">
				<!-- Define Super HR Menu -->
				<li class="divider"></li>
				<li class="has-dropdown"><a href="#">PM</a>
					<ul class="dropdown">
						<li><g:link controller="project">Manage Projects</g:link></li>
						<li><g:link controller="projectResource">Manage Project Resources</g:link></li>
						<li><g:link controller="#">Manage Tasks</g:link></li>
						<li><g:link controller="employeeCategory">Manage Employee Categories</g:link></li>
					</ul>
				</li>
				</g:if>
				<g:if test="${UserAuthority.hasAuthority(loggedInUser.id, 'ROLE_ADMIN') }">
				<!-- Define Super HR Menu -->
				<li class="divider"></li>
				<li><g:link controller="tenantConfig">General Settings</g:link></li>
				</g:if>			
			</ul>

			<!-- Right Nav Section -->
			<ul class="right">
				<sec:ifLoggedIn>
				<li class="has-dropdown"><a href="#">${loggedInUser}</a>
					<ul class="dropdown">
						<li><g:link controller="user" action="changePassword">Change Password</g:link></li>
					</ul>
				</li>
				<!-- <li class="divider"></li>
				<li class="has-form" id="master-search-menu" style="display: none;">
					<g:form action="search" method="post">
						<div class="row collapse">
							<div class="small-8 columns">
								<input type="text" name="searchKey" />
							</div>
							<div class="small-4 columns">
								<g:actionSubmit class="small button" action="search"
									value="${message(code: 'default.button.search.label', default: 'Search')}" />
							</div>
						</div>
					</g:form>
				</li> -->
				<li class="divider"></li>
				<li class="active"><g:link controller='logout'>Sign Out</g:link></li>
			</sec:ifLoggedIn>
			<sec:ifNotLoggedIn>
				<li><g:link controller='login' action='auth'>Login</g:link></li>
			</sec:ifNotLoggedIn>
			</ul>
		</section>
	</nav>
	<g:layoutBody />
	<r:layoutResources />
	<!-- Footer -->
	<footer class="row">
		<div class="large-12 columns">
			<hr />
			<div class="row">
				<div class="large-6 columns">
					<p>Copyright &copy; ${loggedInUser?.tenant?.name }, All Rights Reserved.</p>
				</div>
				<div class="large-6 columns">
					<ul class="inline-list right">
						<li><a href="#" data-reveal-id="contactUsModal">Contact Us</a></li>
						<li><a href="${loggedInUser?.tenant?.url }" target="_blank">About Us</a></li>
						<li><a href="http://support.cubehut.in" target="_blank">Support</a></li>
						<li><a href="http://cubehut.in" target="_blank">Cube Hut &copy;</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>		
	<div id="contactUsModal" class="reveal-modal medium">				
		<h4>Contact Us</h4>
		<div class="row collapse">
			<div class="large-6 columns">${StringEscapeUtils.unescapeHtml(loggedInUser?.tenant?.address)}</div>
		</div>			
		<a class="close-reveal-modal">&#215;</a>
	</div>	
    <script>
		document.write('<script src=${resource(dir: 'js', file: 'vendor/')}' +  ('__proto__' in {} ? 'zepto' : 'jquery') +  '.js><\/script>');
	</script>
	<script src="${resource(dir: 'js', file: 'foundation.min.js')}"></script>
	<script>
	  $(document).foundation();
	</script>
</body>
</html>