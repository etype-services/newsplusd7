<div <?php print $attributes;?> class="<?php print $classes;?>">
  <?php if($section == 'frontend') :?>
    <button data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar tb-megamenu-button" type="button">
      <i class="fas fa-bars fa-2x" style="color:#000;"></i>
    </button>
    <div class="nav-collapse <?php print $block_config['always-show-submenu'] ? ' always-show' : '';?>">
  <?php endif;?>
  <?php print $content;?>
  <?php if($section == 'frontend') :?>
    </div>
  <?php endif;?>
</div>
