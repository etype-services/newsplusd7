/* extra theme js */

(function($) {
  'use strict';
  Drupal.behaviors.MenuFixer = {
    attach: function(context, settings){
      $('#header-top ul.sf-menu li').each(function(i, obj) {
        alert(obj);
      });
    }
  };
})(jQuery);