<?php if (theme_get_setting('scrolltop_display')): ?>
<div id="toTop"><i class="fa fa-play-circle fa-rotate-270"></i></div>
<?php endif; ?>

<?php if ($page['pre_header_left'] || $page['pre_header_right']):?>
<!-- #pre-header -->
<div id="pre-header" class="clearfix">
    <div class="container">

        <!-- #pre-header-inside -->
        <div id="pre-header-inside" class="clearfix">
            <div class="row">
                
                <?php if ($page['pre_header_left']) :?>
                <div class="<?php print $pre_header_left_grid_class; ?>">
                    <!-- #pre-header-left -->
                    <div id="pre-header-left" class="clearfix">
                        <div class="pre-header-area">
                            <?php print render($page['pre_header_left']); ?>
                        </div>
                    </div>
                    <!-- EOF:#pre-header-left -->
                </div>
                <?php endif; ?>
            
            
                <?php if ($page['pre_header_right']) :?>
                <div class="<?php print $pre_header_right_grid_class; ?>">
                    <!-- #pre-header-right -->
                    <div id="pre-header-right" class="clearfix">
                        <div class="pre-header-area">                    
                            <?php print render($page['pre_header_right']); ?>
                        </div>
                    </div>
                    <!-- EOF:#pre-header-right -->
                </div>
                <?php endif; ?>
            
            </div>
        </div>
        <!-- EOF: #pre-header-inside -->

    </div>
</div>
<!-- EOF: #pre-header -->
<?php endif; ?>

<!-- #header-top -->
<header id="header-top" role="banner" class="clearfix">
    <div class="container">

        <!-- #header-top-inside -->
        <div id="header-top-inside" class="clearfix">
            <div class="row">
            
                <div class="<?php print $header_top_inside_left_grid_class; ?>">
                    <!-- #header-top-left -->
                    <div id="header-top-left" class="clearfix">
                        <div class="header-top-area">

                            <div id="logo-and-site-name-wrapper" class="clearfix">
                                <?php if ($logo):?>
                                <div id="logo">
                                <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>" rel="home"> <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" /> </a>
                                </div>
                                <?php endif; ?>
                                
                                <?php if ($site_name):?>
                                <div id="site-name">
                                <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>"><?php print $site_name; ?></a>
                                </div>
                                <?php endif; ?>
                                
                                <?php if ($site_slogan):?>
                                <div id="site-slogan">
                                <?php print $site_slogan; ?>
                                </div>
                                <?php endif; ?>
                            </div>
                            
                            <?php if ($page['header_top_left']) :?>
                            <?php print render($page['header_top_left']); ?>
                            <?php endif; ?>

                        </div>
                    </div>
                    <!-- EOF:#header-top-left -->
                </div>
            
            
                <?php if ($page['header_top_right']) :?>
                <div class="col-md-6">
                    <!-- #header-top-right -->
                    <div id="header-top-right" class="clearfix">
                        <div class="header-top-area">                    
                            <?php print render($page['header_top_right']); ?>
                        </div>
                    </div>
                    <!-- EOF:#header-top-right -->
                </div>
                <?php endif; ?>
            
            </div>
        </div>
        <!-- EOF: #header-top-inside -->

    </div>
</header>
<!-- EOF: #header-top -->

<!-- #header -->
<header id="header">
    
    <?php if ($site_name):?>
    <div id="navigation-site-name">
    <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>"><?php print $site_name; ?></a>
    </div>
    <?php endif; ?>

    <div class="container">
        
        <!-- #header-inside -->
        <div id="header-inside" class="clearfix">
            <div class="row">
                <div class="header-area">

                    <div class="<?php print $header_inside_left_grid_class; ?>">
                        <!-- #header-inside-left -->
                        <div id="header-inside-left" class="clearfix">
                            <!-- #main-navigation -->
                            <div id="main-navigation" class="clearfix">
                                <nav role="navigation"> 
                                    <?php if ($page['navigation']) :?>
                                    <?php print render($page['navigation']); ?>
                                    <?php else : ?>
                                    <div id="main-menu">
                                    <?php print theme('links__system_main_menu', array('links' => $main_menu, 'attributes' => array('class' => array('main-menu', 'menu'), ), 'heading' => array('text' => t('Main menu'), 'level' => 'h2', 'class' => array('element-invisible'), ), )); ?>
                                    </div>
                                    <?php endif; ?>
                                </nav>
                            </div>
                            <!-- EOF: #main-navigation -->
                        </div>
                        <!-- EOF:#header-inside-left -->
                    </div>

                    <?php if ($page['header']) :?>                
                    <div class="col-md-4">
                        <!-- #header-inside-right -->
                        <div id="header-inside-right" class="clearfix">
                        <?php print render($page['header']); ?>
                        </div>
                        <!-- EOF:#header-inside-right -->                        
                    </div>
                    <?php endif; ?>
                    
                </div>
            </div>
        </div>
        <!-- EOF: #header-inside -->

    </div>
</header>
<!-- EOF: #header -->

<?php if ($page['page_intro']) :?> 
<!-- #page-intro -->
<div id="page-intro" class="clearfix">
    
    <div class="container">
        <div class="row">
            
            <!-- #page-intro-inside -->
            <div id="page-intro-inside" class="clearfix">
                <?php print render($page['page_intro']); ?>
            </div>
            <!-- EOF: #page-intro-inside -->

        </div>
    </div>

</div>
<!-- EOF: #page-intro -->
<?php endif; ?>

<!-- #page -->
<div id="page" class="clearfix">

    <div class="container">
        
        <!-- #page-inside -->
        <div id="page-inside">

            <!-- #messages-console -->
            <?php if ($messages):?>
            <div id="messages-console" class="clearfix">

                <div class="row">
                    <div class="col-md-12">
                    <?php print $messages; ?>
                    </div>
                </div>

            </div>
            <?php endif; ?>
            <!-- EOF: #messages-console -->

            <?php if ($page['top_content']):?>
            <!-- #top-content -->
            <div id="top-content">

                <!-- #top-content-inside -->
                <div id="top-content-inside" class="clearfix">
                    <div class="row">
                        <div class="col-md-12">
                        <?php print render($page['top_content']); ?>
                        </div>
                    </div>
                </div>
                <!-- EOF:#top-content-inside -->

            </div>
            <!-- EOF: #top-content -->
            <?php endif; ?>

            <!-- #main-content -->
            <div id="main-content">

                <div class="row">

                    <?php if ($page['sidebar_first']):?>
                    <aside class="<?php print $sidebar_first_grid_class; ?>">
                        <!--#sidebar-->
                        <section id="sidebar-first" class="sidebar clearfix">
                        <?php print render($page['sidebar_first']); ?>
                        </section>
                        <!--EOF:#sidebar-->
                    </aside>
                    <?php endif; ?>

                    <section class="<?php print $main_grid_class; ?>">

                        <?php if ($breadcrumb && theme_get_setting('breadcrumb_display')):?> 
                        <!-- #breadcrumb -->
                        <div id="breadcrumb" class="clearfix">
                            <!-- #breadcrumb-inside -->
                            <div id="breadcrumb-inside" class="clearfix">
                            <?php print $breadcrumb; ?>
                            </div>
                            <!-- EOF: #breadcrumb-inside -->
                        </div>
                        <!-- EOF: #breadcrumb -->
                        <?php endif; ?>

                        <?php if ($page['banner']):?>
                        <!-- #banner -->
                        <div id="banner">
                            <!-- #banner-inside -->
                            <div id="banner-inside" class="clearfix">
                                <?php print render($page['banner']); ?>
                            </div>
                            <!-- EOF:#banner-inside -->
                        </div>
                        <!-- EOF: #banner -->
                        <?php endif; ?>

                        <?php if ($page['highlighted']):?>
                        <!-- #highlighted -->
                        <div id="highlighted">
                            <!-- #highlighted-inside -->
                            <div id="highlighted-inside" class="clearfix">
                                <?php print render($page['highlighted']); ?>
                            </div>
                            <!-- EOF:#highlighted-inside -->
                        </div>
                        <!-- EOF: #highlighted -->
                        <?php endif; ?>

                        <?php if ($page['promoted']):?>
                        <!-- #promoted -->
                        <div id="promoted" class="clearfix">
                            <!-- #promoted-inside -->
                            <div id="promoted-inside" class="clearfix">
                            <?php print render($page['promoted']); ?>
                            </div>
                            <!-- EOF: #promoted-inside -->
                        </div>
                        <!-- EOF: #promoted -->
                        <?php endif; ?>

                        <!-- #main -->
                        <div id="main" class="clearfix">

                            <?php print render($title_prefix); ?>
                            <?php if ($title): ?><h1 class="title" id="page-title"><?php print $title; ?></h1><?php endif; ?>
                            <?php print render($title_suffix); ?>

                            <!-- #tabs -->
                            <?php if ($tabs):?>
                                <div class="tabs">
                                <?php print render($tabs); ?>
                                </div>
                            <?php endif; ?>
                            <!-- EOF: #tabs -->

                            <?php print render($page['help']); ?>

                            <!-- #action links -->
                            <?php if ($action_links):?>
                                <ul class="action-links">
                                <?php print render($action_links); ?>
                                </ul>
                            <?php endif; ?>
                            <!-- EOF: #action links -->

                            <?php if (theme_get_setting('frontpage_content_print') || !drupal_is_front_page()):?> 
                            <?php print render($page['content']); ?>
                            <?php print $feed_icons; ?>
                            <?php endif; ?>

                        </div>
                        <!-- EOF:#main -->

                    </section>

                    <?php if ($page['sidebar_second']):?>
                    <aside class="<?php print $sidebar_second_grid_class; ?>">
                        <!--#sidebar-->
                        <section id="sidebar-second" class="sidebar clearfix">
                        <?php print render($page['sidebar_second']); ?>
                        </section>
                        <!--EOF:#sidebar-->
                    </aside>
                    <?php endif; ?>
                    
                </div>

            </div>
            <!-- EOF:#main-content -->

        </div>
        <!-- EOF: #page-inside -->

    </div>

</div>
<!-- EOF: #page -->

<?php if ($page['footer_first'] || $page['footer_second'] || $page['footer_third'] || $page['footer_fourth']):?>
<!-- #footer -->
<footer id="footer" class="clearfix">
    <div class="container">

        <div class="row">
            <?php if ($page['footer_first']):?>
            <div class="<?php print $footer_grid_class; ?>">
                <div class="footer-area">
                <?php print render($page['footer_first']); ?>
                </div>
            </div>
            <?php endif; ?>      

            <?php if ($page['footer_second']):?>      
            <div class="<?php print $footer_grid_class; ?>">
                <div class="footer-area">
                <?php print render($page['footer_second']); ?>
                </div>
            </div>
            <?php endif; ?>

            <?php if ($page['footer_third']):?>
            <div class="<?php print $footer_grid_class; ?>">
                <div class="footer-area">
                <?php print render($page['footer_third']); ?>
                </div>
            </div>
            <?php endif; ?>

            <?php if ($page['footer_fourth']):?>
            <div class="<?php print $footer_grid_class; ?>">
                <div class="footer-area">
                <?php print render($page['footer_fourth']); ?>
                </div>
            </div>
            <?php endif; ?>
        </div>

    </div>
</footer> 
<!-- EOF #footer -->
<?php endif; ?>

<?php if ($page['sub_footer_left'] || $page['footer']):?>
<div id="subfooter" class="clearfix">
	<div class="container">
		
		<!-- #subfooter-inside -->
		<div id="subfooter-inside" class="clearfix">
            <div class="row">
    			<div class="col-md-4">
                    <!-- #subfooter-left -->
                    <?php if ($page['sub_footer_left']):?>
                    <div class="subfooter-area left">
                    <?php print render($page['sub_footer_left']); ?>
                    </div>
                    <?php endif; ?>
                    <!-- EOF: #subfooter-left -->
    			</div>
    			<div class="col-md-8">
                    <!-- #subfooter-right -->
                    <?php if ($page['footer']):?>
                    <div class="subfooter-area right">
                    <?php print render($page['footer']); ?>
                    </div>
                    <?php endif; ?>
                    <!-- EOF: #subfooter-right -->
    			</div>
            </div>
		</div>
		<!-- EOF: #subfooter-inside -->
	
	</div>
</div><!-- EOF:#subfooter -->
<?php endif; ?>