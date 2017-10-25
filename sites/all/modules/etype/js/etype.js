/* add custom js */

(function ($) {
  Drupal.behaviors.module_etype = {
    attach: function () {
      var pathname = window.location.pathname; // Returns path only
      console.log(pathname);
      $(".tb-megamenu-nav > li").each(function (i) {
        console.log(i);
      });
    }
  };
})(jQuery);