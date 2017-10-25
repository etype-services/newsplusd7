/* add custom js */

(function($){
  Drupal.behaviors.module_etype = {
    attach: function () {
      $(".tb-megamenu-nav > li").has("ul").each(function(i) {
        console.log(i);
      });
    }
  };
})(jQuery);