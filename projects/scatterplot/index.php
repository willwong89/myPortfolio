<?php include('../../header.php'); ?>
	
	<section id="project">
		<h1>Scatterplot</h1>
		<section class="quote">
		A Scatterplot that visualizes a famous testbed dataset that contains 150 cases of Irises found on the Gaspe Peninsula.
		</section>
		
		<section class="other-works">
		</section>

		<section class="content">	
		<!-- Intro | Problem | Process | Results -->
		
		<article>

			<p>
			The Scatterplot visualization reads data from a comma-separated text file. The visualization 
			code is written in Java using Processing. This visualization has the follow features: 
			</p>
			
			<ol>
			<li>
				<b>Object-Oriented.</b> A class entitled ScatterPlotPoint is built to store all of the visual dimensions of an individual point and plots it on the screen.
				Each plotted point will be an instance of this class.
				</li>
				<li>
				Multiple visual attributes are supported:
				<ul>
					<li>
						Plot mark along the X Axis
					</li>
					<li>
						Plot mark along the Y Axis
					</li>
					<li>
						Color of the mark
					</li>
					<li>
						Size of the mark
					</li>
					<li>
						Either shape or orientation of the mark
					</li>
				</ul>
			</li>
			<li>
				<b>Automatic scaling.</b> The Plot is automatically sized on the basis of the variables that are assigned to the X and Y dimensions.
			</li>
			<li>
				<b>Grid Marking.</b> The axes have tick marks appropriate to the X and Y values to mark regular data intervals.
			</li>
			<li>
				<b>Variable Assignment.</b> Data Variables can be assigned to any of the different visual attributes.
			</li>
			<li>
				<b>Interaction.</b> There are comboboxes that assign data dimensions to visual dimensions. <!--There must be an interaction technique per visual dimension.-->
			</li>
			<li>
				<b>Filtering:</b> Interactively filter out data the falls outside of boundaries that you set.The filters apply to the currently mapped visual dimensions. 
				<!--A filter must be interactively enabled/disabled.-->
			</li>
			</ol>
			
			
			<h2>Application Demo</h2>
			<iframe src="//player.vimeo.com/video/97175943?title=0&amp;byline=0&amp;portrait=0" width="66%" height="439px" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> 
			
			
			<h2>Download applicaton</h2>
			
			<p>
				<a class="button" href="download/application.windows32.zip">Windows 32</a>
				<a class="button" href="download/application.windows64.zip">Windows 64</a> 
				<a class="button" href="download/application.macosx.zip">Mac OSX</a><br/>
			</p>
		</article><!-- end article -->
	</section><!-- end content section -->
</section><!-- end project section -->



<?php include('../../footer.php'); ?>