'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "48409c4af21d6a8dd89966ff084f645f",
"version.json": "719491c0973ca30b0eb15cc621c5cf8f",
"splash/img/light-2x.png": "b6e651e169d8f9ddd4edc4307a666f89",
"splash/img/branding-4x.png": "4c88385b264d3327b0beacd5b94354f7",
"splash/img/dark-4x.png": "443a7aa95781e35c1420efe174abff9c",
"splash/img/branding-dark-1x.png": "81960d07f0d86ca0383c4f191f6d6c68",
"splash/img/light-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/dark-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/light-4x.png": "443a7aa95781e35c1420efe174abff9c",
"splash/img/branding-2x.png": "d126d11c8662fed693d72032b7dae69f",
"splash/img/branding-3x.png": "f24ab21453ba6f61e3a4f79e4c46cea7",
"splash/img/dark-2x.png": "b6e651e169d8f9ddd4edc4307a666f89",
"splash/img/dark-1x.png": "1e43f2570c02aa7aabc7b59895558d52",
"splash/img/branding-dark-4x.png": "4c88385b264d3327b0beacd5b94354f7",
"splash/img/branding-1x.png": "81960d07f0d86ca0383c4f191f6d6c68",
"splash/img/branding-dark-2x.png": "d126d11c8662fed693d72032b7dae69f",
"splash/img/light-1x.png": "1e43f2570c02aa7aabc7b59895558d52",
"splash/img/branding-dark-3x.png": "f24ab21453ba6f61e3a4f79e4c46cea7",
"index.html": "fe6a3a718635d49243996a0491a038bb",
"/": "fe6a3a718635d49243996a0491a038bb",
"main.dart.js": "4e0d88f119cd644acf496b7dbc4ab0fe",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "b15c0ae7ec13f83ef34c59aac39b7379",
"icons/Icon-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"icons/Icon-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"manifest.json": "ad4382855ae9c70ef31cd81257ccd17f",
"assets/AssetManifest.json": "f968ed43536123fb421685fa097e7a61",
"assets/NOTICES": "47a1dafeba16804b36a6fd16eeeb83c2",
"assets/FontManifest.json": "db8f453ee5bd623ef9ffbe9d7a009cf7",
"assets/AssetManifest.bin.json": "df48ea40e5f474a89fb1a7174557058e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "d7bb4127c1e0ff5f51643b9894738578",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "2cd6498dac4889dabdc60c37b3ba11ec",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "1c12f0d3b117cb5eb965fd678a06bdcd",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "13cb9880835a2703ce2ff896a388bb23",
"assets/fonts/MaterialIcons-Regular.otf": "9d687f58d033252b7e1b241f9041bee7",
"assets/assets/svg/sale_icon.svg": "5f36d22946d707adee021d823367543f",
"assets/assets/svg/search_icon.svg": "d338e04e137d6465f75ea3c8c81257a0",
"assets/assets/svg/home_icon.svg": "36f5a7f3e880d4965d6bf01489a5717b",
"assets/assets/svg/list_cards.svg": "0a0bcf57ef565c92724a3883076adb14",
"assets/assets/svg/trading_icon.svg": "cf65b77a325498927dc5412cf9c60c61",
"assets/assets/svg/deck_icon.svg": "369629a30d8ca38499f7a0f320a62919",
"assets/assets/svg/card_fight.svg": "89d974d69bf01166fa08d1acce802438",
"assets/assets/svg/pokeball_b&w.svg": "5607fcbf5d9e8735e49ab78702420ff8",
"assets/assets/svg/cards.svg": "8fa4aa1e785d58e85e5f8d91c98cbef7",
"assets/assets/images/types_badge/eletric.png": "739fbd7518bf5e5bf62ca63e30ad46ae",
"assets/assets/images/types_badge/dark.png": "ba1929ebf09a7190a261a7727c160db7",
"assets/assets/images/types_badge/fire.png": "ead2c8827a816fe664f04d7687b14c8b",
"assets/assets/images/types_badge/dragon.png": "512c23d8899d2d129f429226decbce4c",
"assets/assets/images/types_badge/fairy.png": "439dded05dddc1734f988e465f95a42d",
"assets/assets/images/types_badge/grass.png": "3a46c2d6a73c53bd9aa293ca239635f0",
"assets/assets/images/types_badge/water.png": "604730b529040df42d278ea20ab8fbc6",
"assets/assets/images/types_badge/normal.png": "ff5bed5bf20ca33a8de8453ccb9b5170",
"assets/assets/images/types_badge/psychic.png": "58b355a7f71ec9438891fc258e73538d",
"assets/assets/images/types_badge/fighting.png": "d1c2231540bfbeb1b44ef35103faf56d",
"assets/assets/images/types_badge/steel.png": "cd94a5ca560c762456fe5cdda9d4e973",
"assets/assets/images/arrow-right.png": "14d99c1517ca89551e6805c1c9c42ae1",
"assets/assets/images/logo_text.png": "b1f57dd6bab13a53023d3ef0e6f53789",
"assets/assets/images/icon-pokeball.png": "14d96b1d552ac1dd296a0d43664c269b",
"assets/assets/images/card-back.png": "384c3ecdf1ee190668b281e942a10cf6",
"assets/assets/images/pokeball.png": "5a1f67e65b8f1b1fc16c7f8c5c748a23",
"assets/assets/images/logo.png": "fcca65c8c5d01de52d2e170013fcee6c",
"assets/assets/images/logo2.png": "a9120794c1c3b60b13cc89282fd633ca",
"assets/assets/images/pokeballs.png": "f770de23df90644be640456e5c63118f",
"assets/assets/images/tabs_icons/trading.png": "777a0faa898135a5386311165b40c560",
"assets/assets/images/tabs_icons/search.png": "4780234936a96db072dfa8482c78dfbc",
"assets/assets/images/splash_bg.png": "e39f838109c236e032304dad1ed28e9d",
"assets/assets/icon/icon_launcher.png": "30b85e4581d2f8010e7ba14f34605128",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
