/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $("#superfish-1").find("a.menuparent").each(function(i, obj) {
        $(this).append('&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i>');
      });
    }
  };
  Drupal.behaviors.SearchFixer = {
    attach: function (context, settings) {
      $(".block-search .form-actions").append('<i class="fa fa-search"' +
          ' aria-hidden="true"></i>');
    }
  };
})(jQuery);