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

                /* on form submission */
                $("#mt-post-node-form").submit(function() {
                    console.log('submitted');
                    /* need a page access token */
                    FB.api(
                        "/" + etype_page_id + "/?fields=access_token",
                        "GET",
                        function (response) {
                            if (response && !response.error) {
                                console.log(response);
                                /* post as page using access token */
                                FB.api(
                                    "/" + etype_page_id + "/feed",
                                    "POST",
                                    {
                                        access_token: response.access_token,
                                        message     : "It's awesome ...",
                                        link        : 'http://csslight.com',
                                        picture     : 'http://csslight.com/application/upload/WebsitePhoto/567-grafmiville.png',
                                        name        : 'Featured of the Day',
                                        from        :  etype_page_id,
                                        description : 'CSS Light is a showcase for web design encouragement, submitted by web designers of all over the world. We simply accept the websites with high quality and professional touch.'
                                    },
                                    function (response) {
                                        if (response && !response.error) {
                                            console.log(response);
                                            /* handle the result */

                                        }
                                    }
                                );
                            } else {
                                console.log(response);
                            }
                        }
                    );
                    event.preventDefault();
                })
            }
        })

    });
})(jQuery);