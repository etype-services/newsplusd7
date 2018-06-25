<?php
?><!DOCTYPE html>
<html lang="<?php print $language->language; ?>" dir="<?php print $language->dir; ?>">
    <head>
    <?php print $head ?>
    <title><?php print $head_title ?></title>
    <?php print $styles ?>
    <?php print $scripts ?>
    </head>
    
    <body class="<?php print $classes; ?> no-banner" <?php print $attributes;?>>

        <!-- #header-top -->
        <header id="header-top" role="banner" class="clearfix">
            <div class="container">

                <!-- #header-top-inside -->
                <div id="header-top-inside" class="clearfix">
                    <div class="row">
                    
                        <div class="col-md-6">
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
                                    
                                </div>
                            </div>
                            <!-- EOF:#header-top-left -->
                        </div>

                        <div class="col-md-6">
                            <!-- #header-top-right -->
                            <div id="header-top-right" class="clearfix">
                                <div class="header-top-area">                    

                                </div>
                            </div>
                            <!-- EOF:#header-top-right -->
                        </div>
                    
                    </div>
                </div>
                <!-- EOF: #header-top-inside -->

            </div>
        </header>
        <!-- EOF: #header-top -->

        <!-- #header -->
        <header id="header">
            <div class="container">
                
                <!-- #header-inside -->
                <div id="header-inside" class="clearfix">
                    <div class="row">
                        <div class="header-area">

                            <div class="col-md-12">
                                <!-- #header-inside-left -->
                                <div id="header-inside-left" class="clearfix">
                                    <!-- #main-navigation -->
                                    <div id="main-navigation" class="clearfix">

                                    </div>
                                    <!-- EOF: #main-navigation -->
                                </div>
                                <!-- EOF:#header-inside-left -->
                            </div>

                        </div>
                    </div>
                </div>
                <!-- EOF: #header-inside -->

            </div>
        </header>
        <!-- EOF: #header -->

        <!-- #banner -->
        <div id="banner" class="clearfix">
              
            <!-- #banner-inside -->
            <div id="banner-inside" class="clearfix">
                <div class="banner-area">

                </div>
            </div>
            <!-- EOF: #banner-inside -->        

        </div>
        <!-- EOF:#banner -->

        <!-- #page -->
        <div id="page" class="clearfix">

            <div class="container">
                
                <!-- #page-inside -->
                <div id="page-inside">

                    <!-- #top-content -->
                    <div id="top-content">

                        <!-- #top-content-inside -->
                        <div id="top-content-inside" class="clearfix">
                            <div class="row">
                                <div class="col-md-12">

                                </div>
                            </div>
                        </div>
                        <!-- EOF:#top-content-inside -->

                    </div>
                    <!-- EOF: #top-content -->

                    <!-- #main-content -->
                    <div id="main-content">

                        <div class="row">

                            <section class="col-md-12">

                                <!-- #banner -->
                                <div id="banner">
                                    <!-- #banner-inside -->
                                    <div id="banner-inside" class="clearfix">

                                    </div>
                                    <!-- EOF:#banner-inside -->
                                </div>
                                <!-- EOF: #banner -->

                                <!-- #promoted -->
                                <div id="promoted" class="clearfix">
                                    <!-- #promoted-inside -->
                                    <div id="promoted-inside" class="clearfix">

                                    </div>
                                    <!-- EOF: #promoted-inside -->
                                </div>
                                <!-- EOF: #promoted -->

                                <!-- #main -->
                                <div id="main" class="clearfix">

                                    <?php print $messages; ?>
                                    <?php if ($title): ?><h1 class="page-title"><?php print $title; ?></h1> <?php endif; ?>
                                    <?php print $content; ?>

                                </div>
                                <!-- EOF:#main -->

                            </section>

                            <aside class="col-md-12">
                                <!--#sidebar-->
                                <section id="sidebar-second" class="sidebar clearfix">

                                </section>
                                <!--EOF:#sidebar-->
                            </aside>
                            
                        </div>

                    </div>
                    <!-- EOF:#main-content -->

                </div>
                <!-- EOF: #page-inside -->

            </div>

        </div>
        <!-- EOF: #page -->

        <!-- #footer -->
        <div id="footer" class="clearfix">
            <div class="container">
                    
                <!-- #footer-inside -->
                <div id="footer-inside" class="clearfix">
                    <div class="row">
                        <div class="col-md-3">
                            <!-- footer-area -->
                                <div class="footer-area">
                                </div>
                            <!-- EOF: footer-area -->
                        </div>
                        <div class="col-md-3">
                            <!-- footer-area -->
                            <div class="footer-area">
                            </div>
                            <!-- EOF: footer-area -->
                        </div>
                        <div class="col-md-3">
                            <!-- footer-area -->
                            <div class="footer-area">
                            </div>
                            <!-- EOF: footer-area -->
                        </div>
                        <div class="col-md-3">
                            <!-- footer-area -->
                            <div class="footer-area">
                            </div>
                            <!-- EOF: footer-area -->
                        </div>                                                        
                    </div>
                </div>
                <!-- #footer-inside -->
        
            </div> 
        </div><!-- EOF:#footer -->

        <div id="subfooter" class="clearfix">
            <div class="container">
                
                <!-- #subfooter-inside -->
                <div id="subfooter-inside" class="clearfix">
                    <div class="row">
                        <div class="col-md-4">
                            <!-- #subfooter-left -->
                            <div class="subfooter-area left">
                            </div>
                            <!-- EOF: #subfooter-left -->
                        </div>
                        <div class="col-md-8">
                            <!-- #subfooter-right -->
                            <div class="subfooter-area right">
                            </div>
                            <!-- EOF: #subfooter-right -->
                        </div>
                    </div>
                </div>
                <!-- EOF: #subfooter-inside -->
            
            </div>
        </div><!-- EOF:#subfooter -->

    </body>
</html>