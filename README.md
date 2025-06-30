# OversizeCore

A comprehensive Swift package providing essential extensions and utilities for iOS, macOS, tvOS, and watchOS development. OversizeCore enhances your development experience with carefully crafted extensions for Swift standard library types, SwiftUI components, and common development patterns.

## Features

✨ **Swift Standard Library Extensions**
- String manipulation and validation utilities
- Number formatting and conversion helpers  
- Array and collection enhancements
- Optional value safety utilities
- Date and calendar operations

🎨 **SwiftUI & UIKit Extensions**
- Color utilities with hex support and manipulation
- Image processing and data conversion
- View screenshot and rendering capabilities
- Platform-specific UI enhancements

🛠️ **Development Utilities**
- Comprehensive logging system with categorized output
- Async/await delay functions for modern Swift
- URL and networking helpers
- Locale and currency formatting tools

📱 **Multi-Platform Support**
- iOS 15.0+
- macOS 12.0+
- tvOS 15.0+
- watchOS 9.0+

## Installation

### Swift Package Manager

Add OversizeCore to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/oversizedev/OversizeCore.git", from: "1.0.0")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["OversizeCore"]
)
```

### Xcode

1. Open your project in Xcode
2. Go to **File** → **Add Package Dependencies**
3. Enter the repository URL: `https://github.com/oversizedev/OversizeCore.git`
4. Select the version and add the package to your project

## Quick Start

```swift
import OversizeCore

// String utilities
let formatted = "hello world".capitalizingFirstLetter() // "Hello world"
let isValid = "user@example.com".isValidEmail // true

// Number formatting
let temperature = 23.5.toStringTemperature // "24°"
let display = 1234.5.toStringOnePoint // "1234.5"

// Color utilities
let color = Color(hex: "#FF6B6B")
let hexString = color.hexString() // "#FF6B6B"
let lighter = color.lighter(by: 20)

// Array enhancements
let numbers = [1, 2, 3, 4, 5]
let sum = numbers.sum // 15
let unique = [1, 2, 2, 3].removeDuplicates() // [1, 2, 3]

// Logging with categories
logInfo("Application started")
logError("Network request failed")
logSuccess("Data saved successfully")

// Modern async delays
await delay(.seconds(1)) {
    print("Executed after 1 second")
}
```

## Documentation

The package is fully documented with Apple-style documentation comments compatible with DocC. Generate documentation using:

```bash
swift package generate-documentation
```

## Categories

### Swift Extensions
- **String**: Validation, formatting, HTML processing, regex matching
- **Number**: Temperature formatting, string conversion, mathematical operations  
- **Array**: Collection manipulation, duplicate removal, element access
- **Optional**: Safe value extraction with defaults
- **Date**: ISO8601 parsing, formatting utilities
- **Bool**: iOS version availability checks

### UI Extensions  
- **Color**: Hex color support, color manipulation, component extraction
- **Image**: Average color extraction, data conversion
- **View**: Screenshot capture, rendering utilities

### System Extensions
- **URL**: Validation, cache management, file system helpers
- **Locale**: Currency formatting, localization support
- **SwiftData**: Model extensions and sort order utilities

### Global Utilities
- **Logging**: Categorized logging with emoji indicators
- **Delay**: Modern async/await delay functions
- **Map**: Location coordinate extensions

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

1. Clone the repository
2. Open `Package.swift` in Xcode
3. Run tests with `⌘+U`
4. Build documentation with `swift package generate-documentation`

## Requirements

- Swift 6.0+
- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 9.0+

## License

Copyright © 2022-2025 Alexander Romanov

This project is available under the MIT License. See the LICENSE file for more details.

## Support

- 📖 [Documentation](https://oversizedev.github.io/OversizeCore)
- 🐛 [Issue Tracker](https://github.com/oversizedev/OversizeCore/issues)
- 💬 [Discussions](https://github.com/oversizedev/OversizeCore/discussions)
