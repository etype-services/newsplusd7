<?php foreach ($rows as $id => $row) {
$view = views_get_current_view();
$nid = $view->result[$id]->nid;
$node = node_load($nid);
}
$thumbnails = field_get_items('node', $node, 'field_mt_banner_image');

$numberOfImages = 0;
$count = 0;
foreach ($thumbnails as $key=>$file) { $numberOfImages++;  }
?>
<div id="internal-banner-container">
    <!-- #internal-banner-slider -->
	<div id="internal-banner-slider" class="<?php if ($numberOfImages < 2) { print ' ' . 'one-value'; } ?> flexslider clearfix">
        <ul class="slides">
        	<?php foreach ($rows as $id => $row) { ?>
        	<li>
        		<?php print $row; 
        		$image_title = $thumbnails[$count]['title']; 
        		$image_alt = $thumbnails[$count]['alt']; 
        		if ($image_alt || $image_title) { ?>
				<div class="banner-caption <?php if (!$image_title) { print ' ' . 'hidden-xs'; } ?>">
					<div class="caption-title"><?php print $image_title; ?></div>
					<div class="caption-body hidden-xs"><?php print $image_alt; ?></div>
				</div>        			
        		<?php }
			    $count++; ?>
        	</li>
        	<?php } ?>
		</ul>
	</div>
	<!-- EOF:#internal-banner-slider --> 
	<?php if ($numberOfImages > 1) { ?>    
	<!-- #internal-slider-carousel -->
    <div id="internal-slider-carousel-container">
	   <div id="internal-slider-carousel" class="flexslider">
    		<ul class="slides">
    			<?php					
    			foreach ($thumbnails as $key=>$file) {
    			$thumbnail = field_view_value('node', $node, 'field_mt_banner_image', $thumbnails[$key], array('type' => 'image','settings' => array('image_style' => 'mt_thumbnails',)));?>
    			<li>
    				<?php print render($thumbnail); ?>
    			</li>
    			<?php } ?> 
    		</ul>
        </div>
	</div>    
	<!-- EOF:#internal-slider-carousel --> 
	<?php } ?> 
</div>
<?php
$internal_banner_effect=theme_get_setting('internal_banner_effect');
if ($numberOfImages>1) {
drupal_add_js('
    jQuery(document).ready(function($) {
        // store the slider in a local variable
        var $window = $(window),
        flexslider;

        // tiny helper function to add breakpoints
        function getGridSize() {
        return (window.innerWidth < 768) ? 3 : 6;
        }

        $(window).load(function() {
        
        $("#internal-banner-slider").fadeIn("slow");
        $("#internal-slider-carousel").fadeIn("slow");

        // The slider being synced must be initialized first
        $("#internal-slider-carousel").flexslider({
		animation: "slide",
        controlNav: false,
        animationLoop: false,
        slideshow: false,
        itemWidth: 166,
        itemMargin: 4.8,
        prevText: "",           
        nextText: "",
        asNavFor: "#internal-banner-slider",
        minItems: getGridSize(), // use function to pull in initial value
        maxItems: getGridSize(), // use function to pull in initial value
        start: function(slider){
        flexslider = slider;
        }        
        });

        $("#internal-banner-slider").flexslider({
        useCSS: false,            
        animation: "'.$internal_banner_effect.'",
        controlNav: false,
        directionNav: false,
        animationLoop: false,
        slideshow: false,
        sync: "#internal-slider-carousel"
        });
        
        });

        // check grid size on resize event
        $window.resize(function() {
        var gridSize = getGridSize();
        flexslider.vars.minItems = gridSize;
        flexslider.vars.maxItems = gridSize;
        });
    });',array('type' => 'inline', 'scope' => 'footer', 'weight' => 5));
} else {
drupal_add_js('
    jQuery(document).ready(function($) {
        $(window).load(function() {
	        $("#internal-banner-slider").fadeIn("slow");
        });
    });',array('type' => 'inline', 'scope' => 'footer', 'weight' => 5));
}
?>