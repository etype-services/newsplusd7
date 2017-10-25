/* add custom js */

(function($){
  Drupal.behaviors.module_etype = {
    attach: function () {
      $(".tb-megamenu-nav > li").hasClass("dropdown-toggle").each(function (i) {
        console.log(i);
      });
    }
  };
})(jQuery);