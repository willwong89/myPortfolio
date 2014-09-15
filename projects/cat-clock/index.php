<?php include('../../header.php'); ?>

<!-- js for processing -->
<!--[if lt IE 9]>
	<script type="text/javascript">alert("Your browser does not support the canvas tag.");</script>
<![endif]-->
<script src="processing/processing.js" type="text/javascript"></script>
<!-- <script src="projects/cat-clock/processing.js" type="text/javascript"></script> -->
<script type="text/javascript">
// convenience function to get the id attribute of generated sketch html element
function getProcessingSketchId () { return 'catThemedClockjs'; }
</script>

	<section id="project">
		<h1>Cat Clock</h1>
		<section class="quote">
		A cat-themed clock.
		</section>
		
		<section class="other-works">
		</section>

		<section class="content">
		<!-- Intro | Problem | Process | Results -->
		
		<article>
			
			<!-- TODO: insert sketch & writeup -->
			<p>
			Time is a fundamental feature of computation. The objective of this project is to show the passage of time on 
			a clock that has a face, and that shows the passage of hours, minutes, and seconds. This project is written
			in Java and developed using Processing.
			</p>
	
			<p>
			I designed two different modes that satisfy abstraction and functionality individually. In the <i>abstract mode</i>,
			it highlights the aesthetic of the computer-code generated animation and focuses on the passage of time. The passage of
			time is stated by the wagging tail and the growing tail, yet if the user wants to know about the current time, he or she
			has to think a little bit (at least the user has to figure out that the nose is a button to trigger the explicit mode).
			In the <i>explicit mode</i>, the time is stated directly. As the focus is the functionality, the user is able to tell the
			time in a quick glance. 
			</p>
			


			<h2>Application Demo</h2>
			
   			<section class="processing" data-speed="10" data-type="background">
				<canvas id="catThemedClockjs" data-processing-sources="processing/catThemedClock_js.pde"  width="900" height="675">							
					<p>Your browser does not support the canvas tag.</p>
				</canvas>
				<noscript>
					<p>JavaScript is required to view the contents of this page.</p>
				</noscript>
			</section><!-- end section #project -->
			
			
			
			<h2>Download applicaton</h2>
			<p>
				<a class="button" href="download/application.windows32.zip">Windows 32</a>
				<a class="button" href="download/application.windows64.zip">Windows 64</a> 
				<a class="button" href="download/application.macosx.zip">Mac OSX</a>
			</p> 

		</article><!-- end article -->
	</section><!-- end content section -->
</section><!-- end project section -->







<?php include('../../footer.php'); ?>