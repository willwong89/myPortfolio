<?php include('../../header.php'); ?>

<!-- js for processing -->
<!--[if lt IE 9]>
	<script type="text/javascript">alert("Your browser does not support the canvas tag.");</script>
<![endif]-->
<script src="processing/processing.js" type="text/javascript"></script>
<!-- <script src="projects/cat-clock/processing.js" type="text/javascript"></script> -->
<script type="text/javascript">
// convenience function to get the id attribute of generated sketch html element
function getProcessingSketchId () { return 'SharkShark_JS'; }
</script>

	
	<section class="portfolio">
		<h1>Shark!Shark!</h1>
		<section class="quote">
		Eat the smaller fish, bite the shark's tail.
		</section>
		
		<section class="other-works">
<!-- 
			Other Works:
		<ul>
			<li>1</li>
			<li>2</li>
			<li>3</li>
		</ul>
 -->
		</section>

		<section class="content">
<!-- 	Intro | Problem | Process | Results -->
		
		<article>

			<p>
			The first game I've ever made using Processing back in my second year in 2011. Inspired by the classic game "Shark!Shark!", the player's objective
			is to get bigger in size by eating smaller fish. At the same time, the player has to avoid bigger fish and the shark, that can only be killed by 
			biting its tail from the back 4 times.
			</p>
			
			<a href="images/01.jpg" data-lightbox="shark-shark" data-title="Instruction"> 
				<img src="images/01.jpg">
			</a>
			
			<p>
			The core mechanics simple and straightforward: the player uses the arrow keys to control the movements in order to avoid or attack other fish objects. 
			Various states are designed and implemented specifically for different objects in order to make the game more playable. For example, if an enemy fish or the shark
			dies, the "Die" state is triggered and the dead object slowly fades out to provide feedbacks to the users. When the player respawns, it is automatically in an 
			invincible state for a few seconds in order to ensure that the player wouldn't get killed again immediately.
			</p>

			<a href="images/gameplay.jpg" data-lightbox="shark-shark" data-title="gameplay"> 
				<img src="images/gameplay.jpg">
			</a>
			<p>
				A current score and a highest score counter are implemented to motivate the player to keep playing and make a new record. The size and number of enemy is calculated 
				based on the player's score and current size in order to balance the difficulty and to ensure that the enemy fish object sizes are balanced.
			</p>
			<a href="images/code.jpg" data-lightbox="shark-shark" data-title="Processing Code"> 
				<img src="images/code.jpg">
			</a>
			<p>
				It is written in Java following the Object-Oriented paradigm. The GeneralFish class is a parent class that encapsulates all the shared attributes and methods between
				the children classes, including PlayerFish, EnemyFish, and Shark.
			</p>
			
			
			
	
		
			<h2>Application Demo</h2>
			
   			<section class="processing" data-speed="10" data-type="background">
				<canvas id="catThemedClockjs" data-processing-sources="processing/SharkShark_JS.pde" 
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
		

<!-- 
		<table>
			<tr>
				<td><b>Domain</b></td>
				<td>Simon Fraser University</td>
			</tr>
			<tr>
				<td><b>Team</b></td>
				<td>N/A</td>
			</tr>
			<tr>
				<td><b>Role</b></td>
				<td>Game designer, programmer</td>
			</tr>
		</table>
 -->
		
		
	</section><!-- end content -->
	

	
	
</section><!-- end portfolio section -->



<?php include('../../footer.php'); ?>