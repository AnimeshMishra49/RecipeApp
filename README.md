# ColesCodingTest - 🍽️ Recipe App

A modular, reusable, SwiftUI-based recipe browsing app built with orientation support, caching, unit testing, and a shared design system.

---
## 📦 Project Structure

This repository is a **monorepo** containing:

- `RecipeApp`: Main iOS application using SwiftUI
- `RecipeKit`: Core models, services, and business logic (Modular Swift Package)
- `DesignSystem`: Shared design tokens, styles, colors (Modular Swift Package)
- `RecipeUI`: Reusable SwiftUI views and components (Modular Swift Package)

## 🛠️ Dev Setup

### Tools Used
- Xcode 16.3 
- Minium iOS Version iOS 17
- Swift Package Manager (SPM)

### Run Instructions
1. Clone the repo
2. Open `.xcodeproj` from `Recipes` > `RecipeApp.xcodeproj`.
3. Run on a simulator or device
4. Clear the Derived Data & reset Package Caches in case of SPM issue.

---

## 🧩 Features

### ✅ SwiftUI Architecture
- MVVM + ViewState driven UI updates
- Modular components (e.g., `AsyncImageView`, `HeaderSectionView`, `BulletListView`, `HorizontalTileScrollView`, `SummaryRowView`, etc.)
- Orientation handling with `OrientationInfo` (portrait/landscape adaptive layout)

### 🎨 Design System
- Centralized typography, colors, spacing, corner radius
- Fully responsive layouts adapting to orientation
  
### ✅ State Management
- Centralized `RecipeViewModel` with `@Published` properties
- `ViewState` enum to manage `loading`, `loaded`, and `failed` states

### 📸 Image Caching
- Custom `ImageCache` with in-memory
- Async image loading with graceful placeholder support

### 🔄 Refresh & Selection
- Pull to refresh using `.refreshable`
- Highlighted selection and border styles for selected recipes

### ✅ Accessibility & Responsiveness
- VoiceOver support for images and text
- Dynamic layout and device orientation

### ✅ Developer Previews
- Preview support for both portrait and landscape views
- Multiple states (empty, loading, error, success) previewable
- All the views preview added with mock data

### 🧪 Testing
- ViewModel unit tests using `Testing` module
- Mocks and fakes included for isolated testing
- Added buisenss logic test cases in `RecipeKit`


| Code Coverage |
|---------------|
| <img src="https://github.com/user-attachments/assets/7cb0d004-7b54-45c2-bc76-cd25343b16f1" width="1000"/> |

---

### App ScreenShots & ScreenRecordings

| Portrait 1 | Portrait 2 |
|------------|------------|
| <img src="https://github.com/user-attachments/assets/7d2d0b1a-8af5-4cfa-8353-305b1917f2e0" width="250"/> | <img src="https://github.com/user-attachments/assets/562dea04-20cc-4d2d-a708-650a1f49e63f" width="250"/> |

| Landscape View |
|----------------|
| <img src="https://github.com/user-attachments/assets/01f9a56f-2401-46dc-9dbf-f45970b9d1df" width="500"/> |

https://github.com/user-attachments/assets/acff22fc-710d-48c3-b8e5-583201a4bfaf

