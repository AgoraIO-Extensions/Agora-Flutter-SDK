// Share the iris web url to all the tests

// This url should be same as the url inside the `example/web/index.html`
const irisWebUrl = 'https://download.agora.io/staging/iris-web-rtc_0.1.2-dev.1.js';
const irisWebFakeUrl = 'https://download.agora.io/staging/iris-web-rtc-fake_0.1.2-dev.1.js';

var scriptLoaded = false;
async function loadIrisWeb() {
  async function _appendScript(url) {
    return new Promise((resolve, reject) => {
      var scriptTag = document.createElement('script');
      scriptTag.src = url;
      scriptTag.type = 'text/javascript';
      scriptTag.onload = function () {
        console.log(`load 1111: ${url}`);
        resolve();
      };
      document.body.append(scriptTag);

      
    });
  }

  if (scriptLoaded) {
    return;
  }
  scriptLoaded = true;

  console.log('dddddddddddd');

  await _appendScript(irisWebUrl);
  await _appendScript(irisWebFakeUrl);
}

// window.addEventListener('load', function(ev) {
//     loadIrisWeb();
// });

await loadIrisWeb();