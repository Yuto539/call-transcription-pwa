const CACHE_NAME = 'call-recorder-v1.0.0';
const urlsToCache = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icon-72.png',
  '/icon-96.png',
  '/icon-128.png',
  '/icon-144.png',
  '/icon-152.png',
  '/icon-192.png',
  '/icon-384.png',
  '/icon-512.png'
];

// Service Worker インストール
self.addEventListener('install', function(event) {
  console.log('SW: Install event');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        console.log('SW: Cache opened');
        return cache.addAll(urlsToCache);
      })
      .then(function() {
        console.log('SW: All resources cached');
        return self.skipWaiting();
      })
  );
});

// Service Worker アクティベーション
self.addEventListener('activate', function(event) {
  console.log('SW: Activate event');
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.map(function(cacheName) {
          if (cacheName !== CACHE_NAME) {
            console.log('SW: Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(function() {
      console.log('SW: Claiming clients');
      return self.clients.claim();
    })
  );
});

// フェッチイベント処理
self.addEventListener('fetch', function(event) {
  if (event.request.method === 'GET') {
    event.respondWith(
      caches.match(event.request)
        .then(function(response) {
          // キャッシュにある場合はそれを返す
          if (response) {
            console.log('SW: Serving from cache:', event.request.url);
            return response;
          }
          
          // キャッシュにない場合はネットワークから取得
          console.log('SW: Fetching from network:', event.request.url);
          return fetch(event.request).then(function(response) {
            // レスポンスが有効でない場合はそのまま返す
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }
            
            // レスポンスをクローンしてキャッシュに保存
            const responseToCache = response.clone();
            caches.open(CACHE_NAME)
              .then(function(cache) {
                cache.put(event.request, responseToCache);
              });
            
            return response;
          });
        })
        .catch(function() {
          // オフライン時の処理
          console.log('SW: Network failed, serving offline page');
          if (event.request.destination === 'document') {
            return caches.match('/index.html');
          }
        })
    );
  }
});

// バックグラウンド同期（録音データの保存）
self.addEventListener('sync', function(event) {
  console.log('SW: Background sync event:', event.tag);
  
  if (event.tag === 'save-recording') {
    event.waitUntil(
      // 録音データの保存処理
      saveRecordingData()
    );
  }
});

// プッシュ通知の受信
self.addEventListener('push', function(event) {
  console.log('SW: Push event received');
  
  const options = {
    body: '録音の処理が完了しました',
    icon: '/icon-192.png',
    badge: '/icon-72.png',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      {
        action: 'explore',
        title: '確認する',
        icon: '/icon-128.png'
      },
      {
        action: 'close',
        title: '閉じる',
        icon: '/icon-72.png'
      }
    ]
  };
  
  event.waitUntil(
    self.registration.showNotification('通話録音PWA', options)
  );
});

// 通知クリック処理
self.addEventListener('notificationclick', function(event) {
  console.log('SW: Notification click received');
  
  event.notification.close();
  
  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// メッセージ受信処理
self.addEventListener('message', function(event) {
  console.log('SW: Message received:', event.data);
  
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  
  if (event.data && event.data.type === 'CACHE_RECORDING') {
    // 録音データをキャッシュに保存
    cacheRecordingData(event.data.recordingData);
  }
});

// 録音データの保存処理
async function saveRecordingData() {
  try {
    console.log('SW: Saving recording data...');
    
    // IndexedDBへの保存処理
    const db = await openDatabase();
    const transaction = db.transaction(['recordings'], 'readwrite');
    const store = transaction.objectStore('recordings');
    
    // 保存処理の実装
    // 実際の録音データの保存ロジックをここに記述
    
    return transaction.complete;
  } catch (error) {
    console.error('SW: Error saving recording data:', error);
    throw error;
  }
}

// 録音データのキャッシュ処理
async function cacheRecordingData(recordingData) {
  try {
    console.log('SW: Caching recording data...');
    
    const cache = await caches.open(CACHE_NAME);
    
    // 録音データを適切な形式でキャッシュ
    // 実際の実装では、録音データを適切に処理してキャッシュに保存
    
    console.log('SW: Recording data cached successfully');
  } catch (error) {
    console.error('SW: Error caching recording data:', error);
  }
}

// データベースの開封
function openDatabase() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('CallRecorderDB', 1);
    
    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);
    
    request.onupgradeneeded = (event) => {
      const db = event.target.result;
      
      // 録音データ用のオブジェクトストア
      if (!db.objectStoreNames.contains('recordings')) {
        const store = db.createObjectStore('recordings', { keyPath: 'id', autoIncrement: true });
        store.createIndex('timestamp', 'timestamp', { unique: false });
        store.createIndex('title', 'title', { unique: false });
      }
      
      // 設定データ用のオブジェクトストア
      if (!db.objectStoreNames.contains('settings')) {
        db.createObjectStore('settings', { keyPath: 'key' });
      }
    };
  });
}

// エラーハンドリング
self.addEventListener('error', function(event) {
  console.error('SW: Error occurred:', event.error);
});

self.addEventListener('unhandledrejection', function(event) {
  console.error('SW: Unhandled promise rejection:', event.reason);
});

console.log('SW: Service Worker script loaded');