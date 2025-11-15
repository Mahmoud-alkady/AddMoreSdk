# AdMore SDK Architecture Documentation

## Overview

The AdMore SDK uses a **Feature-Based Architecture** with **Protocol-Driven Design** and **Input/Output ViewModels** to provide a clean, scalable, and maintainable codebase that supports iOS 12+.

## Architecture Principles

### 1. Feature-Based Architecture
Each ad format (Banner, Interstitial, Rewarded) is implemented as a separate feature with its own:
- ViewModel (Input/Output pattern)
- UseCase (Business logic)
- Repository (Data access)
- Factory (Dependency creation)

### 2. Protocol-Driven Design
All components are defined by protocols, enabling:
- Easy testing with mocks
- Flexible dependency injection
- Clear contracts between layers
- Runtime type safety

### 3. Input/Output ViewModels
ViewModels use a clear Input/Output pattern:
- **Input**: Actions from the UI layer
- **Output**: Callbacks to the UI layer
- **Separation**: Clear data flow and responsibilities

### 4. iOS 12 Compatibility
- No async/await (uses completion handlers)
- Callback-based architecture
- Fallback patterns for iOS 13+ features
- DispatchQueue.main.async for UI updates

## Layer Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        DEVELOPER LAYER                         │
│  AdDisplayView (Public API)                                    │
│  - loadAd()                                                    │
│  - delegate callbacks                                          │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    FEATURE LAYER                               │
│  BannerAdFactory / InterstitialAdFactory / RewardedAdFactory   │
│  - Creates feature-specific components                         │
│  - Manages dependencies based on AdFormat                      │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    VIEWMODEL LAYER                             │
│  BannerAdViewModel (Input/Output)                              │
│  - Input: Actions from UI                                      │
│  - Output: Callbacks to UI                                     │
│  - Coordinates between UI and UseCase                          │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    USECASE LAYER                               │
│  BannerAdUseCase (Business Logic)                              │
│  - Ad format specific business rules                           │
│  - Visibility management                                       │
│  - App lifecycle handling                                      │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    REPOSITORY LAYER                            │
│  BannerAdRepository (Data Access)                              │
│  - URL building                                                │
│  - Request caching                                             │
│  - WebView communication                                       │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    INFRASTRUCTURE LAYER                        │
│  WebViewService / AdURLBuilder / AdRequestCache                │
│  - Low-level services                                          │
│  - External dependencies                                       │
└─────────────────────────────────────────────────────────────────┘
```

## Component Details

### 1. AdDisplayView (Public API)
- **Purpose**: Public interface for developers
- **Responsibilities**: UI container, lifecycle management, delegate binding
- **Dependencies**: Feature factory, WebView, JavaScript observer

### 2. Feature Factory
- **Purpose**: Creates feature-specific components
- **Responsibilities**: Dependency injection, component creation
- **Pattern**: Factory pattern with protocol conformance

### 3. ViewModel (Input/Output)
- **Purpose**: UI logic coordination
- **Input**: Actions from UI layer
- **Output**: Callbacks to UI layer
- **Pattern**: Input/Output separation for clear data flow

### 4. UseCase
- **Purpose**: Business logic implementation
- **Responsibilities**: Ad format specific rules, state management
- **Pattern**: Single responsibility principle

### 5. Repository
- **Purpose**: Data access abstraction
- **Responsibilities**: URL building, caching, WebView communication
- **Pattern**: Repository pattern for data access

## Data Flow

### 1. Ad Loading Flow
```
Developer calls loadAd() 
→ AdDisplayView 
→ ViewModel Input 
→ UseCase 
→ Repository (builds URL with actual view dimensions)
→ WebView Service 
→ AdWebView (loads HTML/JS content)
```

### 2. Event Processing Flow
```
HTML/JS Event 
→ WebView 
→ AdDisplayView 
→ ViewModel Input 
→ UseCase 
→ ViewModel Output 
→ AdDisplayView 
→ Developer Delegate
```

### 3. Visibility Management Flow
```
Visibility Change 
→ AdWebView 
→ AdDisplayView 
→ ViewModel Input 
→ UseCase 
→ Business Logic 
→ ViewModel Output 
→ AdDisplayView 
→ Pause/Resume Actions
```

## iOS 12 Compatibility

### 1. Callback-Based Architecture
- Direct callback methods instead of reactive streams
- Simple delegate pattern for UI updates
- Manual event handling without Combine

### 2. Async Operations
- Completion handlers instead of async/await
- DispatchQueue.main.async for UI updates
- No structured concurrency

### 3. Fallback Patterns
- iOS 13+ features with iOS 12 fallbacks
- Runtime feature detection
- Graceful degradation

## Testing Strategy

### 1. Unit Testing
- Mock all protocol dependencies
- Test each layer independently
- Input/Output pattern enables easy testing

### 2. Integration Testing
- Test feature factories
- Test complete data flows
- Test iOS version compatibility

### 3. UI Testing
- Test AdDisplayView behavior
- Test delegate callbacks
- Test WebView integration

## Adding New Ad Formats

### 1. Create Feature Structure
```
Features/
└── NewAdFormat/
    ├── NewAdFormatViewModel.swift
    ├── NewAdFormatUseCase.swift
    ├── NewAdFormatRepository.swift
    └── NewAdFormatFactory.swift
```

### 2. Implement Protocols
- AdViewModelProtocol
- AdUseCaseProtocol
- AdRepositoryProtocol
- AdFeatureProtocol

### 3. Update Factory
- Add case to AdFeatureFactory (based on AdFormat)
- Create NewAdFormatFactory instance

### 4. Test Implementation
- Unit tests for each component
- Integration tests for complete flow
- UI tests for public API

## Benefits

### 1. Maintainability
- Clear separation of concerns
- Easy to understand and modify
- Consistent patterns across features

### 2. Testability
- Protocol-based mocking
- Isolated component testing
- Clear input/output contracts

### 3. Scalability
- Easy to add new ad formats
- Independent feature development
- Flexible dependency injection

### 4. Performance
- iOS 12 compatibility
- Optimized WebView usage
- Efficient memory management
- Direct URL building and loading (no unnecessary async overhead)
- Real-time view dimension passing

## Migration Guide

### From Current Architecture
1. **Phase 1**: Add base protocols and interfaces
2. **Phase 2**: Implement Banner feature as proof of concept
3. **Phase 3**: Migrate existing code to new architecture
4. **Phase 4**: Implement Interstitial and Rewarded features (based on AdFormat)
5. **Phase 5**: Remove old code and optimize

### Backward Compatibility
- Public API remains unchanged
- Existing delegate methods preserved
- Gradual migration possible

## Best Practices

### 1. Protocol Design
- Keep protocols focused and cohesive
- Use associated types for flexibility
- Document protocol requirements

### 2. Dependency Injection
- Inject dependencies through constructors
- Use factories for complex object creation
- Avoid singleton dependencies

### 3. Error Handling
- Use Result types for operations
- Provide meaningful error messages
- Handle errors gracefully

### 4. Memory Management
- Use weak references for delegates
- Avoid retain cycles
- Clean up resources properly

## Recent Optimizations

### Repository Simplification
- **Removed**: Unnecessary completion handlers for synchronous URL building
- **Added**: Direct WebView loading through service layer
- **Result**: Cleaner, more performant code flow

### Dynamic View Dimensions
- **Enhanced**: Real-time view dimension passing from AdDisplayView to Repository
- **Method**: Multi-source dimension detection (bounds, frame, constraints)
- **Priority**: bounds → frame → constraints → defaults
- **Auto-injection**: AdDisplayView automatically gets and injects its own dimensions
- **Smart loading**: Defers ad loading until proper dimensions are available
- **Auto-update**: Notifies ViewModel when view layout changes
- **Benefit**: Accurate ad sizing based on actual view dimensions, prevents 0x0 or default dimension requests

### WebView Service Integration
- **Added**: Direct WebView reference in service layer
- **Improved**: Seamless communication between Repository and WebView
- **Result**: Simplified data flow and better performance

### Enhanced WebViewService with JavaScript Management
- **Added**: Comprehensive JavaScript execution methods
- **Methods**: pauseAd(), resumeAd(), stopAd(), pauseAdWithTimers(), resumeAdWithTimers()
- **Communication**: sendMessage(), evaluateJavaScript(), checkSDKAvailability()
- **Integration**: Direct JavaScript-to-SDK communication for ad lifecycle management
- **Result**: Centralized JavaScript handling with consistent logging and error handling

### Memory Management & Lifecycle Optimization
- **Added**: Two-level cleanup system (pause vs cleanup)
- **Pause Level**: When view removed from hierarchy - pauses ad, keeps WebView alive
- **Cleanup Level**: When view deallocated - complete WebView destruction
- **Methods**: pauseAd(), resumeAd(), cleanup() with proper lifecycle handling
- **Benefits**: Efficient memory usage, proper ad pause/resume, no memory leaks

### Simplified Architecture Flow
- **Removed**: Unnecessary getWebViewService() method chains
- **Simplified**: Direct ViewModel calls from AdDisplayView
- **Flow**: AdDisplayView → ViewModel → UseCase → WebViewService
- **Result**: Cleaner code, better separation of concerns, easier maintenance

### Manager Classes for AdDisplayView
- **Added**: AdDimensionManager for view dimension handling
- **Added**: AdLifecycleManager for app lifecycle events
- **Added**: AdDelegateBinder for delegate callback management
- **Result**: AdDisplayView reduced from 366 to 200 lines, focused on core responsibilities

## Conclusion

This architecture provides a solid foundation for the AdMore SDK that is:
- **Clean**: Clear separation of concerns
- **Scalable**: Easy to add new features
- **Testable**: Protocol-based design
- **Compatible**: iOS 12+ support
- **Maintainable**: Consistent patterns
- **Optimized**: Direct data flow and real-time dimension handling

The feature-based approach with protocol-driven design ensures that the SDK can evolve and grow while maintaining code quality and developer experience.

## Developer Flow Documentation

### SDK Developer Flow (iOS App Integration)

#### 1. Initialization Flow
```
Developer calls AdDisplayView(adType, adUnitId, adFormat)
    ↓
AdFeatureFactory.createFeature() checks adFormat
    ↓
Creates appropriate factory (BannerAdFactory, InterstitialAdFactory, etc.)
    ↓
Factory.setupDependencies() creates complete dependency graph:
    • Repository (URL building, caching)
    • UseCase (business logic)
    • ViewModel (UI coordination)
    • WebView Service (WebView operations)
    ↓
Returns fully configured ViewModel to AdDisplayView
```

#### 2. Ad Loading Flow
```
Developer calls adDisplayView.loadAd()
    ↓
ViewModel.input.loadAd() gets view dimensions
    ↓
Creates AdLoadRequest with all parameters
    ↓
UseCase.loadAd() processes request
    ↓
Repository.loadAd() builds URL and caches request
    ↓
WebViewService.loadURL() loads content in WebView
    ↓
WebView loads HTML/JS content from server
```

#### 3. Event Processing Flow
```
JavaScript sends event (onStarted, onError, onClick, etc.)
    ↓
AdWebView receives via WKScriptMessageHandler
    ↓
AdDisplayView.webView(didReceiveMessage:) processes
    ↓
ViewModel.input.processWebViewMessage() handles
    ↓
UseCase.processAction() maps to developer data
    ↓
AdActionMapper maps internal models to developer models
    ↓
ViewModel.output callbacks trigger
    ↓
AdDisplayView delegate methods called
    ↓
Developer receives rich data in delegate callbacks
```

#### 4. Visibility & Lifecycle Flow
```
AdWebView tracks visibility changes
    ↓
ViewModel.input.handleVisibilityChange() processes
    ↓
UseCase.handleVisibilityChange() determines action
    ↓
WebViewService.pauseAd() or resumeAd() called
    ↓
JavaScript receives pause/resume commands
    ↓
Ad content pauses/resumes accordingly
```

#### 5. Memory Management & Navigation Flow
```
User navigates away from screen
    ↓
AdDisplayView.didMoveToSuperview() called with superview == nil
    ↓
AdDisplayView.pauseAd() called
    ↓
ViewModel.input.handleVisibilityChange(isVisible: false, percentage: 0)
    ↓
UseCase.handleVisibilityChange() processes
    ↓
WebViewService.pauseAd() called
    ↓
JavaScript: window.admoreSDK.pauseAd() + clearTimers()
    ↓
Ad paused, countdown timers stopped, WebView kept alive

User returns to screen
    ↓
AdDisplayView.didMoveToSuperview() called with superview != nil
    ↓
AdDisplayView.resumeAd() called
    ↓
ViewModel.input.handleVisibilityChange(isVisible: true, percentage: 1.0)
    ↓
UseCase.handleVisibilityChange() processes
    ↓
WebViewService.resumeAd() called
    ↓
JavaScript: window.admoreSDK.resumeAd()
    ↓
Ad resumes, countdown timers restart

View completely destroyed
    ↓
AdDisplayView.deinit called
    ↓
AdDisplayView.cleanup() called
    ↓
WebViewService.cleanupWebView() called
    ↓
WebView completely destroyed, memory freed
```

### Frontend Developer Flow (JavaScript/HTML)

#### 1. Ad Content Structure
```html
<!DOCTYPE html>
<html>
<head>
    <script>
        // AdMore SDK JavaScript API
        window.admoreSDK = {
            receiveEvent: function(eventType, data) {
                // Handle SDK events (pause, resume, etc.)
            },
            pauseAd: function() {
                // Pause ad content, animations, videos
                pauseVideo();
                pauseAnimations();
            },
            resumeAd: function() {
                // Resume ad content, animations, videos
                resumeVideo();
                resumeAnimations();
            },
            stopAd: function() {
                // Complete stop - used for cleanup
                stopAllAnimations();
                clearAllTimers();
            },
            clearTimers: function() {
                // Clear all setTimeout/setInterval
                clearInterval(countdownTimer);
                clearTimeout(delayTimer);
            },
            receiveMessage: function(message) {
                // Handle custom messages from iOS SDK
                console.log('Received message from iOS:', message);
            }
        };
    </script>
</head>
<body>
    <!-- Your ad content here -->
    <div id="ad-content">
        <!-- Banner, video, or interactive content -->
    </div>
    
    <script>
        // Send events to SDK
        function sendEvent(eventType, data) {
            if (window.webkit && window.webkit.messageHandlers.admore) {
                window.webkit.messageHandlers.admore.postMessage({
                    action: eventType,
                    data: data,
                    timestamp: new Date().toISOString()
                });
            }
        }
        
        // Example: Ad started
        sendEvent('on_ad_started', {
            os: navigator.platform,
            // other data
        });
        
        // Example: Ad clicked
        sendEvent('on_click', {
            click_count: 1,
            open_url: 'https://example.com',
            click_url: 'https://tracker.com'
        });
    </script>
</body>
</html>
```

#### 2. Event Communication
```
Frontend JavaScript detects user action
    ↓
Calls sendEvent(eventType, data)
    ↓
Posts message to WKScriptMessageHandler
    ↓
iOS SDK receives via AdWebView
    ↓
Processes through architecture layers
    ↓
Developer receives callback with mapped data
```

#### 3. SDK Commands (iOS SDK → Frontend)
```javascript
// Pause ad (called by iOS SDK)
window.admoreSDK.pauseAd();

// Resume ad (called by iOS SDK)
window.admoreSDK.resumeAd();

// Stop ad completely (called by iOS SDK during cleanup)
window.admoreSDK.stopAd();

// Clear timers (called by iOS SDK)
window.admoreSDK.clearTimers();

// Receive custom messages from iOS SDK
window.admoreSDK.receiveMessage({
    action: 'customEvent',
    data: { timestamp: Date.now() }
});
```

### Complete Integration Example

#### iOS Developer Code
```swift
class ViewController: UIViewController {
    private var adDisplayView: AdDisplayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Initialize AdDisplayView
        adDisplayView = AdDisplayView(
            adType: .html,
            adUnitId: "your_ad_unit_id",
            adFormat: .banner
        )
        
        // 2. Set delegate
        adDisplayView.delegate = self
        
        // 3. Add to view hierarchy
        view.addSubview(adDisplayView)
        setupConstraints()
        
        // 4. Load ad
        adDisplayView.loadAd()
    }
    
    private func setupConstraints() {
        adDisplayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            adDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            adDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            adDisplayView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - AdDisplayViewDelegate
extension ViewController: AdDisplayViewDelegate {
    func adDisplayViewDidLoad(_ adView: AdDisplayView, with data: AdLoadedData) {
        print("✅ Ad loaded - Session: \(data.sessionId ?? "N/A")")
    }
    
    func adDisplayView(_ adView: AdDisplayView, didFailWithError error: AdError, data: AdFailedData) {
        print("❌ Ad failed: \(error.localizedDescription)")
    }
    
    func adDisplayViewDidClick(_ adView: AdDisplayView, with data: AdClickedData) {
        print("👆 Ad clicked - URL: \(data.openUrl ?? "N/A")")
    }
    
    func adDisplayViewDidComplete(_ adView: AdDisplayView, with data: AdCompletedData) {
        print("🎉 Ad completed")
    }
    
    func adDisplayView(_ adView: AdDisplayView, didEarnReward amount: Double, data: AdRewardData) {
        print("💰 Reward earned: \(amount)")
    }
}
```

### Data Flow Summary

#### SDK → Frontend
- **URL Loading**: SDK loads ad content in WebView
- **Pause/Resume Commands**: SDK sends pause/resume to JavaScript
- **Visibility Events**: SDK notifies frontend of visibility changes

#### Frontend → SDK
- **Ad Events**: JavaScript sends onStarted, onError, onClick, etc.
- **User Interactions**: Click tracking, completion events
- **Error Reporting**: Frontend reports errors to SDK

#### SDK → Developer
- **Rich Data Models**: Mapped from internal action models
- **Delegate Callbacks**: Clean interface for all ad events
- **Error Handling**: Detailed error information with context

### Key Benefits

#### For iOS Developers
- **Simple Integration**: 4 lines of code to get started
- **Rich Data**: Complete context for all ad events
- **Type Safety**: No unsafe casting, compile-time safety
- **Automatic Features**: Pause/resume, lifecycle handling, memory management
- **Clean Architecture**: Feature-based design with clear separation of concerns

#### For Frontend Developers
- **Standard Web APIs**: Uses WKWebView message passing
- **Event-Driven**: Simple event system for communication
- **Flexible Content**: Support for HTML, video, interactive ads
- **SDK Integration**: Automatic pause/resume handling with countdown timer support
- **Memory Efficient**: Proper cleanup and lifecycle management

This flow documentation provides complete guidance for both iOS and frontend developers working with the AdMore SDK.
