/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $('#header-top ul.sf-menu li a.menuparent').each(function(i, obj) {
        console.log(i);
      });
    }
  };
})(jQuery);