(function ($) {
    $(document).ready(function() {

        obj = $('#etype_fb_login');

        function updateStatusCallback(response) {
            //console.log(response);
            if (response.status === 'connected') {
                logged_in(response.authResponse.userID);
            } else {
                obj.show().text('Log in to Facebook').click(function() {
                    login();
                });
            }
        }

        function login(){
            FB.login(function(response) {
                console.log(response);
                if (response.status === 'connected') {
                    // proceed
                    obj.html('Log out of Facebook').off('click');
                    obj.click(function() { logout(); });
                    logged_in(response.authResponse.userID);
                } else {
                    // not auth
                    obj.show().text('Unable to login to Facebook.');
                }
            });
        }

        function logout(){
            FB.logout(function(response) {
                location.reload();
            });
        }

        function logged_in(user_id){
            console.log(user_id);
            obj.show().text('Logged in to Facebook.');
            get_pages(user_id);
        }

        function get_pages(user_id) {
            FB.api('/' + user_id + '/accounts?fields=name,access_token,link', function(response) {
                console.log('API response', response);
                var list = document.getElementById('pagesList');
                for (var i=0; i < response.data.length; i++) {
                    var li = document.createElement('li');
                    li.innerHTML = response.data[i].name;
                    li.dataset.token = response.data[i].access_token;
                    li.dataset.link = response.data[i].link;
                    li.className = 'btn btn-mini';
                    li.onclick = function() {
                        document.getElementById('pageName').innerHTML = this.innerHTML;
                        document.getElementById('pageToken').innerHTML = this.dataset.token;
                        document.getElementById('pageLink').setAttribute('href', this.dataset.link);
                    }
                    list.appendChild(li);
                }
            });
        }

        $.ajaxSetup({ cache: true });
        $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
            FB.init({
                appId: etype_app_id,
                version: 'v2.9'
            });
            FB.getLoginStatus(updateStatusCallback);
        });


    });
})(jQuery);