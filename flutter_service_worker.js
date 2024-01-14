'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "9a48ad1f9281b0905e72efaa317b4dcb",
"favicon.ico": "f7e40411a9617272ddf14cba925552a7",
"index.html": "5e0fe2e456430afab619fca2d30d1bbc",
"/": "5e0fe2e456430afab619fca2d30d1bbc",
"main.dart.js": "6eaeabfc8a6d99def65cd9de53e26132",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"icons/android-chrome-192x192.png": "331d9b75cd17ae86b702ea552d385eaa",
"icons/apple-touch-icon.png": "801389929975a49676e40b1cb013c0f5",
"icons/android-chrome-512x512.png": "669e479b01a9720207d9bfb7288b8a1c",
"manifest.json": "81bca8e0f572cddb030e6c3606cab9f0",
"assets/asset/images/videography.webp": "06d50b65fc996c22f35f10bc5577711a",
"assets/asset/images/catering_service.jpg": "dbc2ec85f9284c1f9241c7c287784fc2",
"assets/asset/images/event_management.jpg": "a2a1d1244ca274cc00ae711be15f01a6",
"assets/asset/images/top_in_city_logo.webp": "f684d714be3df6ac31cc5b387afe760c",
"assets/asset/fonts/JosefinSans-Italic.ttf": "60e18f701444e5f9095c42bbb822aa67",
"assets/asset/fonts/JosefinSans-Thin.ttf": "d607cc95c7738c6c7c21af4df132d6e8",
"assets/asset/fonts/JosefinSans-Bold.ttf": "9b93e2dc1845186696aeb17d692e1652",
"assets/asset/fonts/JosefinSans-Light.ttf": "d0da23b4597d73857e6420be0542f3ee",
"assets/asset/fonts/JosefinSans-LightItalic.ttf": "28cd752762cc887154152e3723e5e500",
"assets/asset/fonts/Chilanka-Regular.ttf": "1d63d46cdaa139dbf0b5b2a8d3d5a32a",
"assets/asset/fonts/JosefinSans-MediumItalic.ttf": "8e116a85494d2dfe5c9a7948c034814f",
"assets/asset/fonts/JosefinSans-SemiBold.ttf": "dddc915e91657a933cdc46a566f4a256",
"assets/asset/fonts/JosefinSans-Regular.ttf": "d043c7832664506d64199a29bc1848df",
"assets/asset/fonts/JosefinSans-ExtraLightItalic.ttf": "de794ade83b12356044161a2b60c8d52",
"assets/asset/fonts/JosefinSans-Medium.ttf": "87a8c8f80f8cbdcfc2b1d30b651ee9f8",
"assets/asset/fonts/JosefinSans-BoldItalic.ttf": "152f2f9c8567c968304a6d11c77a9d38",
"assets/asset/fonts/JosefinSans-ThinItalic.ttf": "4b603b14ffe7add2f77aca760fef4dac",
"assets/asset/fonts/JosefinSans-ExtraLight.ttf": "710941b85db9267d8d59160772cf6852",
"assets/asset/fonts/JosefinSans-SemiBoldItalic.ttf": "7937a8fc33336f4487745388629f98e7",
"assets/AssetManifest.json": "c99a6e99d0f470613f07c7c154044503",
"assets/NOTICES": "c99f80952cf00ccbb643ff7f55c62b50",
"assets/FontManifest.json": "704b6814399567f455c52e9427cd86d0",
"assets/AssetManifest.bin.json": "4cf41911ef4f2974c4d45ddaa41b85f7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "2ff1458ca41365052ced820e01b14d2b",
"assets/fonts/MaterialIcons-Regular.otf": "4a605f5da94f25c87a21ab9601e256e1",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
