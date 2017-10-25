/* add custom js */

(function ($) {
  Drupal.behaviors.module_etype = {
    // this function is to remove the active class from the main item of
    // a dropdown menu in the Synery Template
    // So that that item can be given a path of / but not be active on the
    // home page. You cannot have an empty path in the Drupal menu system
    attach: function () {
      var pathname = window.location.pathname; // Returns path only
      // only on Home Page
      if (pathname === "/") {
        $(".tb-megamenu-nav > li").each(function(i) {
          if ($(this).hasClass("dropdown")) {
            $(this).removeClass("active");
          }
        });
      }
    }
  };
})(jQuery);