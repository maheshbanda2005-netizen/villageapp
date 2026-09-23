import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mana_gramam/utils/app_typography.dart';

export 'package:mana_gramam/utils/app_typography.dart' show ManaText, AppTypography;

/// Master Brand palette strictly aligned with Mana Gramam specifications:
/// Deep Navy: #172554, Royal Purple: #6D28D9, Warm Orange: #F59E0B,
/// Information Blue: #2563EB, Emergency Red: #DC2626, Off-White: #F8FAFC, Dark Text: #111827.
class ManaColors {
  static const navy = Color(0xFF172554);
  static const navySoft = Color(0xFF1E293B);
  static const purple = Color(0xFF6D28D9);
  static const purpleSoft = Color(0xFFEDE9FE);
  static const orange = Color(0xFFF59E0B);
  static const orangeSoft = Color(0xFFFEF3C7);
  static const blue = Color(0xFF2563EB);
  static const blueSoft = Color(0xFFDBEAFE);
  static const danger = Color(0xFFDC2626);
  static const red = danger;
  static const bg = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const warningBg = Color(0xFFFFFBEB);
  static const warningBorder = Color(0xFFFCD34D);

  // Aliases for compatibility
  static const gold = orange;
  static const goldSoft = orangeSoft;
  static const sky = blue;
  static const coral = Color(0xFFEA580C);
  static const leaf = Color(0xFF15803D); // natural crop/leaf green only inside photos
  static const teal = Color(0xFF0F766E);
}

class ManaTheme {
  /// Base theme uses Inter. Telugu strings use Anek Telugu via [ManaText].
  static ThemeData data({bool isTelugu = false}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: ManaColors.purple,
      primary: ManaColors.purple,
      secondary: ManaColors.navy,
      tertiary: ManaColors.orange,
      surface: ManaColors.surface,
      brightness: Brightness.light,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: ManaColors.bg,
      textTheme: textTheme.apply(
        bodyColor: ManaColors.text,
        displayColor: ManaColors.navy,
      ),
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: ManaColors.surface,
        foregroundColor: ManaColors.navy,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.inter(
          const TextStyle(
            color: ManaColors.navy,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: ManaColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ManaColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ManaColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ManaColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ManaColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ManaColors.navy, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ManaColors.danger),
        ),
        hintStyle: AppTypography.inter(
          const TextStyle(color: ManaColors.muted, fontSize: 15),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ManaColors.purple,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: AppTypography.inter(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ManaColors.navy,
          minimumSize: const Size(64, 48),
          side: const BorderSide(color: ManaColors.border, width: 1.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: AppTypography.inter(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ManaColors.navy,
          textStyle: AppTypography.inter(
            const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ManaColors.surface,
        selectedItemColor: ManaColors.navy,
        unselectedItemColor: ManaColors.muted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.inter(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        unselectedLabelStyle: AppTypography.inter(
          const TextStyle(fontSize: 12),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ManaColors.navy,
        contentTextStyle: AppTypography.inter(
          const TextStyle(color: Colors.white, fontSize: 14),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Dark theme tailored for Mana Gramam:
  /// Deep Navy background (#0A0F1D / #172554), Dark Purple surfaces (#1E1635),
  /// White text, soft purple highlights, orange accents. Zero green brand color.
  static ThemeData darkData() {
    const darkBg = Color(0xFF0B1120);
    const darkSurface = Color(0xFF161F38);
    const darkCard = Color(0xFF1E294B);
    const darkBorder = Color(0xFF28355E);

    final scheme = ColorScheme.fromSeed(
      seedColor: ManaColors.purple,
      primary: ManaColors.purpleSoft,
      secondary: ManaColors.orange,
      surface: darkSurface,
      brightness: Brightness.dark,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme, brightness: Brightness.dark);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      cardColor: darkCard,
      textTheme: textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorder),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: Color(0xFFA78BFA),
        unselectedItemColor: Color(0xFF94A3B8),
      ),
    );
  }
}

class ManaUI {
  static InputDecoration search(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.forText(
          hint,
          const TextStyle(color: ManaColors.muted, fontSize: 15),
        ),
        prefixIcon: const Icon(Icons.search_rounded, color: ManaColors.muted),
        filled: true,
        fillColor: ManaColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ManaColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ManaColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ManaColors.navy, width: 1.4),
          borderRadius: BorderRadius.circular(14),
        ),
      );

  static Widget hero(String label, IconData icon, {double h = 160, String? imageAsset}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageAsset != null)
              Image.asset(imageAsset, fit: BoxFit.cover)
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ManaColors.navy, ManaColors.navySoft],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ManaColors.navy.withValues(alpha: 0.55),
                    ManaColors.navy.withValues(alpha: 0.25),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  ManaText(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget button(String label, VoidCallback? onPressed, {IconData? icon}) {
    final child = ManaText(label);
    if (icon == null) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(onPressed: onPressed, child: child),
      );
    }
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: child,
      ),
    );
  }

  static Widget title(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ManaText(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: ManaColors.navy,
            letterSpacing: -0.2,
          ),
        ),
      );

  static Widget serviceRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accent,
    VoidCallback? onTap,
  }) {
    return Material(
      color: ManaColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ManaColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ManaText(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: ManaColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ManaText(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: ManaColors.muted),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: ManaColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class ManaFonts {
  /// Font from text content (not app language).
  static TextStyle getTextStyle(bool isTelugu, TextStyle baseStyle, {String? text}) {
    return AppTypography.apply(isTelugu, baseStyle, text: text);
  }

  static TextStyle of(String text, [TextStyle? base]) =>
      AppTypography.forText(text, base);
}
