<div id="slideshow" class="main-slider">

    <div class="flexslider">
        <ul class="slides">
        <?php foreach ($rows as $id => $row) { ?>
        <li>
        
        <?php $view = views_get_current_view();
        $nid = $view->result[$id]->nid; 
        $node = node_load($nid);
        $lang = 'und';
        
        if ($node->type=='mt_slideshow_entry') {
        
            if ($node->field_mt_teaser_image) {
            
                $image = image_style_url('mt_slideshow', $node->field_mt_teaser_image[$lang][0]['uri']); 
                $title = $node->field_mt_teaser_image[$lang][0]['title'];
                $alt = $node->field_mt_teaser_image[$lang][0]['alt']; ?>
            
                <?php if ($node->field_mt_slideshow_path) {
                 
                $path = $node->field_mt_slideshow_path[$lang][0]['value']; ?>
                <div class="views-field views-field-field-teaser-image">
                    <div class="field-content">
                    <a href="<?php print url($path); ?>"><img  src="<?php print $image; ?>" title="<?php print $title; ?>" alt="<?php print $alt; ?>"/></a>
                    </div>
                </div>
                <?php } else { ?>
                <div class="views-field views-field-field-teaser-image">
                    <div class="field-content">
                    <img  src="<?php print $image; ?>" title="<?php print $title; ?>" alt="<?php print $alt; ?>"/>
                    </div>
                </div>
                <?php } ?>
            
            <?php } ?>

            <div class="caption">
            	
				<?php $title = $node->title; ?>
                <?php if ($node->field_mt_slideshow_path) { ?>
                <?php $path = $node->field_mt_slideshow_path[$lang][0]['value']; ?>
                <h1><a href="<?php print url($path); ?>"><?php print $title; ?></a></h1>
                <?php } else { ?>
                <h1><?php print $title; ?></h1>
                <?php } ?>

            </div>
            
        <?php } else { print $row; } ?> 
        
        </li>
        <?php } ?>
        </ul>
    </div>
</div> 
<?php
$effect=theme_get_setting('slideshow_effect');
$effect_time = (int) theme_get_setting('slideshow_effect_time')*1000;

drupal_add_js('jQuery(document).ready(function($) { 

	$(window).load(function() {
        $("#slideshow .flexslider").fadeIn("slow");
		$("#slideshow .flexslider").flexslider({
		animation: "'.$effect.'",             // Select your animation type, "fade" or "slide"
		slideshowSpeed: "'.$effect_time.'",   // Set the speed of the slideshow cycling, in milliseconds
        prevText: "",           
        nextText: "",           
		pauseOnAction: false,
        useCSS: false
		});
		
	});
});',
array('type' => 'inline', 'scope' => 'header'));
	
?>