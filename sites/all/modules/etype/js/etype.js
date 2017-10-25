/* add custom js */

(function ($) {
  Drupal.behaviors.module_etype = {
    // this function is to remove the active class from dropdown menus
    attach: function () {
      var pathname = window.location.pathname; // Returns path only
      console.log(pathname);
      // only on Home Page
      if (pathname === "/") {
        //$(".tb-megamenu-nav > li").hasClass("dropdown").removeClass("active");
      }
    }
  };
})(jQuery);