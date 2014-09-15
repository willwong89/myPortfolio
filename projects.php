<div id="portfolio">
 
<!-- <h1>Projects</h1> -->

<!-- 
<div class="portfolioFilter">
	<a href="#" data-filter="*" class="current">All Categories</a>
	<a href="#" data-filter=".prints">Prints</a>
</div>
 -->
<!-- 
	<div class="portfolio-item">
		<a href="#"> 
		<img src="projects/basketball-arcade/thumb.jpg" alt="image">
		<p class="description">Basketball Arcade</p>
		</a>
	</div>
	
	<div class="portfolio-item">
		<a href="index.php?project=antlion"> 
		<img src="projects/antlion/thumb.jpg" alt="image">
		<p class="description">Antlion</p>
		</a>
	</div>
	
	<div class="portfolio-item">
		<a href="#"> 
			<img src="projects/shark-shark/thumb.jpg" alt="image">
			<p class="description">Shark! Shark!</p>
		</a>
	</div>
 -->
<div class="portfolio-list">
	<h1>Game <br /> Design</h1>
	<div class="portfolioContainer">
	<?php
		$gameDesignPath = array('basketball-arcade', 'antlion', 'shark-shark');
		$gameDesignTitle = array('Basketball Arcade', 'Antlion', 'Shark!Shark!');
		$gameDesignDescription = array(
		'A drag-and-shoot basketball arcade game.', 
		'Given an Antlion Flash game, our goal is to redesign it and make it fun.', 
		'Eat the smaller fish, bite the shark\'s tail.');
	
		for($i=0 ; $i<count($gameDesignPath) ; $i++){
			echo '<div class="portfolio-item">';
			echo '<a href="projects/'.$gameDesignPath[$i].'/index.php#content" onclick="saveScrollPos()">';
			//echo '<a href="index.php?project='.$gameDesignPath[$i].'" onclick="saveScrollPos()">';
			echo '<img src="projects/'.$gameDesignPath[$i].'/images/thumb.jpg" alt="image">';
			echo '<div class="title">'.$gameDesignTitle[$i].'</div>';
			echo '<div class="description">'.$gameDesignDescription[$i].'</div>';
			echo '</a>';
			echo '</div>';
		}//end for
	?>
	</div><!--  end portfolioContainer -->
</div><!-- end portfolio-list -->


<div class="portfolio-list">
	<h1>Visual <br /> Analytics</h1>
	<div class="portfolioContainer">
	<?php
		$visualAnalyticPath = array('crimes-in-california', 'time-series', 'scatterplot', 'cat-clock');
		$visualAnalyticTitle = array('Crimes in California', 'Time Series', 'Scatterplot', 'Cat Clock');
		$visualAnalyticDescription = array(
		'.', 
		'A Time Series that visualizes the foreign exchange rates from Jan 1983 to Jun 1985.', 
		'A Scatterplot that visualizes a famous testbed dataset that contains 150 cases of Irises found on the Gaspe Peninsula.', 
		'A cat-themed clock.');
		for($i=0 ; $i<count($visualAnalyticPath) ; $i++){
			echo '<div class="portfolio-item">';
			echo '<a href="projects/'.$visualAnalyticPath[$i].'/index.php#content" onclick="saveScrollPos()">';
			echo '<img src="projects/'.$visualAnalyticPath[$i].'/images/thumb.jpg" alt="image">';
			echo '<div class="title">'.$visualAnalyticTitle[$i].'</div>';
			echo '<div class="description">'.$visualAnalyticDescription[$i].'</div>';
			echo '</a>';
			echo '</div>';
		}//end for
	?>
	</div><!--  end portfolioContainer -->
</div><!-- end portfolio-list -->



<div class="portfolio-list">
	<h1>Digital <br /> Design</h1>
	<div class="portfolioContainer">
	<?php
		$digitalDesignPath = array('optizkan', 'noteit');
		$digitalDesignTitle = array('Optizkan', 'NoteIT');
		$digitalDesignDescription = array('D&AD Student Award 2012 Digital Design Best of Year', 
				'Taking notes with traditional typing method and simple drawing features.');
		for($i=0 ; $i<count($digitalDesignPath) ; $i++){
			echo '<div class="portfolio-item">';
			echo '<a href="projects/'.$digitalDesignPath[$i].'/index.php#content" onclick="saveScrollPos()">';
			echo '<img src="projects/'.$digitalDesignPath[$i].'/images/thumb.jpg" alt="image">';
			echo '<div class="title">'.$digitalDesignTitle[$i].'</div>';
			echo '<div class="description">'.$digitalDesignDescription[$i].'</div>';
			echo '</a>';
			echo '</div>';
		}//end for
	?>
	</div><!--  end portfolioContainer -->
</div><!-- end portfolio-list -->



<?php include'prints.php'; ?> 

</div><!-- end portfolio -->
 
<script type="text/javascript">

$(window).load(function(){
    var $container = $('.portfolioContainer');
    $container.isotope({
        filter: '*',
        animationOptions: {
            duration: 750,
            easing: 'linear',
            queue: false
        }
    });
 
    $('.portfolioFilter a').click(function(){
        $('.portfolioFilter .current').removeClass('current');
        $(this).addClass('current');
 
        var selector = $(this).attr('data-filter');
        $container.isotope({
            filter: selector,
            animationOptions: {
                duration: 750,
                easing: 'linear',
                queue: false
            }
         });
         return false;
    }); 
});
</script>

