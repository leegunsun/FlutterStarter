let appKey;

self.addEventListener('message', function(event) {
  if (event.data && event.data.type === 'SET_APP_KEY') {
    appKey = event.data.appKey;
    console.log('App key received:', appKey);

    // App key를 받은 후에 캐싱 수행
    caches.open('kakao-map-cache').then(function(cache) {
      return cache.add(new Request(`https://dapi.kakao.com/v2/maps/sdk.js?appkey=${appKey}&autoload=false`, { mode: 'no-cors' }))
        .then(() => console.log('SDK cached successfully'))
        .catch(error => console.error('Error caching SDK:', error));
    });
  }
});

self.addEventListener('install', function(event) {
  console.log('Service Worker install event triggered');
  self.skipWaiting(); // 즉시 활성화
});

self.addEventListener('fetch', function(event) {
  console.log('Fetch event for:', event.request.url);
  event.respondWith(
    caches.match(event.request).then(function(response) {
      if (response) {
        console.log('Serving from cache:', event.request.url);
      } else {
        console.log('Fetching from network:', event.request.url);
      }
      return response || fetch(event.request);
    }).catch((error) => {
      console.error('Fetch error:', error);
    })
  );
});
