/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $("li").each(function(i, obj) {
        console.log(obj);
      });
    }
  };
})(jQuery);