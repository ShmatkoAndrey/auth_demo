function statusChangeCallback(response) {
    if (response.status === 'connected') {
        testAPI();
    } else if (response.status === 'not_authorized') { // The person is logged into Facebook, but not your app.
        console.log('Please log into this app.');
    } else {
        console.log('Please log into Facebook.'); // The person is not logged into Facebook, so we're not sure if they are logged into this app or not.
    }
}

function checkLoginState() {
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
}

window.fbAsyncInit = function() {
    FB.init({
        appId      : '1997533793805209',
        cookie     : true,  // enable cookies to allow the server to access the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v2.2' // use version 2.2
    });

    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
};

(function(d, s, id) { // Load the SDK asynchronously
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function testAPI() {
    console.log('Welcome!  Fetching your information.... ');

    FB.api('/me', {fields: 'email,name,birthday,gender,picture'}, function(response) {
        console.log(response);
    });
}