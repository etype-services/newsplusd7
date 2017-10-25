/* add custom js */

(function ($) {
  Drupal.behaviors.module_etype = {
    // this function is to remove the active class from dropdown menus
    attach: function () {
      var pathname = window.location.pathname; // Returns path only
      // only on Home Page
      if (pathname === "/") {
        obj = $(".tb-megamenu-nav > li");
        console.log(obj);
      }
    }
  };
})(jQuery);