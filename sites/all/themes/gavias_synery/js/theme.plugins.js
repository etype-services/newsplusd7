(function ($) {
   "use strict";


function ConfigOWL(options){
    var total = $("div.owl-carousel:not(.manual)").length,
   count = 0;

   $("div.owl-carousel:not(.manual), .field-name-field-post-gallery .field-items, .field-name-field-gallery-images .field-items").each(function() {

      var slider = $(this);

      var defaults = {
          // Most important owl features
         items : 1,
         itemsDesktop : [1199,4],
         itemsDesktopSmall : [980,3],
         itemsTablet: [768,2],
         itemsTabletSmall: false,
         itemsMobile : [479,1],
         singleItem : true,
         itemsScaleUp : false,
         
         //Autoplay
         autoPlay : true,
         stopOnHover : false,

         //Pagination
         pagination : true,
         paginationNumbers: false,

         //Auto height
         autoHeight : true,
      }

      var config = $.extend({}, defaults, options, slider.data("plugin-options"));

      // Initialize Slider
      slider.imagesLoaded(function(){
         slider.owlCarousel(config).addClass("owl-carousel-init");
      })
   });

}   
jQuery(document).ready(function () {

   var Plugins = {

      initialized: false,

      initialize: function() {
         if (this.initialized) return;
         this.initialized = true;
         this.build();
      },

      build: function() {

         // Owl Carousel
         this.owlCarousel();
      },

      owlCarousel: function(options) {
         ConfigOWL(options);
      },
   };

   Plugins.initialize();

   $( '.gallery-grid .view-list' ).gridrotator( {
      rows : 1,
      // number of columns 
      columns : 10,
      w1024 : { rows : 2, columns : 6 },
      w768 : {rows : 2, columns : 5 },
      w480 : {rows : 2, columns : 4 },
      w320 : {rows : 3, columns : 3 },
      w240 : {rows : 3, columns : 2 },
   } );
});

})(jQuery);   