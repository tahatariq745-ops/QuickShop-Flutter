# QuickShop - Mobile Computing Assignment 1

A simple Flutter & Dart shopping mobile application developed from the supplied
Lab 9 **Campus Hub** Flutter project and adapted to the QuickShop assignment.

## Run on Android emulator (VS Code / Android Studio)

1. Extract the ZIP and **open the inner `QuickShop` folder** (the one with `pubspec.yaml`).
2. Open a terminal in that folder.
3. Run `flutter doctor` and make sure Flutter and an Android emulator are ready.
4. Run `flutter pub get` to restore the `webview_flutter` dependency.
5. Start an Android emulator and run `flutter run`.

If a platform's generated files need refreshing for a different installed Flutter
version, run `flutter create .` from the project root, followed by `flutter pub get`.
(The Dart `lib/` source files will remain.)

## Screens and assignment coverage

| Requirement | Implementation |
|---|---|
| Splash | Shopping-bag icon, welcome text, 2-second automatic navigation |
| Home + Drawer | AppBar, five navigation destinations, product cards with prices |
| Details | Product image/icon, name, description, price, Add to Cart with SnackBar |
| Add Product | Required fields, positive numeric price, live in-memory list, inputs reset after submission |
| Gestures | `onTap`, `onDoubleTap`, `onLongPress` on product cards; horizontal and vertical drag on dedicated demonstration areas |
| Animation | Tap the shopping-bag block in Gestures & Animation to change size, colour and corners using `AnimatedContainer` |
| Counter | Increment/decrement in Gestures & Animation using `setState()` |
| WebView | `webview_flutter` opens `https://example.com/` inside the app; Android INTERNET permission set |

All products are stored in `ShopStore.products`, a normal **Dart List** in memory.
Adding products/favourites/cart state uses Flutter's built-in `ChangeNotifier`
to refresh already-open screens. The assignment's counter uses `setState()`.
No Firebase, API, SQL, SQLite, database or persistence is used.

## Quick demonstration sequence

1. Launch the app: take a screenshot of the splash screen within 2 seconds.
2. Open Home: see the initial products; tap one and use **Add to Cart**.
3. Double-tap a card: it shows a heart. Long-press a card: SnackBar message.
4. Use drawer > **Add Product**. Test empty fields and bad price first; then
   enter valid data. Confirm input fields clear and the new product is first on Home.
5. Use drawer > **Gestures & Animation**. Swipe in each area, tap the animated
   block, and use both counter buttons.
6. Use drawer > **WebView**. Confirm the webpage appears inside the app.
7. Run `flutter test` and optionally `flutter analyze`.

## Assignment submission

- Push this **whole project** to a GitHub repository (not just the `lib` folder).
- Add your GitHub repository link, original emulator screenshots, personal
  understanding, and **actual** obstacles encountered to the Word report.
- A ready-to-edit Word template is included in `docs/QuickShop_Assignment_Report_Template.docx`.
- Submit both the complete Flutter project and your finished report.

### Git commands (run from the QuickShop folder)

```bash
git init
git add .
git commit -m "Complete QuickShop assignment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/quickshop.git
git push -u origin main
```

Replace the example URL with the actual empty GitHub repository you create.
If you already have a Git repository, follow your own branch/remote workflow.

## Note about verification

The source was reviewed structurally before packaging, but the current build
environment does **not** include the Flutter SDK or Android emulator. Run
`flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` locally
and resolve any version-specific issues before submitting.
