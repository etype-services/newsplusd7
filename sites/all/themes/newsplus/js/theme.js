/* extra theme js */

(function ($) {
    'use strict';
    Drupal.behaviors.FontFixer = {
        attach: function (context, settings) {
            $("#superfish-1").find("a.menuparent").each(function (i, obj) {
                $(this).append('&nbsp;<i class="fas fa-caret-down"></i>');
            });
            $(".block-search .form-actions, .block-search .trigger").append('<i' +
                ' class="fas fa-search"' +
                ' aria-hidden="true"></i>');
            $(".more-link a").append('<i class="fas fa-chevron-right"></i>');
            $(".jcarousel-prev-horizontal").append('<i class="fas fa-arrow-left"></i>');
            $(".jcarousel-next-horizontal").append('<i class="fas fa-arrow-right"></i>');

            /* fix search */
            $("#search-block-form .form-actions").click(function(){
                $("#search-block-form").submit();
            });
        }
    };

    Drupal.behaviors.InternalBanner = {
        attach: function (context, settings) {
            $("#internal-banner-slider").fadeIn("slow");
            $("#internal-slider-carousel").fadeIn("slow");

            // The slider being synced must be initialized first
            $("#internal-slider-carousel").flexslider({
                animation: "slide",
                controlNav: true,
                animationLoop: false,
                slideshow: false,
                itemWidth: 166,
                itemMargin: 4.8,
                directionNav: false,
                asNavFor: "#internal-banner-slider"
            });

            $("#internal-banner-slider").flexslider({
                useCSS: true,
                animation: "'.$internal_banner_effect.'",
                controlNav: false,
                keyboard: true,
                directionNav: true,
                animationLoop: false,
                slideshow: false,
                sync: "#internal-slider-carousel"
            });
        }
    };

})(jQuery);

