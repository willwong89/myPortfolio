<?php include 'header.php';  ?>


<!-- 
	<div id="project-open">
	<h1>header 1</h1>
	<p style="text-align:center;">paragraph</p>
	</div>
	
 -->
	


	
	<?php
		$project;
		if(!empty($_GET['project'])) $project = $_GET['project'];	/* gets the variable $page */
		if (!empty($project)) {
			include('projects/'.$project);
		} 	/* if $page has a value, include it */
		else {
			include('projects.php');
		} 	/* otherwise, include the default page */
	?>
	<?php //include 'projects.php'; ?> 
	<?php include 'contact-me.php';?>

	

<?php include 'footer.php'; ?>