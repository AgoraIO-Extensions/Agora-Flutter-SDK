// Share the iris web url to all the tests

// This url should be same as the url inside the `example/web/index.html`
const irisWebUrl = 'https://download.agora.io/staging/iris-web-rtc_n423_w4182_0.3.0.js';
const irisWebFakeUrl = 'https://download.agora.io/staging/iris-web-rtc-fake_n423_w4182_0.3.0.js';

(function() {
    var scriptLoaded = false;
    function _appendScript(url) {
      var scriptTag = document.createElement('script');
      scriptTag.src = url;
      scriptTag.type = 'text/javascript';
      scriptTag.async = false;
      document.body.append(scriptTag);
    }
    if (scriptLoaded) {
        return;
    }
    scriptLoaded = true;
  
    _appendScript(irisWebUrl);
    _appendScript(irisWebFakeUrl);
})();