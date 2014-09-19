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
<g:layoutHead />
<r:layoutResources />
</head>
<body>	
	<g:layoutBody />
	<r:layoutResources />	
    <script>
		document.write('<script src=${resource(dir: 'js', file: 'vendor/')}' +  ('__proto__' in {} ? 'zepto' : 'jquery') +  '.js><\/script>');
	</script>
	<script src="${resource(dir: 'js', file: 'foundation.min.js')}"></script>
	<script>
	  $(document).foundation();
	</script>
</body>
</html>