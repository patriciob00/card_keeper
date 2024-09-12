'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "da9389ef968a602104b0faad3f088269",
"version.json": "719491c0973ca30b0eb15cc621c5cf8f",
"splash/img/light-2x.png": "b6e651e169d8f9ddd4edc4307a666f89",
"splash/img/branding-4x.png": "4c88385b264d3327b0beacd5b94354f7",
"splash/img/dark-4x.png": "443a7aa95781e35c1420efe174abff9c",
"splash/img/branding-dark-1x.png": "81960d07f0d86ca0383c4f191f6d6c68",
"splash/img/light-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/dark-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/light-background.png": "e39f838109c236e032304dad1ed28e9d",
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
"index.html": "4bd690076b6ac9adfa0a78f618f1494f",
"/": "4bd690076b6ac9adfa0a78f618f1494f",
"main.dart.js": "e0719f151d1f825e474b0cbcda601fa0",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "b15c0ae7ec13f83ef34c59aac39b7379",
"icons/Icon-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"icons/Icon-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"manifest.json": "ad4382855ae9c70ef31cd81257ccd17f",
"assets/AssetManifest.json": "df2d7117a4e6236d93790c65003d9af3",
"assets/NOTICES": "f117576b77c881ca5689a29480b9029f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "905c60479cf7e5926d5f81820e8ae98e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "17e7d0ca9bab78e25ffa3a5d96424312",
"assets/fonts/MaterialIcons-Regular.otf": "e0badb0000c9ba6aff7eea5581ee404b",
"assets/assets/svg/sale_icon.svg": "755d5112d1cce8bc6b08155e1c758dcd",
"assets/assets/svg/search_icon.svg": "6c50b804c99c90da5f6c217dbb2733c5",
"assets/assets/svg/home_icon.svg": "30d3a67dcb512bf6d0b471949cb2836e",
"assets/assets/svg/list_cards.svg": "a0bae8f0a824e9eb14b6e0c87fa0fcc9",
"assets/assets/svg/trading_icon.svg": "5902c612b8460827f098fd1d12dab1c7",
"assets/assets/svg/deck_icon.svg": "c2b69d365b049c5819e8eb075381f3f9",
"assets/assets/svg/card_fight.svg": "533a8ee81c371977dd7b20c2b8387d65",
"assets/assets/svg/pokeball_b&w.svg": "5607fcbf5d9e8735e49ab78702420ff8",
"assets/assets/svg/cards.svg": "31ff27d2126981f29152d0246be79524",
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
"assets/assets/images/logo_text.png": "b1f57dd6bab13a53023d3ef0e6f53789",
"assets/assets/images/icon-pokeball.png": "14d96b1d552ac1dd296a0d43664c269b",
"assets/assets/images/pokeball.png": "5a1f67e65b8f1b1fc16c7f8c5c748a23",
"assets/assets/images/logo.png": "fcca65c8c5d01de52d2e170013fcee6c",
"assets/assets/images/logo2.png": "a9120794c1c3b60b13cc89282fd633ca",
"assets/assets/images/tabs_icons/trading.png": "777a0faa898135a5386311165b40c560",
"assets/assets/images/tabs_icons/search.png": "4780234936a96db072dfa8482c78dfbc",
"assets/assets/images/splash_bg.png": "e39f838109c236e032304dad1ed28e9d",
"assets/assets/icon/icon_launcher.png": "30b85e4581d2f8010e7ba14f34605128",
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
