// Share the iris web url to all the tests

// This url should be same as the url inside the `example/web/index.html`
const irisWebUrl = 'https://github.com/AgoraIO-Extensions/iris_web/releases/download/v0.8.0-pre/iris-web-rtc_n440_w4220_0.8.0-pre.js';
const irisWebFakeUrl = 'https://github.com/AgoraIO-Extensions/iris_web/releases/download/v0.8.0-pre/iris-web-rtc-fake_n440_w4220_0.8.0-pre.js';

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