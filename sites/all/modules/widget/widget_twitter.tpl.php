
  <ul id="twitter_update_list" class="widget-twitter">

   <?php foreach ((array)$list as $item) {?>
     <li>
     	<?php if(isset($item->user->profile_image_url) && $item->user->profile_image_url):?>
     	<div class="avata"><img src="<?php print $item->user->profile_image_url; ?>"></div>
     	<?php endif; ?>
     	<div class="description">
	        <span><?php print '@'. (isset($item->user->name) ?$item->user->name : '') ; ?>: </span>
	        <span><?php echo (isset($item->text) ? $item->text : ''); ?></span>
	    </div>   
	    <div class="date">
	    	<span><?php print (isset($item->created_at) ? getAgo(strtotime($item->created_at)):''); ?> </span>
	    </div>	
     </li>
   <?php } ?>
  </ul>
<!-- <a href="http://twitter.com/<?php print $settings['widget_twitter_username']; ?>" class="twitter-link" title="Follow me on twitter →">Follow me on twitter →</a></p> -->
  