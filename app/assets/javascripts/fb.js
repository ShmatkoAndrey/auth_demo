function FBlogin() {
    FB.init({
        appId      : '1997533793805209',
        version    : 'v2.5' // use version 2.2
    });

    FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {
            login();
        }
        else {
            FB.login(function() {
                login();
            }, {scope: 'public_profile,email'});
        }
    });
}

function login() {
    FB.api('/me', {fields: 'email,name,first_name,last_name,birthday,age_range,bio,gender,picture,link,locale'}, function(response) {
        console.log(response);
        $.ajax({
            type: 'POST',
            url: '../sessions/social_auth',
            dataType : 'html',
            data: {social: response, provider: 'facebook'},
            success: function(response) {
                document.write(response);
            }
        });
    });
}

(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/all.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk')); // Load the SDK asynchronously