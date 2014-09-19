<!DOCTYPE html>
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <!-- Set the viewport width to device width for mobile -->
  <meta name="viewport" content="width=device-width" />
  <title>Welcome to Cube Hut &copy;</title>
  <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
  <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
  <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'normalize.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'foundation.css')}" type="text/css">
  <script src="${resource(dir: 'js', file: 'vendor/custom.modernizr.js')}"></script>
  <script>document.write('<script src=${resource(dir: 'js', file: 'vendor/')}' +  ('__proto__' in {} ? 'zepto' : 'jquery') +  '.js><\/script>');</script>
  <script src="${resource(dir: 'js', file: 'foundation.min.js')}"></script>
  <script>$(document).foundation();</script>
</head>
<body>

 <nav class="top-bar">
    <ul class="title-area">
      <!-- Title Area -->
      <li class="name">
      	<g:if test= "${tenantInstance }">
        <h1><a href="${tenantInstance?.url}">${tenantInstance.name }</a></h1>
        </g:if>
        <g:else>
        <h1><a href="${createLink(uri: '/')}">Manthan by Cube Hut &copy;</a></h1>
        </g:else>
      </li>
    </ul>
   </nav>
 
  <!-- End Top Bar -->
 
 
  <!-- Main Page Content and Sidebar -->
 
  <div class="row"> 
    <!-- Contact Details -->
    <div class="large-9 columns">
 
      <h3>Welcome back!</h3>
      <p>Please proceed with your login credentials. If you are facing any problems, drop us the issue by clicking support. We are here help you <em>all day</em>.</p>
 
      <div class="section-container auto" data-section>
        <section class="section active">
          <h5 class="title"><a href="#panel1">Sign In</a></h5>
          <div class="content" data-slug="panel1">
            <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
              <g:if test='${flash.message}'>
              <div class="alert-box alert">
			      ${flash.message}
			  </div>
			  </g:if>
              <div class="row collapse">
                <div class="large-2 columns">
                  <label class="inline"><g:message code="springSecurity.login.username.label"/></label>
                </div>
                <div class="large-10 columns">
                  <input type="text" name='j_username' id='username' placeholder="Type your <g:message code="springSecurity.login.username.label"/>">
                </div>
              </div>
              <div class="row collapse">
                <div class="large-2 columns">
                  <label class="inline"><g:message code="springSecurity.login.password.label"/></label>
                </div>
                <div class="large-10 columns">
                  <input type='password' name='j_password' id='password' placeholder="Type your <g:message code="springSecurity.login.password.label"/>">
                </div>
              </div>
              <div class="row collapse">
                <div class="large-2 columns">
                  <label class="inline"></label>
                </div>
                <div class="large-10 columns">
                  <label for="checkbox1">
                  	<input type='checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if> class="hidden-field">
                  		<span class="custom checkbox"></span> <g:message code="springSecurity.login.remember.me.label"/>
                  </label>
                </div>
              </div>
              <input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}' class="button"/>
            </form>
          </div>
        </section>
      </div>
    </div> 
    <!-- End Contact Details --> 
    <!-- Sidebar -->
 

    <div class="large-3 columns">
    	<g:if test= "${tenantInstance }">
    	<p><a href="${tenantInstance.url }" target="_blank"><img src="${tenantInstance.logoUrl }"/></a></p>
    	<p>${StringEscapeUtils.unescapeHtml(tenantInstance.contactUs) }</p>
    	</g:if>
    	<g:else>
    	<p><a href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'logo.png')}"></a></p>
    	</g:else>      
    </div>
    <!-- End Sidebar -->
  </div>
 
  <!-- End Main Content and Sidebar -->
 
 
  <!-- Footer -->
 
  <footer class="row">
    <div class="large-12 columns">
      <hr />
      <div class="row">
        <div class="large-6 columns">
          <p>Copyright &copy; Cube Hut, All Rights Reserved.</p>
        </div>
        <div class="large-6 columns">
          <ul class="inline-list right">
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About Us</a></li>
				<li><a href="http://support.cubehut.in" target="_blank">Support</a></li>
				<li><a href="http://cubehut.in" target="_blank">Cube Hut &copy;</a></li>
			</ul>
        </div>
      </div>
    </div>
  </footer>
 
  <!-- End Footer -->
</body>
</html>