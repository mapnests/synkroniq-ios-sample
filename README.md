# synkroniq-ios-sdk-sample

A runnable SwiftUI reference app that demonstrates every public API of **synkroniqSDK**.

## Requirements

- iOS 15.0+
- Swift 5.7+
- Xcode 14+

## Getting Started

1. Open `SDKSample.xcodeproj` in Xcode.
2. In `SDKSample/SDKSampleApp.swift`, replace `"YOUR_API_KEY_HERE"` with your actual API key:
   ```swift
   SynkroniqSDK.shared.initialize(apiKey: "YOUR_API_KEY_HERE", platform: "ios")
   ```
3. Select a simulator or device target and press **Run** (⌘R).

> **Note:** `Frameworks/synkroniqSDK.xcframework` is pre-built and included in the repository.

## API Coverage

| Tab | Section | Method |
|---|---|---|
| Categories | getServiceCategories | `getServiceCategories(requestBody:completion:)` |
| Categories | getServiceCategoryById | `getServiceCategoryById(categoryId:requestBody:completion:)` |
| Categories | searchServiceCategories | `searchServiceCategories(requestBody:completion:)` |
| Tickets | getTickets | `getTickets(requestBody:completion:)` |
| Tickets | createTicket | `createTicket(requestBody:completion:)` |
| Tickets | getTicketStates | `getTicketStates(requestBody:completion:)` |
| Articles | getTicketArticles | `getTicketArticles(requestBody:completion:)` |
| Articles | addTicketArticle | `addTicketArticle(requestBody:completion:)` |

Each section shows the method name in monospaced text, accepts the required inputs, and displays the raw JSON response (or error message) after calling **Call**.

## Framework Location

The pre-built xcframework is at `Frameworks/synkroniqSDK.xcframework` and is embedded automatically by the Xcode project.

## Full SDK Documentation

See [`../synkroniq-ios-sdk/README.md`](../synkroniq-ios-sdk/README.md) for complete SDK documentation.
