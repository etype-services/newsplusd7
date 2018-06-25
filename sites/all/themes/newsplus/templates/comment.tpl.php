<article class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>

    <header>
        <?php print $picture; ?>
    </header>

    <div class="content"<?php print $content_attributes; ?>>
    
    <?php if ($new): ?>
    <span class="new"><?php print $new ?></span>
    <?php endif; ?>

    <div class="submitted">
    <?php print $submitted; ?>
    </div>
    
    <?php print render($title_prefix); ?>
    <h3<?php print $title_attributes; ?> class="title"><?php print $title ?></h3>
    <?php print render($title_suffix); ?>
    
    <?php
      // We hide the comments and links now so that we can render them later.
      hide($content['links']);
      print render($content);
    ?>
    <?php if ($signature): ?>
    <div class="user-signature clearfix">
      <?php print $signature ?>
    </div>
    <?php endif; ?>
    </div>
    
    <?php print render($content['links']) ?>

</article>