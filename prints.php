<div class="portfolio-list">
	<h1>Prints</h1>
 
	<!-- 
	<div class="portfolioFilter">
		<a href="#" data-filter="*" class="current">All Categories</a>
		<a href="#" data-filter=".prints">Prints</a>
	</div>
	-->

	<div class="portfolioContainer">
	<?php
		$printFileName = array('aj6.png', 'am1.png', 'stimer.png', 'amazon.jpg', 'tokyo.jpg',
		'egypt.png', 'vancouver_b.png', 'vancouver_w.png', 'protect.png');
		
		$printThumbFileName = array('aj6.jpg', 'am1.jpg', 'stimer.jpg', 'amazon.jpg', 'tokyo.jpg',
		'egypt.jpg', 'vancouver_b.jpg', 'vancouver_w.jpg', 'protect.jpg');

		$printDescription = array('Air Jordan 6 Carmine', 'Air Max 1', 'Stimer', 'Amazon Rainforest', 'Tokyo, Japan',
		'Egypt - The Land of Eternal Sunshine', 'Vancouver - The Land of Natural Beauty', 'Vancouver - The Land of Natural Beauty',
		'Protect Your Lung');
		
		
		for($i=0 ; $i<count($printFileName) ; $i++){
			echo '<div class="portfolio-item">';//print-item
			echo '<a href="projects/prints/images/'.$printFileName[$i].'" data-lightbox="prints" data-title="'.$printDescription[$i].'">';
			echo '<img src="projects/prints/images/thumb/'.$printThumbFileName[$i].'" alt="image">';
			echo '</a>';
			echo '</div>';
		}//end for
	?>
 
	</div><!--  end portfolioContainer -->
</div> <!-- end portfolio-list -->

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

