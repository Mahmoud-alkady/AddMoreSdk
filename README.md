# AddMoreSdk

A comprehensive iOS SDK for collecting user and device data for analytics and business intelligence.

## 🚀 Features

- **Simple Integration**: Just two methods to get started
- **Privacy-First**: GDPR/CCPA compliant data collection
- **Comprehensive Coverage**: 20+ data collection categories
- **Binary Framework**: Source code protected

## 📋 Requirements

- **iOS**: 12.0+
- **Swift**: 4.2+ (binary framework compiled with Swift 4.2)
- **Xcode**: 10.0+
- **Swift Package Manager**: 5.0+

> **Swift Version Compatibility**: This SDK uses a binary framework compiled with Swift 4.2, which is **fully compatible** with Swift 4.2+ projects, including Swift 6.0. The binary framework is pre-compiled and uses Swift ABI stability, so it works seamlessly with newer Swift versions.

> **Note**: The Package.swift uses Swift 6.0 tools for modern SPM support, but the actual framework binary is Swift 4.2 compatible.

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
