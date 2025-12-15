# Icon Installation Instructions

## Steps to Add Your Custom App Icon

### 1. Prepare Your Icon File
- **File Name**: `icon.png`
- **Size**: 1024x1024 pixels (minimum)
- **Format**: PNG with transparent background
- **Location**: Place it in this folder (`assets/icons/`)

### 2. Generate App Icons
Once you've placed your `icon.png` file here, run:

```bash
flutter pub get
flutter pub run flutter_launcher_icons:main
```

This will automatically generate:
- ✅ Android launcher icons (all sizes)
- ✅ iOS app icon
- ✅ Web app icon

### 3. Build and Install

**For Android APK:**
```bash
flutter build apk --release
```

**For iOS:**
```bash
flutter build ios
```

**For Testing (Debug):**
```bash
flutter run
```

### 4. Verify
The app icon should appear on your device home screen when you install the app.

## File Structure
```
quicknotes/
├── assets/
│   └── icons/
│       └── icon.png          ← PUT YOUR ICON FILE HERE
├── pubspec.yaml              ← Already configured
└── ...
```

## Icon Requirements
- **Minimum Size**: 1024x1024 pixels
- **Format**: PNG
- **Background**: Transparent or solid (will be handled by generator)
- **Content**: Keep important elements centered within 512x512 area
- **No Rounded Corners**: The system will handle corner radius

## Troubleshooting

If icons don't update after running the command:
1. Delete build folder: `flutter clean`
2. Regenerate: `flutter pub run flutter_launcher_icons:main`
3. Rebuild: `flutter run` or `flutter build apk --release`

## Tips for Best Results
- Use a professional design tool (Figma, Adobe XD, etc.)
- Ensure your icon is recognizable at small sizes
- Test on both Android and iOS if possible
- Keep padding/margin around your design
