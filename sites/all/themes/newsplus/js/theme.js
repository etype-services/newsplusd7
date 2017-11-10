/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $("#superfish-1").find(".menuparent").each(function(i, obj) {
        console.log(obj);
      });
    }
  };
})(jQuery);