/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.FontFixer = {
    attach: function(context, settings){
      $("#superfish-1").find("a.menuparent").each(function(i, obj) {
        $(this).append('&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i>');
      });
      $(".block-search .form-actions, .block-search .trigger").append('<i' +
          ' class="fa fa-search"' +
          ' aria-hidden="true"></i>');
      $(".more-link a").append('<i class="fa fa-chevron-right" aria-hidden="true"></i>');
    }
  };
})(jQuery);