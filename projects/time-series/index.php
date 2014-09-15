<?php include('../../header.php'); ?>

<!-- js for processing -->
<!--[if lt IE 9]>
	<script type="text/javascript">alert("Your browser does not support the canvas tag.");</script>
<![endif]-->
<script src="processing/processing.js" type="text/javascript"></script>
<!-- <script src="projects/cat-clock/processing.js" type="text/javascript"></script> -->
<script type="text/javascript">
// convenience function to get the id attribute of generated sketch html element
function getProcessingSketchId () { return 'IAT355_A2_JS_original'; }
</script>

	
	<section id="project">
		<h1>Timer Series</h1>
		<section class="quote">
		A Time Series that visualizes the foreign exchange rates from Jan 1983 to Jun 1985.
		</section>
		
		<section class="other-works">
		</section>

		<section class="content">
		<!-- Intro | Problem | Process | Results -->
		
		<article>

			<p>
			The Time Series visualization reads data from a comma-separated text file. The visualization 
			code is written in Java using Processing. This visualization has the follow features: 
			</p>
			
			<ol>
			<li>
				<b>Object-Oriented.</b> A class entitled TimeSeries is built to store all of the visual dimensions of an individual Time Series and plots it on the screen.
				Each plotted Time Series is an instance of this class.
				</li>
				<li>
				Multiple visual attributes are supported:
				<ul>
					<li>
						Plot Time Series as a connected or disconnected sequence of line segments.
					</li>
					<li>
						Color of the line segments
					</li>
				</ul>
			</li>
			<li>
				<b>Automatic scaling.</b> The Plot is automatically sized on the basis of the variables that are assigned to the X and Y dimensions. This would be the extreme values of all of the time series.
			</li>
			<li>
				<b>Grid Marking.</b> The axes has tick marks appropriate to the X and Y values to mark regular data intervals.
			</li>
			<li>
				<b>Interaction.</b> Buttons on the left to select what data gets drawn (which series).
			</li>
			<li>
				<b>Filtering:</b> Interactively filter out data the falls outside of boundaries that the user sets. The filter is applied to all of the currently mapped time series. 
			</li>
			</ol>
			
			<!--
			<a href="images/01.jpg" data-lightbox="shark-shark" data-title="Instruction"> 
				<img src="images/01.jpg">
			</a>
			-->
			
			<h2>Application Demo</h2>
			
   			<section class="processing" data-speed="10" data-type="background">
				<canvas id="IAT355_A2_JS_original" data-processing-sources="processing/IAT355_A2_JS_original2.pde" 
						width="900" height="675">			
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
				<a class="button" href="download/application.macosx.zip">Mac OSX</a><br/>
			</p>
			
			
		</article><!-- end article -->
	</section><!-- end content -->
</section><!-- end project section -->



<?php include('../../footer.php'); ?>