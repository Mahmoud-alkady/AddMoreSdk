# AddMoreSdk

A comprehensive iOS SDK for collecting user and device data for analytics and business intelligence.

## 🚀 Features

- **Simple Integration**: Just two methods to get started
- **Privacy-First**: GDPR/CCPA compliant data collection
- **Comprehensive Coverage**: 20+ data collection categories
- **Binary Framework**: Source code protected

## 📦 Installation

### Swift Package Manager

Add this to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/Mahmoud-alkady/AddMoreSdk", from: "1.0.0")
]
```

Or in Xcode:
1. **File → Add Package Dependencies**
2. **Enter URL**: `https://github.com/Mahmoud-alkady/AddMoreSdk`
3. **Click "Add Package"**

## 🎯 Quick Start

```swift
import AddMoreSdk

// Initialize
AddMoreSdk.shared.start(uniqueKey: "your-unique-key")

// Send events
AddMoreSdk.shared.sendEvent(data: [
    "event_type": "user_action",
    "screen_name": "home_screen"
])
```

## 📄 License

MIT License - see [LICENSE](LICENSE.md) for details.
