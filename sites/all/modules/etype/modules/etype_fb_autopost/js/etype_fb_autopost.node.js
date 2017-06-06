(function ($) {
    $(document).ready(function() {

        var fbobj = $("#edit-fb-autopost");
        fbobj.change(function() {

            console.log(fbobj.is(':checked'));
        })

    });
})(jQuery);