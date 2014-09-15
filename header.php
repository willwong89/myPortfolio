<?php $root = "http://localhost/willwong/";?>
<?php //$root = "http://willwong.info/";?>
<?php //include_once("$rootincludes/analyticstracking.php") ?>

<!DOCTYPE html>
<html>

<head>
	<title>willwong.info</title>
	<link rel="stylesheet" type="text/css" href="<?php echo $root;?>style/style.css">
	
	<!-- lightbox -->
	<script src="<?php echo $root;?>includes/lightbox/js/jquery-1.11.0.min.js"></script>
	<script src="<?php echo $root;?>includes/lightbox/js/lightbox.min.js"></script>
	<link href="<?php echo $root;?>includes/lightbox/css/lightbox.css" rel="stylesheet" />
	
	<!-- isotope -->
	<link rel="stylesheet" href="<?php echo $root;?>includes/isotope/css/style.css">
	<!-- 	<script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script> -->
	<script src="<?php echo $root;?>includes/jquery-latest.js" type="text/javascript"></script>
	<script src="<?php echo $root;?>includes/isotope/js/jquery.isotope.js" type="text/javascript"></script> 
	
	<!-- google analytics -->
	<script>
  	// (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  	// (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  	// m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  	// })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  	// ga('create', 'UA-51319436-1', 'willwong.info');
  	// ga('send', 'pageview');
	</script>

	<!--  google fonts -->
	<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,700,300,100' rel='stylesheet' type='text/css'>
	<!-- js sticky plugin -->
	<!-- 
	<script type="text/javascript" src="<?php echo $root;?>includes/sticky/jquery.sticky.js"></script>
	<script>
    $(window).load(function(){
      $("#nav").sticky({ topSpacing: 0 });
    });
	</script>
 	-->
	 
	

</head>


<body>

<div id="container">
	<div id="header">
		<div id="nav-top-spacer"></div>
		
		<div id="nav">
		
			<a href="<?php echo $root; ?>"><img id="header-logo" src="<?php echo $root;?>images/logo/header.png" width="150px"/></a>
			<div id="header-nav">
				<a href="#">projects</a> | <a href="#">contact me</a> 
			</div>
			<div id="output"></div>
			<br />
			
			
		</div><!-- end nav -->
		<div id="nav-bg"></div>
		<!-- 
		<script src="showCurrentTime.js"></script>
		<div id="time">
			<script>showCurrentTime();</script>
		</div>
		 -->
		 
	</div><!-- 	end header -->

	<!-- sticky nav js -->
	<script>
	var nav = document.getElementById("nav");
	var navBG = document.getElementById("nav-bg");
	var headerLogo = document.getElementById("header-logo");
	var stop = (nav.offsetTop);
	var $output = $( "#output" );

	window.onscroll = function (e) {
    	var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
    	console.log(scrollTop, nav.offsetTop);
    	
    	if (scrollTop >= stop) {	//scrollTop 500 >= 600
    		document.getElementById("nav-top-spacer").className = 'stick';
       		nav.className = 'stick';
       	} else {
    		document.getElementById("nav-top-spacer").className = '';
        	nav.className = '';
    	}
    	


    	var biggestLogoWidth = 400;
    	
    	
    	
    	
    	var smallestLogoWidth = 50;

    	var xxx = (scrollTop-500)*4;
    	if(scrollTop<500){
    		navBG.className = '';	//remove bg
			headerLogo.style.width = biggestLogoWidth+'px';
    	} 
    	else if(scrollTop>=500 && scrollTop<=600){
			navBG.className = 'stick';	//stick bg
			//headerLogo.style.width = biggestLogoWidth+'px';
			headerLogo.style.width = 450-xxx+'px';
    		//  nav-bg.stick transition 
    		//navBG.style.opacity = ((scrollTop-500) / 100 ) -0.1;
    	} 
    	else if(scrollTop>600){
    		navBG.className = 'stick';	//stick bg
    		//headerLogo.style.width = 450-xxx+'px';
    		headerLogo.style.width = smallestLogoWidth+'px';


    		
    	}
    	//$output.html( 'scrollTop > 600 - logoH:' + headerLogo.height );
	}
	</script>
	<!-- end sticky nav js-->
	
	<!-- scroll portfolio-list opacity fade in animation -->
	<script>
	var portfolio = document.getElementById("portfolio");
	(function( $ ) {
		$(function() {
		    	$( window ).scroll(function() {
		    		//scrolling
    				clearTimeout( $.data( this, "scrollCheck" ) );
    				$.data( this, "scrollCheck", setTimeout(function() {
    					//stopped scrolling, update div opacity
    					var portfolioList = document.getElementsByClassName('portfolio-list');
    					var windowHeight = $(window).height();
    					for(var i=0 ; i<portfolioList.length ; i++){
							var offsets = portfolioList[i].getBoundingClientRect();
							var offsetHeight = portfolioList[i].offsetHeight;
							var top = offsets.top;
							var padding = 100;
							//manipulate div css according to pos
							if(top>windowHeight-padding || top+offsetHeight<=padding) //div[i] is offscrean
								portfolioList[i].style.opacity = "0.2";
							else
								portfolioList[i].style.opacity = "0.9";
    					}//end for
    				}, 250) );
    			});
		});
	})( jQuery );
	</script>
	<!-- end scroll portfolio-list opacity fade in animation -->
<div id="content">


