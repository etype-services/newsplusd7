(function ($) {
    $(document).ready(function() {

        var fbobj = $("#edit-fb-autopost");
        fbobj.change(function() {
            var check = fbobj.is(':checked');
            console.log(check);

            if (check === true) {
                // init
                $.ajaxSetup({ cache: true });
                $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
                    FB.init({
                        appId: etype_app_id, // var set in .module
                        version: 'v2.9'
                    });
                    FB.getLoginStatus(updateStatusCallback);
                });

                function updateStatusCallback(response) {
                    console.log(response);
                    if (response.status === 'connected') {
                        // logged_in(response.authResponse.userID);
                    } else {
                        login();
                    }
                }

                function login(){
                    FB.login(function(response) {
                        // console.log(response);
                        if (response.status === 'connected') {
                            // proceed
                            // logged_in(response.authResponse.userID);
                        } else {
                            // not authorized
                            console.log('Unable to login to Facebook');
                        }
                    }, {scope: 'publish_actions'});
                }
                
            }
        })

    });
})(jQuery);