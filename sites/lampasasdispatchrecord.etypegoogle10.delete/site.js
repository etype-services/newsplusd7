(function ($) {
    Drupal.behaviors.lampasas = {
        attach: function () {
            $("#search-block-form .form-submit").after('<i class="fa fa-search"></i>');
        }
    };
})(jQuery);