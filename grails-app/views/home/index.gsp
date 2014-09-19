<!DOCTYPE html>
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <!-- Set the viewport width to device width for mobile -->
  <meta name="viewport" content="width=device-width" />
  <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
  <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
  <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
  <title>Welcome to Manthan | Cube Hut &copy;</title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'normalize.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'foundation.css')}" type="text/css">
  <script src="${resource(dir: 'js', file: 'vendor/custom.modernizr.js')}"></script>
  <script>
  	document.write('<script src=${resource(dir: 'js', file: 'vendor/')}' +  ('__proto__' in {} ? 'zepto' : 'jquery') +  '.js><\/script>');
  </script>
  <script src="${resource(dir: 'js', file: 'foundation.min.js')}"></script>
  <script>
    $(document).foundation();
  </script>  
</head>
<body>

  <div class="row">
    <div class="large-3 columns">
      <h1><img src="${resource(dir: 'images', file: 'logo.png')}" width="50%"/></h1>
    </div>
    <div class="large-9 columns">
         <a href="${createLink(uri: '/login')}" class="radius button right">Sign In</a>
     </div>
  </div>  
<!-- End Header and Nav -->
<!-- First Band (Slider) -->

  <div class="row">
    <div class="large-12 columns">
    <ul data-orbit>
      <li><img src="${resource(dir: 'images', file: '1000x400&text.gif')}" /></li>
    </ul>
    <!-- <div id="slider">
      
    </div> -->
    
    <hr />
    </div>
  </div>
  
<!-- Three-up Content Blocks -->

	<div class="row">
		<div class="large-4 columns">
      <img src="${resource(dir: 'images', file: '400x300&text.gif')}" />
      <h4>This is a content section.</h4>
      <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa. Boudin aliqua adipisicing rump corned beef.</p>
    </div>
    
    <div class="large-4 columns">
      <img src="${resource(dir: 'images', file: '400x300&text.gif')}" />
      <h4>This is a content section.</h4>
      <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa. Boudin aliqua adipisicing rump corned beef.</p>
    </div>
    
    <div class="large-4 columns">
      <img src="${resource(dir: 'images', file: '400x300&text.gif')}" />
      <h4>This is a content section.</h4>
      <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa. Boudin aliqua adipisicing rump corned beef.</p>
    </div>
	
    </div>
    
<!-- Call to Action Panel -->
<div class="row">
    <div class="large-12 columns">
    
      <div class="panel">
        <h4>Get in touch!</h4>
            
        <div class="row">
          <div class="large-9 columns">
            <p>We'd love to hear from you.</p>
          </div>
          <div class="large-3 columns">
            <a href="#" class="radius button right">Contact Us</a>
          </div>
        </div>
      </div>
      
    </div>
  </div>

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