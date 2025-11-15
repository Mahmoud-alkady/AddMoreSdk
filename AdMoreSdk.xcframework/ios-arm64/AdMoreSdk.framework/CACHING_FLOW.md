# Ad Strategy Caching Flow

## 📍 Where Caching Happens

The caching occurs in **`AdSDKEventManager.swift`** after the strategy processes events:

```swift
// AdSDKEventManager.handleEvent() - Line 25-27
func handleEvent(_ result: AdBusinessResult, from strategy: AdStrategyProtocol) {
    // 1. Handle caching if needed
    if result.shouldCache {
        strategy.requestCache.cacheResponse(result.businessData, for: sessionId)
    }
    
    // 2. Handle internal SDK logic
    handleInternalLogic(result)
    
    // 3. Trigger developer callbacks
    triggerDeveloperCallbacks(result)
}
```

## 🔄 Complete Flow

```
1. Raw Data [String: Any]
   ↓
2. BannerAdStrategy.processEvent()
   ↓
3. AdDataProcessor (processes & converts to models)
   ↓
4. AdBusinessResult (with shouldCache flag)
   ↓
5. AdSDKEventManager.handleEvent()
   ↓
6. 🗄️ Cache Response (if shouldCache = true)
   ↓
7. Developer Callbacks
```

## 💾 What Gets Cached

- **AdBusinessResult.businessData** - The processed data dictionary
- **Only if shouldCache = true** (controlled by result type)
- **Stored by sessionId** in AdRequestCache

## 📊 Cache Rules

| Result Type | shouldCache | Reason |
|-------------|-------------|---------|
| `.ready()` | `true` | Important state changes |
| `.completed()` | `true` | Important completion events |
| `.clicked()` | `false` | Temporary interactions |
| `.failed()` | `false` | Error states don't need caching |
| `.reward()` | `true` | Critical reward data |
| `.noAction()` | `false` | No action to cache |

## 🛠️ Cache Implementation

The actual caching is handled by:
- **`AdRequestCache.cacheResponse()`** - Stores response data
- **Uses UserDefaults** for persistence
- **Indexed by sessionId** for retrieval

## 🎯 Model Conversion Before Caching

The strategy converts raw data to typed models, then extracts relevant data for caching:

```swift
// Example: AdLoadEvent → businessData for caching
let event = AdLoadEvent(...)
return .ready(data: [
    "loadTime": event.loadTime,      // ← This gets cached
    "adFormat": event.adFormat,      // ← This gets cached  
    "sessionId": event.sessionId     // ← This gets cached
])
```

