# QuickNotes - Modern Note-Taking App

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10%2B-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-informational)](https://flutter.dev/docs/get-started/supported-platforms)

A beautifully designed, feature-rich Flutter note-taking application with modern UI/UX, advanced filtering, and professional features.

[Installation](#-getting-started) • [Features](#-features) • [Architecture](#-architecture) • [Contributing](#-contributing)

</div>

---

## ✨ Features

### Core Functionality
- ✅ Create, edit, and delete notes with rich metadata
- 🎨 Choose from 6 beautiful note colors
- 🏷️ Organize notes with 5 categories (Personal, Work, Ideas, Urgent, Other)
- 🔖 Add custom tags to notes
- ❤️ Mark notes as favorites for quick access
- 🔍 Smart search across titles, content, and tags
- 🔄 Sort notes by Recent, Oldest, or Alphabetical order

### Modern Design
- 🎭 Material 3 Design System
- 🌈 Professional color palette with semantic colors
- 📱 Fully responsive and adaptive layouts
- ✨ Smooth animations and transitions
- 🎯 Glassmorphism design elements
- 📊 Masonry grid layout for notes

### User Experience
- 📝 Separate title and content fields
- ⏰ Smart date formatting ("5m ago", "Yesterday", etc.)
- 🎛️ Advanced filtering with category chips
- 💾 Undo functionality for deleted notes
- 🚀 Empty state with helpful guidance
- 🎨 Dynamic text colors based on background

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.1 or higher) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (3.10.1 or higher) - Comes with Flutter
- A code editor (VS Code, Android Studio, or similar)
- Git

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/yourusername/quicknotes.git
cd quicknotes
```

2. **Verify Flutter setup**:
```bash
flutter doctor
```

3. **Get dependencies**:
```bash
flutter pub get
```

4. **Run the app** on connected device or emulator:
```bash
flutter run
```

### Platform-Specific Setup

#### Android
- Requires Android SDK 21 or higher
- Android Studio or command-line tools installed
```bash
flutter run -d android
```

#### iOS
- Requires macOS and Xcode
- iOS 11.0 or higher
```bash
flutter run -d ios
```

#### Web
```bash
flutter run -d chrome
```

#### Windows/macOS/Linux
```bash
flutter run -d windows
# or
flutter run -d macos
# or
flutter run -d linux
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── note.dart            # Note data model with NoteCategory enum
├── providers/
│   └── note_provider.dart   # State management with Provider
├── screens/
│   ├── home_screen.dart     # Main screen with grid and filters
│   └── note_edit_screen.dart # Note creation/editing screen
├── theme/
│   └── theme.dart           # Material 3 theme configuration
└── widgets/
    ├── note_card.dart       # Individual note card widget
    ├── color_picker.dart    # Color selection widget
    ├── category_picker.dart # Category filter widget
    ├── empty_state.dart     # Empty state widget
    └── animated_fab.dart    # Animated FAB widget
```

## 🎨 Design System

### Color Palette
- **Primary**: #5B5E7E (Professional Purple)
- **Accent**: #FF6B6B (Vibrant Red)
- **Success**: #51CF66 (Green)
- **Background**: #FAFAFC (Light Gray)

### Typography
- **Font**: Inter (Google Fonts)
- **Display**: 32px Bold
- **Headlines**: 22px Semi-Bold
- **Body**: 16px Regular
- **Labels**: 12px Semi-Bold

### Components
- Rounded corners: 12-16px
- Spacing: 16px standard
- Shadow elevation: Multi-layer
- Grid: 2-column masonry

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.0.5                      # Efficient state management
  
  # UI & Styling
  google_fonts: ^6.1.0                  # Beautiful typography
  flutter_staggered_grid_view: ^0.7.0   # Masonry grid layout
  animations: ^2.0.11                   # Smooth transitions
  flutter_animation_progress_bar: ^2.3.1 # Progress animations
  gap: ^3.0.1                           # Spacing utility
  cupertino_icons: ^1.0.8              # iOS-style icons
  
  # Data & Storage
  intl: ^0.19.0                         # Internationalization & date formatting
  uuid: ^4.0.0                          # Unique ID generation
  shared_preferences: ^2.2.2            # Local data persistence
```

## 🔧 Customization

### Change App Colors
Edit `lib/theme/theme.dart`:
```dart
static const Color primaryColor = Color(0xFF5B5E7E);
static const Color accentColor = Color(0xFFFF6B6B);
```

### Add More Categories
Edit `lib/models/note.dart`:
```dart
enum NoteCategory { personal, work, ideas, urgent, other, custom }
```

### Modify Note Colors
Edit `lib/widgets/color_picker.dart`:
```dart
final List<Color> noteColors = [
  const Color(0xFFFFCBE1),
  // Add more colors here
];
```

## 🏗️ Architecture

### State Management
Uses **Provider pattern** for efficient state management:
- `NoteProvider` manages all note operations
- `Consumer` widgets rebuild only affected parts
- Getters provide filtered and sorted note lists
- Separates business logic from UI

### Responsive Design
- `CustomScrollView` with `SliverAppBar` for sticky search bar
- `SliverMasonryGrid` for responsive, multi-column note layout
- Adaptive spacing and sizing based on screen dimensions
- Platform-specific design considerations

### Animations & Interactions
- Scale animation for favorite heart icon interactions
- Smooth color transitions in note cards
- FAB (Floating Action Button) scale animation on tap
- Transition animations between screens

### Search & Filter System
- Real-time filtering as user types in search box
- Multi-criteria search (title, content, tags)
- Category-based filtering with interactive chips
- Favorites-only toggle for quick access
- Sort options: Recent, Oldest, Alphabetical

## 🎯 Code Structure Best Practices

- **Separation of Concerns**: Models, Providers, Screens, and Widgets are clearly separated
- **Reusable Components**: Custom widgets are built to be reusable and configurable
- **Type Safety**: Full type annotations throughout the codebase
- **Documentation**: Comprehensive comments on complex logic
- **Error Handling**: Graceful error handling and user feedback

## 📱 Supported Platforms

| Platform | Status | Min Version |
|----------|--------|------------|
| Android | ✅ Supported | 6.0 (API 21) |
| iOS | ✅ Supported | 11.0+ |
| Web | ✅ Supported | Chrome/Firefox |
| Windows | ✅ Supported | 10+ |
| macOS | ✅ Supported | 10.11+ |
| Linux | ✅ Supported | GTK 3.0+ |

## 🛠️ Building for Production

### Android
```bash
flutter build apk --release
# or for App Bundle (recommended)
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows/macOS/Linux
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🚧 Future Enhancements

- [ ] Cloud sync with Firebase
- [ ] Dark mode support
- [ ] Note sharing functionality
- [ ] Rich text editor with formatting
- [ ] Image attachments
- [ ] Voice notes
- [ ] Collaborative editing
- [ ] Offline-first architecture
- [ ] Push notifications for reminders
- [ ] Export notes to PDF/Markdown
- [ ] Multi-language support (i18n)
- [ ] Theme customization

## 📋 Roadmap

### Version 1.1.0
- Dark mode theme
- Enhanced search with filters
- Note export functionality

### Version 1.2.0
- Cloud synchronization
- Collaborative notes
- Rich text support

### Version 2.0.0
- AI-powered suggestions
- Advanced analytics
- Team workspace features

## 🐛 Troubleshooting

### Build Issues
If you encounter build issues, try:
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Platform-Specific Issues

**iOS Build Fails:**
```bash
cd ios
rm -rf Pods
cd ..
flutter clean
flutter pub get
```

**Android Build Fails:**
```bash
flutter clean
flutter pub get
./gradlew clean
flutter build apk
```

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [Provider Package](https://pub.dev/packages/provider)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style Guidelines
- Follow Dart style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure code is properly formatted with `dart format`
- Write unit tests for new features

### Commit Message Format
```
<type>: <subject>
<body>
<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:
```
feat: Add dark mode support
Added Material 3 dark theme and toggle in settings
Closes #42
```

## 💬 Discussion & Support

- **Issues**: [GitHub Issues](../../issues) - Report bugs or request features
- **Discussions**: [GitHub Discussions](../../discussions) - General questions and ideas
- **Email**: [Your Email] - Direct inquiries

## 👨‍💻 Author

**Your Name** - [@bagatata05](https://x.com/bagatata05)

- GitHub: [@bagatata05](https://github.com/bagatata05)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for design inspiration
- All contributors and users who report issues

---

<div align="center">

Made with ❤️ using [Flutter](https://flutter.dev)

**[⬆ back to top](#quicknotes---modern-note-taking-app)**

</div>
