<?php include('../../header.php'); ?>

<!-- js for processing -->
<!--[if lt IE 9]>
	<script type="text/javascript">alert("Your browser does not support the canvas tag.");</script>
<![endif]-->
<script src="processing/processing.js" type="text/javascript"></script>
<!-- <script src="projects/antlion/processing.js" type="text/javascript"></script> -->
<script type="text/javascript">
// convenience function to get the id attribute of generated sketch html element
function getProcessingSketchId () { return 'antlionJS'; }
</script>
	
	
	<section id="project">
 
		<h1>Antlion</h1>
		<section class="quote">
		Given an Antlion Flash game, our goal is to redesign it and make it fun.
		</section>
	
		<section class="other-works">
		</section>
	
	
		<section class="content">
		<!-- Intro | Problem | Process | Results -->
		
		<article>
			
			<iframe src="//player.vimeo.com/video/96336677?title=0&amp;byline=0&amp;portrait=0" width="66%" height="500px" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> 
			<p>
				This is the original Antlion game that we were given (designed by Andrew Thong, Ada Fu, Charles Cheung, and
				Wei-Li Tsai).

				We played it multiple times and we found that it is very frustrating as 
				the enemy's attack (landslide) is entirely random and unpredictable. We analyzed it, 
				redesigned it, and built a working prototype using Processing.
			</p>
		
			
			<h2>Application Demo</h2>
			<section id="project" data-speed="10" data-type="background">
				<canvas id="antlionJS" data-processing-sources="processing/AntlionGame-serverFriendlyVersion.pde" width="300" height="600"> 
					<p>Your browser does not support the canvas tag.</p>
				</canvas>
				<noscript>
					<p>JavaScript is required to view the contents of this page.</p>
				</noscript>
			</section><!-- end  Section #project -->
			<!-- <section style="text-align:center;font-size:12px;"> -->
				<p><i>Click the prototype to get started.</i></p>
			<!-- </section> -->
			
		
			
			<h2>Download applicaton</h2>
			<p>
				<a class="button" href="download/application.windows32.zip">Windows 32</a>
				<a class="button" href="download/application.windows64.zip">Windows 64</a> 
				<a class="button" href="download/application.macosx.zip">Mac OSX</a><br/>
			</p>

			<h2>Documentations</h2>
			
			<p>
				<a class="button" href="docs/312_P1_Phase1_HLDD.pdf" target="_blank">High Level Design Document</a>
				<a class="button" href="docs/312_P1_Phase2_ProjectReport.pdf" target="_blank">Project Report</a>
				<a class="button" href="docs/312_P1_Phase2_PlayTestingReport.pdf" target="_blank">Play Test Report</a>	
			</p>
		</article><!-- end article -->

	</section><!-- end project section -->


<?php include('../../footer.php'); ?>