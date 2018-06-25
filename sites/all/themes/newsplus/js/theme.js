/* extra theme js */

(function ($) {
    'use strict';
    Drupal.behaviors.FontFixer = {
        attach: function (context, settings) {
            $("#superfish-1").find("a.menuparent").each(function (i, obj) {
                $(this).append('&nbsp;<i class="fas fa-caret-down" aria-hidden="true"></i>');
            });
            $(".block-search .form-actions, .block-search .trigger").append('<i' +
                ' class="fas fa-search"' +
                ' aria-hidden="true"></i>');
            $(".more-link a").append('<i class="fas fa-chevron-right" aria-hidden="true"></i>');
            $(".jcarousel-prev-horizontal").append('<i class="fas fa-arrow-left" aria-hidden="true"></i>');
            $(".jcarousel-next-horizontal").append('<i class="fas fa-arrow-right" aria-hidden="true"></i>');
        }
    };

})(jQuery);

