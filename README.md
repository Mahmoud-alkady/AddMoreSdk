# AdMoreSdk

[![Swift Package Manager](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![iOS](https://img.shields.io/badge/iOS-12.0+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE.md)

A comprehensive iOS SDK for collecting user and device data for analytics and business intelligence. Built with privacy-first principles and GDPR/CCPA compliance.

## 🚀 Features

- **Simple Integration**: Just two methods to get started
- **Privacy-First**: GDPR/CCPA compliant data collection
- **Comprehensive Coverage**: 20+ data collection categories
- **Binary Framework**: Source code protected via XCFramework
- **Swift Package Manager**: Easy integration via SPM
- **iOS 12+ Support**: Compatible with a wide range of iOS versions

## 📋 Requirements

- iOS 12.0 or later
- Xcode 12.0 or later
- Swift 5.5 or later

## 📦 Installation

### Swift Package Manager

Swift Package Manager is the recommended way to integrate AdMoreSdk.

#### Using Xcode

1. In Xcode, select **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/Mahmoud-alkady/AddMoreSdk.git
   ```
3. Choose the version rule:
   - **Up to Next Major Version**: `0.1.0` (recommended for most cases)
   - **Exact Version**: `0.1.0` (for production stability)
4. Click **Add Package**

#### Using Package.swift

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Mahmoud-alkady/AddMoreSdk.git", from: "0.1.0")
]
```

Then add `AdMoreSdk` to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["AdMoreSdk"]
    )
]
```

### Manual Installation

1. Download the latest release from [Releases](https://github.com/Mahmoud-alkady/AddMoreSdk/releases)
2. Extract the `AdMoreSdk.xcframework`
3. Drag `AdMoreSdk.xcframework` into your Xcode project
4. In your target's **General** tab, add `AdMoreSdk.xcframework` to **Frameworks, Libraries, and Embedded Content**
5. Ensure **Embed & Sign** is selected

## 🎯 Quick Start

### 1. Import the SDK

```swift
import AdMoreSdk
```

### 2. Initialize the SDK

In your `AppDelegate.swift` or `SceneDelegate.swift`:

```swift
import UIKit
import AdMoreSdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, 
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize AdMoreSdk
        AdMore.shared.start(uniqueKey: "your-unique-key-here")
        
        return true
    }
}
```

### 3. Send Events

```swift
// Send custom events
AdMore.shared.sendEvent(data: [
    "event_type": "user_action",
    "screen_name": "home_screen",
    "user_id": "12345"
])
```

### 4. Display Ads

```swift
// Banner ad
let bannerView = AdMore.shared.bannerView(
    adType: .banner,
    adUnitId: "your-ad-unit-id",
    adPlacementId: "your-placement-id"
)
view.addSubview(bannerView)

// Full-screen ad
AdMore.shared.presentFullScreenAd(
    adType: .interstitial,
    adUnitId: "your-ad-unit-id",
    adPlacementId: "your-placement-id",
    delegate: self
)
```

## 📚 API Documentation

### AdMore Class

The main entry point for the SDK.

#### Methods

##### `start(uniqueKey:)`

Initializes the SDK with your unique key.

```swift
func start(uniqueKey: String)
```

**Parameters:**
- `uniqueKey`: Your unique API key for the SDK

**Example:**
```swift
AdMore.shared.start(uniqueKey: "your-unique-key")
```

##### `sendEvent(data:)`

Sends a custom event with associated data.

```swift
func sendEvent(data: [String: Any] = [:])
```

**Parameters:**
- `data`: Dictionary containing event data (optional, defaults to empty)

**Example:**
```swift
AdMore.shared.sendEvent(data: [
    "event_type": "purchase",
    "amount": 99.99,
    "currency": "USD"
])
```

##### `bannerView(adType:adUnitId:adPlacementId:)`

Creates and returns a banner ad view.

```swift
func bannerView(adType: AdType, adUnitId: String, adPlacementId: String) -> AdDisplayView
```

**Parameters:**
- `adType`: Type of ad (`.banner`, `.interstitial`, etc.)
- `adUnitId`: Your ad unit identifier
- `adPlacementId`: Placement identifier for tracking

**Returns:** `AdDisplayView` - The banner view to add to your UI

##### `presentFullScreenAd(adType:adUnitId:adPlacementId:delegate:)`

Presents a full-screen ad.

```swift
func presentFullScreenAd(adType: AdType, adUnitId: String, adPlacementId: String, delegate: AdDisplayViewDelegate?)
```

**Parameters:**
- `adType`: Type of ad
- `adUnitId`: Your ad unit identifier
- `adPlacementId`: Placement identifier
- `delegate`: Optional delegate for ad events

## 📋 Version Compatibility

| Version | Minimum iOS | Features | Notes |
|---------|-------------|----------|-------|
| 0.1.0   | iOS 12.0    | Initial release | Basic data collection, banner ads, full-screen ads |

For detailed changelog, see [CHANGELOG.md](CHANGELOG.md).

## 🔄 Migration Guides

### Upgrading from Previous Versions

When upgrading to a new version, check the [CHANGELOG.md](CHANGELOG.md) for breaking changes and migration instructions.

## 💻 Example Projects

See the `docs/` directory for example implementations and best practices.

## 🛠️ Troubleshooting

### Common Issues

#### SDK Not Initializing

**Problem:** SDK methods not working after initialization.

**Solution:**
- Ensure `start(uniqueKey:)` is called in `application(_:didFinishLaunchingWithOptions:)`
- Verify your unique key is correct
- Check console for error messages

#### Framework Not Found

**Problem:** `No such module 'AdMoreSdk'` error.

**Solution:**
- Clean build folder: **Product → Clean Build Folder** (⇧⌘K)
- Reset package caches: **File → Packages → Reset Package Caches**
- Rebuild the project

#### Version Resolution Issues

**Problem:** Xcode can't resolve the package version.

**Solution:**
- Verify the tag exists on GitHub
- Check your version requirement in Package.swift
- Try: **File → Packages → Update to Latest Package Versions**

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/Mahmoud-alkady/AddMoreSdk/issues)
- **Documentation**: See `docs/` directory
- **Release Notes**: [CHANGELOG.md](CHANGELOG.md)

## 🔗 Links

- [Repository](https://github.com/Mahmoud-alkady/AddMoreSdk)
- [Releases](https://github.com/Mahmoud-alkady/AddMoreSdk/releases)
- [Issues](https://github.com/Mahmoud-alkady/AddMoreSdk/issues)

---

Made with ❤️ for iOS developers
