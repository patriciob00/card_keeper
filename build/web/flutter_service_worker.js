'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "c0762c47594693c686eb04cc2d537699",
"version.json": "687554e0dbcf07eba2f427eda62843e4",
"splash/img/light-2x.png": "c651a6b12b36152eeab6345d60711b6a",
"splash/img/branding-4x.png": "78a71d32801a2295b909d35c030eb6b7",
"splash/img/dark-4x.png": "a947a53de8ceb7e9c7b0875f536e5cae",
"splash/img/branding-dark-1x.png": "c21c1a7995dc7c6c3d8710c6fe58d16e",
"splash/img/light-3x.png": "fc9c44beef1bcce10ede14fefdff25f7",
"splash/img/dark-3x.png": "fc9c44beef1bcce10ede14fefdff25f7",
"splash/img/light-4x.png": "a947a53de8ceb7e9c7b0875f536e5cae",
"splash/img/branding-2x.png": "b893f4e012b4cfadba0554b448ed63af",
"splash/img/branding-3x.png": "6c468216ab67074c50198db6f012f4af",
"splash/img/dark-2x.png": "c651a6b12b36152eeab6345d60711b6a",
"splash/img/dark-1x.png": "0d63062b736f859063a320fc7794ae51",
"splash/img/branding-dark-4x.png": "78a71d32801a2295b909d35c030eb6b7",
"splash/img/branding-1x.png": "c21c1a7995dc7c6c3d8710c6fe58d16e",
"splash/img/branding-dark-2x.png": "b893f4e012b4cfadba0554b448ed63af",
"splash/img/light-1x.png": "0d63062b736f859063a320fc7794ae51",
"splash/img/branding-dark-3x.png": "6c468216ab67074c50198db6f012f4af",
"index.html": "41ae9c053f961f3c478a1c14703e3f8f",
"/": "41ae9c053f961f3c478a1c14703e3f8f",
"main.dart.js": "6aaff3306a6ab30e1993a907a0d71934",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "6667b7982a946969d0d1e94084a29f77",
"icons/Icon-192.png": "328eb761a4ebde662c2df0011053d71f",
"icons/Icon-maskable-192.png": "328eb761a4ebde662c2df0011053d71f",
"icons/Icon-maskable-512.png": "d2b73e5e59b14c5c176bd35a2898d512",
"icons/Icon-512.png": "d2b73e5e59b14c5c176bd35a2898d512",
"manifest.json": "bd9ac833252208d4bc8a6b6cd2981b4b",
"assets/AssetManifest.json": "8790615dc4baedfed285edb2ddcbb5dd",
"assets/NOTICES": "e03df412d2d6169e6cbb43bd2593d305",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "1a5025ba2d767b10b3e9cf398b673d25",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "13538638ac6839bfb19c7a187aa35b74",
"assets/fonts/MaterialIcons-Regular.otf": "458bafde0b2c058dbb4d8c3f382d0c2a",
"assets/assets/svg/pokeball_b&w.svg": "5607fcbf5d9e8735e49ab78702420ff8",
"assets/assets/images/types_badge/dark.png": "ff831aae9c5fd5366ad191718fffaa48",
"assets/assets/images/types_badge/fire.png": "956146f6cd2cdf0535b7f44dd32bec41",
"assets/assets/images/types_badge/dragon.png": "eec691e196bf67ac4cc7495750348844",
"assets/assets/images/types_badge/electric.png": "248dfd943573e700c490522d756ac812",
"assets/assets/images/types_badge/fairy.png": "23f2bb3a92001733c6c95380a2de3096",
"assets/assets/images/types_badge/rock.png": "266e7b6637048b2b840263621bd75ed7",
"assets/assets/images/types_badge/ghost.png": "74ba08da33b86dae2291cb94a9978490",
"assets/assets/images/types_badge/poison.png": "523d66c4518ed34c23aaa32ab4f3d446",
"assets/assets/images/types_badge/flying.png": "a9d51195698b345876bb340a412208e9",
"assets/assets/images/types_badge/grass.png": "50934a1446942773fa3da25df494f5c2",
"assets/assets/images/types_badge/ice.png": "069d987c16bf62da96a9c7c8bdbfd99a",
"assets/assets/images/types_badge/water.png": "de7f2b1baf0ae587861a95453b217dcc",
"assets/assets/images/types_badge/ground.png": "34d0381ab9ccd3ba261b2882a61136dd",
"assets/assets/images/types_badge/normal.png": "44adc200010a64eba99c95468f200230",
"assets/assets/images/types_badge/psychic.png": "2f70214ca9cad87fe414cb3d7edb8104",
"assets/assets/images/types_badge/bug.png": "ea89f23022719bf083b8684e40fa1b02",
"assets/assets/images/types_badge/fighting.png": "1f44468631cd9ae055951fea5e3014b1",
"assets/assets/images/types_badge/steel.png": "dcbf4e297383e3ed3feb2d4b0e97a026",
"assets/assets/images/icon-pokeball.png": "14d96b1d552ac1dd296a0d43664c269b",
"assets/assets/images/pokedeck_logo.png": "179b5e559d7a39d3fa717da5e3977fd6",
"assets/assets/images/pokeball.png": "5a1f67e65b8f1b1fc16c7f8c5c748a23",
"assets/assets/images/tabs_icons/trading.png": "777a0faa898135a5386311165b40c560",
"assets/assets/images/tabs_icons/search.png": "4780234936a96db072dfa8482c78dfbc",
"assets/assets/icon/icon.png": "14d96b1d552ac1dd296a0d43664c269b",
"assets/assets/icon/icon_launcher.png": "7bbb8266eeec8eb87578f89d6a1f4de5",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
