(function ($) {
    $(document).ready(function() {

        obj = $('#etype_fb_login');

        function updateStatusCallback(response) {
            //console.log(response);
            if (response.status === 'connected') {
                logged_in(response.authResponse.userID);
            } else {
                obj.show().text('Log in to Facebook to set Facebook Page Id').click(function() {
                    login();
                });
            }
        }

        function login(){
            FB.login(function(response) {
                // console.log(response);
                if (response.status === 'connected') {
                    // proceed
                    logged_in(response.authResponse.userID);
                } else {
                    // not auth
                    obj.show().text('Unable to login to Facebook');
                }
            });
        }

        function logout(){
            FB.logout(function(response) {
                location.reload();
            });
        }

        function logged_in(user_id){
            // console.log(user_id);
            obj.off('click').click(function() { logout(); });
            obj.show().text('Log out of Facebook');
            get_pages(user_id);
        }

        function get_pages(user_id) {
            FB.api('/' + user_id + '/accounts?fields=name,access_token,link', function(response) {
                // console.log('API response', response);
                console.log(response.data.length);
                var form_item = $(".form-item-etype-facebook-page-id");
                form_item.show();
                var select = $("#edit-etype-facebook-page-id");
                $.each(response.data, function(i) {
                    // console.log(i);
                    // console.log(response.data[i]);
                    select.append($('<option>', { value : response.data[i].id })
                            .text(response.data[i].name));
                });
                select.val(etype_page_id); // set selected, var set in .module
            });
        }

        // init
        $.ajaxSetup({ cache: true });
        $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
            FB.init({
                appId: etype_app_id, // var set in .module
                version: 'v2.9'
            });
            FB.getLoginStatus(updateStatusCallback);
        });


    });
})(jQuery);