/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $("#header-top > ul.sf-menu").each(function(i, obj) {
        console.log(obj);
      });
    }
  };
})(jQuery);