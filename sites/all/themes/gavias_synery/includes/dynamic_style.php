<?php
/**
 * User CSS function. Separate from gavias_preprocess_html so function can be called directly before </head> tag.
 */
function gavias_user_css() {
  if (theme_get_setting('user_css') != '') {
    echo "<!-- User defined CSS -->";
    echo "<style type='text/css'>";
    echo theme_get_setting('user_css');
    echo "</style>";
    echo "<!-- End user defined CSS -->"; 
  }

  if(theme_get_setting('enable_skin_color') == '1' && theme_get_setting('skin_color') != ''){ 
  ?>
      <style type='text/css'>
        .tb-megamenu .nav-collapse ul.nav > li.active > a, a:hover, a:focus,
        .tb-megamenu .nav-collapse ul.nav > li.dropdown.open .active > a,
        .tb-megamenu .nav-collapse ul.nav > li > a:focus, .tb-megamenu .nav-collapse ul.nav > li > a:hover,
        .animating a, .tb-megamenu .nav-collapse ul.nav > li.open > a,
        .tb-megamenu .dropdown-menu a:hover
        {
          color: #<?php echo theme_get_setting('skin_color'); ?>!important;
        }
        .tb-megamenu .nav-collapse ul.nav > li .dropdown-menu,
        .main-menu .region-main-menu
        {
          border-color: #<?php echo theme_get_setting('skin_color'); ?>;
        }
        .block .block-title span, .footer .block .block-title span::after, .tb-megamenu .block .block-title span::after,
        .btn-primary,#comments h3::after, .post-author h3::after
        {
          background: #<?php echo theme_get_setting('skin_color'); ?>;
        }
      </style>
  <?php
  }
}