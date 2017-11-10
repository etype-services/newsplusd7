/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $("#superfish-1").find("a.menuparent").each(function(i, obj) {
        $(this).append('&nbsp;<i class="fa fa-caret-down"></i>');
      });
    }
  };
})(jQuery);