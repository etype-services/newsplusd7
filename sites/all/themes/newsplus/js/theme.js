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

            /* internal banner captions */
            $(".views-field-field-mt-banner-image .field-content img").each(function(idx,img) {
                var pTitle = img.title;
                $(this).parent().append("<div class=\"banner-caption\"><div class=\"caption-title\">" + pTitle + "</div></div>");
            });
        }
    };

})(jQuery);

