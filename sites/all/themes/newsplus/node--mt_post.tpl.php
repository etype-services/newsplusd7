<?php 
$reading_time = theme_get_setting('reading_time');
$share_links = theme_get_setting('share_links');
$print_button = theme_get_setting('print_button');
$font_resize = theme_get_setting('font_resize');
$post_progress = theme_get_setting('post_progress');
?>
<article id="node-<?php print $node->nid; ?>" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>
  
  <!-- node-content-wrapper -->
  <div id="printArea" class="node-content-wrapper clearfix">

    <?php if ( $page && ($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time )) { ?>
    <!-- node-side -->
    <div class="node-side">
      
      <?php if ($display_submitted) { ?>
      <div class="user-info">
        <?php print $user_picture; ?>
        <?php if ($display_submitted) { ?>
        <?php print t('By ');?> <?php print $name; ?>
        <?php } ?>
      </div>
      <?php } ?>
      
      <?php if ($reading_time) { ?>
      <!-- reading-time -->
      <div class="reading-time">
        <div><?php print t('Time to read')?></div>
          
        <?php 
        $node_content = $content;
        $node_content = render($node_content); 
        $words = str_word_count(strip_tags($node_content));
        $minutes = floor($words / 275);
        if ($minutes<1) { 
        print '<span>' . t('less than<br> 1 minute' . '</span>'); 
        } elseif ($minutes<2) {
        print '<span>' . $minutes . t(' minute') . '</span>';  
        } else {
        print '<span>' . $minutes . t(' minutes') . '</span>'; 
        }
        ?>
          
      </div>
      <!-- EOF: reading-time -->
      <?php } ?>
      
      <?php if ($share_links || $print_button || $font_resize || $display_submitted || $post_progress) { ?>
      <!-- #affix -->
      <div id="affix">
        
        <?php if ($share_links) { ?>
        <!-- share-links -->
        <div class="share-links">
          <?php print t('Share'); ?>
          <?php $path = isset($_GET['q']) ? $_GET['q'] : '<front>'; ?>
          <ul>
            <li><a href="https://www.facebook.com/sharer/sharer.php?u=<?php print urlencode(url($path, array('absolute' => TRUE)))?>&t=<?php print urlencode($title) ?>" onclick="window.open(this.href, 'facebook-share','width=580,height=296');return false;"><span><i class="fa fa-facebook"></i></span></a></li>
            <li><a href="https://plus.google.com/share?url=<?php print urlencode(url($path, array('absolute' => TRUE))) ?>" onclick="window.open(this.href, 'google-plus-share', 'width=490,height=530');return false;"><span><i class="fa fa-google-plus"></i></span></a></li>
            <li><a href="http://twitter.com/share?text=<?php print urlencode($title) ?>&url=<?php print urlencode(url($path, array('absolute' => TRUE))) ?>" onclick="window.open(this.href, 'twitter-share', 'width=550,height=235');return false;"><span><i class="fa fa-twitter"></i></span></a></li>
          </ul>
        </div>
        <!-- EOF:share-links -->
        <?php } ?>
        
        <?php if ($print_button || $font_resize || $display_submitted) { ?>
        <!-- submitted-info -->
        <div class="submitted-info">
          <?php if ($print_button) { ?>
          <div class="print">
            <i class="fa fa-print"></i> <a href="javascript:window.print()" class="print-button"> <?php print t(' Print')?></a>
          </div>
          <?php } ?>
          <?php if ($font_resize) { ?>
          <div class="font-resize">
            <a href="#" id="decfont">a-</a>
            <a href="#" id="incfont">a+</a>
          </div>
          <?php } ?>
          <?php if ($display_submitted) { ?>
          <div class="submitted-info-item">
            <?php print t('Published')?>
            <span><?php print $posted_ago; ?><?php print t(' ago')?></span>
          </div>
          <div class="submitted-info-item">
            <?php print t('Last updated')?>
            <span><?php print $changed_ago; ?><?php print t(' ago')?></span>
          </div>
          <?php } ?>
        </div>
        <!--EOF: submitted-info -->
        <?php } ?>
        
        <?php if ($post_progress) { ?>
        <!-- post-progress -->
        <div class="post-progress">
          <?php print t('Read so far')?>
          <span class="post-progress-value"></span>
          <div class="post-progressbar"></div>
        </div>
        <!-- EOF: post-progress -->
        <?php } ?>
      
      </div>
      <!-- EOF:#affix -->
      <?php } ?>

    </div>
    <!-- EOF:node-side -->
    <?php } ?>

    <!-- node-content -->
    <div class="node-content clearfix <?php if (!($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time) || (!$page)) { print ' ' . 'full-width'; } ?> ">
      <header>
        <?php print render($title_prefix); ?>
        <?php if (!$page) { ?>
          <h2 <?php print $title_attributes; ?> class="title"><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
        <?php } else { ?>
          <h1 class="title" <?php print $title_attributes; ?>><?php print $title; ?></h1>
        <?php } ?>
        <?php print render($title_suffix); ?>

        <?php if (isset($content['field_mt_post_categories']) || $display_submitted || (module_exists('comment') && ($node->comment == COMMENT_NODE_OPEN || ($node->comment == COMMENT_NODE_CLOSED && $node->comment_count > 0)))) { ?>
          <div class="node-info">
            <?php if ($display_submitted) { ?>
            <div class="node-info-item"><i class="fa fa-clock-o"></i> <?php print format_date($created, 'custom', 'F d, Y - H:i'); ?></div>
            <?php } ?>
            <?php if (isset($content['field_mt_post_categories'])) { ?>
            <div class="node-info-item"><i class="fa fa-tags"></i> <?php print t('Posted in: ');?><?php print render($content['field_mt_post_categories']);  ?></div>
            <?php } ?>
            <?php if (module_exists('comment') && ($node->comment == COMMENT_NODE_OPEN || ($node->comment == COMMENT_NODE_CLOSED && $node->comment_count > 0))) { ?>
            <div class="node-info-item"><i class="fa fa-comments"></i> <?php print $comment_count; ?> comments</div>
            <?php } ?>
          </div>
        <?php } ?>
      </header>

      <div class="content clearfix"<?php print $content_attributes; ?>>
        <?php
          // We hide the comments and links now so that we can render them later.
          hide($content['comments']);
          hide($content['links']);
          print render($content);
        ?>
      </div>
      
      <?php if ($links = render($content['links'])): ?>
      <footer class="node-footer">
      <?php print render($content['links']); ?>
      </footer>
      <?php endif; ?>

      <?php print render($content['comments']); ?>
    </div>
    <!-- EOF:node-content -->

  </div>
  <!-- EOF: node-content-wrapper -->

</article>