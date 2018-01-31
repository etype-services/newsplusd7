(function ($) {
    Drupal.behaviors.lampasas = {
        attach: function () {
            $("#search-block-form .form-submit").append('<i class="fa fa-search"></i>');
        }
    };
})(jQuery);