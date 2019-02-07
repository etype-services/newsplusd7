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

            $(".views-field-field-mt-banner-image .field-content img").each(function() {
                var val = $("this").attr("title");
                console.log($("this"));
                $(".views-field-field-mt-banner-image .field-content").append(val);
            });
        }
    };

})(jQuery);

