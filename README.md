# Mana Gramam — Village App 🌾

**Mana Gramam (మన గ్రామం)** — *Your Digital Village • Stronger Tomorrow*

A Flutter app for Indian villages — connecting villagers to agriculture, healthcare, panchayat services, jobs, education, government schemes, marketplace, local businesses, emergency help, and village maps in **English + Telugu**.

Built with Flutter + Material 3, offline-first demo auth, and a custom Mana design system.

---

## ✨ Features

### 🏠 Home (Screen 05 - Crown Jewel)
- Greeting header with logo, village switcher, notifications, profile
- Search bar + Telugu/English Voice Assistant trigger
- Village hero showcase (photo/video overlay)
- Important Panchayat notice card with details modal
- 8 service cards with real imagery
- Emergency Help 24/7 (Ambulance 108, Police 100, Fire 101, PHC Doctor)
- Nearby Places map preview
- 5-item bottom nav with central `+` Quick Actions modal

### 🛎️ 8 Village Services
1. **Agriculture** — weather, market prices, crops
2. **Healthcare** — doctors, PHC, health camps
3. **Panchayat** — problem reporting (water, streetlight, road, sanitation)
4. **Jobs** — farm workers, drivers, electricians, post jobs
5. **Education** — skills, scholarships, exams
6. **Govt Schemes** — PM Kisan, Rythu Bandhu, welfare
7. **Marketplace** — buy/sell crops, seeds, rent equipment
8. **Local Businesses** — kirana, electricals, workshops

### 🏘️ Our Village
- 12-place gallery grid: Fields, Rice Mill, Panchayat, School, Hospital, Temple, Petrol Bunk, Shops, Bus Stop, Streets, Animals, Lake
- Full `VillageGalleryScreen` + `VillageMapScreen`

### 👤 Auth & Onboarding
- Splash → Language Selection (English / Telugu) → Village Selection → Login / Signup / Forgot Password
- Lightweight local offline `AuthService` (no backend needed for demo)
- Profile + Settings + Notifications + Admin Dashboard

### 🎙️ Extras
- Voice Assistant screen (Telugu + English)
- Bilingual UI (`isTelugu` flag throughout) with Inter + Anek Telugu via `google_fonts`
- Custom theme: `lib/theme/mana_gramam_theme.dart` (`ManaColors`, `ManaText`, `manaPageRoute`)
- Animations: `FadeSlideIn`, `ServicePageScaffold`, `AuthTextField`

---

## 📁 Project Structure

```
lib/
  main.dart                    # ManaGramamApp entry
  models/service_item.dart
  services/auth_service.dart   # offline demo auth
  theme/mana_gramam_theme.dart # colors, text, routes
  utils/app_typography.dart
  widgets/
    auth_text_field.dart
    fade_slide_in.dart
    service_page_scaffold.dart
  screens/
    new_splash_screen.dart, splash_screen.dart
    language_selection_screen.dart, village_selection_screen.dart
    login_screen.dart, signup_screen.dart, forgot_password_screen.dart
    new_home_screen.dart, home_screen.dart
    agriculture_screen.dart, healthcare_screen.dart, panchayat_screen.dart
    jobs_screen.dart, education_screen.dart, schemes_screen.dart
    marketplace_screen.dart, businesses_screen.dart
    village_map_screen.dart, village_gallery_screen.dart
    voice_assistant_screen.dart, notifications_screen.dart
    profile_screen.dart, settings_screen.dart, admin_dashboard_screen.dart
    service_page.dart
assets/images/                # village_bg, services, gallery, logo, avatar
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.12.2` (stable 3.24+ recommended)
- Dart SDK bundled with Flutter
- Android Studio / VS Code + Flutter plugin
- Chrome for web / Android emulator / physical device

### Install
```bash
# clone
git clone https://github.com/maheshbanda2005-netizen/villageapp.git
cd villageapp

# if cloned inside mana_gramam folder, cd mana_gramam

# get packages
flutter pub get

# run
flutter run
# or specific device:
# flutter run -d chrome
# flutter run -d android
```

### Build
```bash
flutter build apk --release
flutter build appbundle --release
flutter build web --release
```

---

## 🔧 Configuration

- **App name:** `mana_gramam`, title `Mana Gramam`
- **Fonts:** `google_fonts` (Inter + Anek Telugu), `allowRuntimeFetching = true`
- **Assets:** declared in `pubspec.yaml`:
  ```yaml
  assets:
    - assets/images/
  ```
- **Auth:** demo-only in-memory. To add Firebase/Supabase, replace `AuthService` with real backend and persist with `shared_preferences` / `flutter_secure_storage`.

---

## 🧪 Test / Analyze

```bash
flutter analyze
flutter test
flutter pub outdated
```

---

## 🗺️ Roadmap
- [ ] Real backend (Firebase / Supabase) + OTP login
- [ ] Telugu voice STT/TTS integration
- [ ] Maps (google_maps_flutter / flutter_map) + GPS
- [ ] Push notifications (FCM)
- [ ] Direct dialer (`url_launcher: tel:`) for emergency numbers
- [ ] Admin panel with Firestore + image upload
- [ ] Offline caching + market price API + weather API

---

## 🤝 Contributing
1. Fork the repo
2. Create branch: `git checkout -b feature/my-feature`
3. Commit: `git commit -m "Add my feature"`
4. Push + open PR

---

## 📄 License
No license specified yet — add `MIT` / `Apache-2.0` if you want open source. For now all rights reserved to the author.

## 👨‍💻 Author
**Mahesh Banda** — https://github.com/maheshbanda2005-netizen/villageapp

Made for villages ❤️🇮🇳
