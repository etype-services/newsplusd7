<?php if (isset($page['topbar'])) : ?>
<div id="topbar">
    <?php print render($page['topbar']); ?>
</div>
<?php endif; ?>

<header id="header">
   
   <?php if (isset($page['branding'])) : ?>
      <?php print render($page['branding']); ?>
   <?php endif; ?>
   <div class="header-main">
      <div class="container">
         <div class="header-main-inner">
            <div class="row">
               <div class="col-xs-12">
                  <?php if ($logo): ?>
                        <h1 class="logo">
                              <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>" rel="home" id="logo">
                                    <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>"/>
                              </a>
                        </h1>
                  <?php endif; ?>

                  <?php if ($site_name || $site_slogan): ?>
                        <div id="name-and-slogan"<?php if ($disable_site_name && $disable_site_slogan) {
                              print ' class="hidden"';
                        } ?>>

                              <?php if ($site_name): ?>
                                 <?php if ($title): ?>
                                       <div id="site-name"<?php if ($disable_site_name) {
                                             print ' class="hidden"';
                                       } ?>>
                                             <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>"
                                                 rel="home"><span><?php print $site_name; ?></span></a>
                                       </div>
                                 <?php else: /* Use h1 when the content title is empty */ ?>
                                       <h1 id="site-name"<?php if ($disable_site_name) {
                                             print ' class="hidden"';
                                       } ?>>
                                             <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>"
                                                 rel="home"><span><?php print $site_name; ?></span></a>
                                       </h1>
                                 <?php endif; ?>
                              <?php endif; ?>

                              <?php if ($site_slogan): ?>
                                 <div id="site-slogan"<?php if (($disable_site_slogan)) { print ' class="hidden"'; }
                                    if ((!$disable_site_slogan) AND ($disable_site_name)) { } ?>> <?php print $site_slogan; ?>
                                 </div>
                              <?php endif; ?>

                        </div> <!-- /#name-and-slogan -->
                  <?php endif; ?>
               </div>
            </div> 
         </div>     
      </div>
   </div>   

   <div class="main-menu">
      <div class="container">
         <div class="row">
            <div class="col-xs-12 area-main-menu">
               <?php if ($menu_bar = render($page['main_menu'])): print $menu_bar; endif; ?>
               <?php if($page['search']){ ?>
                  <div class="search-region">
                     <?php print render($page['search']); ?>
                  </div>
               <?php } ?>   
            </div>
         </div>
      </div>
   </div>

</header>
