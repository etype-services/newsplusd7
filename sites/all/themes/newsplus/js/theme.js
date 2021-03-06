/* extra theme js */

(function ($) {
  'use strict';
  Drupal.behaviors.ThemeFixer = {
    attach: function (context, settings) {

      /* Add fontawesome icons */
      $("#superfish-1").find("a.menuparent").each(function (i, obj) {
        $(this).append('&nbsp;<i class="fas fa-caret-down"></i>');
      });
      $(".block-search .form-actions, .block-search .trigger").append('<i class="fas fa-search"></i>');
      $(".more-link a").append('<i class="fas fa-chevron-right"></i>');
      $(".jcarousel-prev-horizontal").append('<i class="fas fa-arrow-left"></i>');
      $(".jcarousel-next-horizontal").append('<i class="fas fa-arrow-right"></i>');

      /* Fix search */
      $("#search-block-form .form-actions").click(function () {
        $("#search-block-form").submit();
      });

      /* Internal banner captions */
      $(".views-field-field-mt-banner-image .field-content img").each(function (idx, img) {
        var caption = img.alt || img.title;
        $(this).parent().append("<div class=\"banner-caption\"><div class=\"caption-title\">" + caption + "</div></div>");
      });

      /* External links (module does not open links in new tab/window */
      $("a.ext").prop("target", "_blank");
    }
  };

})(jQuery);

