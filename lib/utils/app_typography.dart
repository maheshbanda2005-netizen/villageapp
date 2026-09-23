import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Picks font from the *text content*:
/// - Telugu script → Anek Telugu
/// - Latin / English → Inter
/// Mixed strings get per-run fonts.
class AppTypography {
  static bool isTeluguChar(int codeUnit) =>
      codeUnit >= 0x0C00 && codeUnit <= 0x0C7F;

  static bool containsTelugu(String text) {
    for (final r in text.runes) {
      if (isTeluguChar(r)) return true;
    }
    return false;
  }

  static TextStyle inter([TextStyle? base]) => GoogleFonts.inter(
        textStyle: base,
        height: base?.height ?? 1.2,
      );

  static TextStyle anekTelugu([TextStyle? base]) => GoogleFonts.anekTelugu(
        textStyle: base,
        height: base?.height ?? 1.35,
      );

  /// Font for a whole string (Telugu if any Telugu letter, else Inter).
  static TextStyle forText(String text, [TextStyle? base]) {
    if (containsTelugu(text)) return anekTelugu(base);
    return inter(base);
  }

  /// Build styled spans so mixed English + Telugu each get the right font.
  static List<InlineSpan> spansFor(String text, TextStyle? base) {
    if (text.isEmpty) return [TextSpan(text: text, style: inter(base))];

    final spans = <InlineSpan>[];
    final buffer = StringBuffer();
    bool? currentTelugu;

    void flush() {
      if (buffer.isEmpty) return;
      final chunk = buffer.toString();
      buffer.clear();
      spans.add(
        TextSpan(
          text: chunk,
          style: currentTelugu == true ? anekTelugu(base) : inter(base),
        ),
      );
    }

    for (final rune in text.runes) {
      final telugu = isTeluguChar(rune);
      // Keep spaces/punctuation with the previous script when possible.
      final isMark = !(telugu ||
          (rune >= 0x41 && rune <= 0x5A) ||
          (rune >= 0x61 && rune <= 0x7A) ||
          (rune >= 0x30 && rune <= 0x39));

      if (currentTelugu == null) {
        currentTelugu = telugu;
        buffer.writeCharCode(rune);
        continue;
      }

      if (isMark || telugu == currentTelugu) {
        buffer.writeCharCode(rune);
      } else {
        flush();
        currentTelugu = telugu;
        buffer.writeCharCode(rune);
      }
    }
    flush();
    return spans;
  }

  /// Legacy helper — prefer [forText] with the actual string.
  static TextStyle font({
    required bool isTelugu,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    String? text,
  }) {
    final base = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height ?? (isTelugu ? 1.35 : 1.2),
      decoration: decoration,
    );
    if (text != null) return forText(text, base);
    // When no text is provided, still honor explicit script for old call sites.
    return isTelugu ? anekTelugu(base) : inter(base);
  }

  static TextStyle apply(bool isTelugu, TextStyle style, {String? text}) {
    if (text != null) return forText(text, style);
    return isTelugu ? anekTelugu(style) : inter(style);
  }
}

/// Text that auto-selects Inter or Anek Telugu from the string content.
class ManaText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;

  const ManaText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final base = DefaultTextStyle.of(context).style.merge(style);
    final hasTelugu = AppTypography.containsTelugu(data);
    final hasLatin = data.runes.any((r) =>
        (r >= 0x41 && r <= 0x5A) ||
        (r >= 0x61 && r <= 0x7A));

    // Mixed → rich text with per-script fonts; single script → one style.
    if (hasTelugu && hasLatin) {
      return Text.rich(
        TextSpan(children: AppTypography.spansFor(data, base)),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.clip,
        softWrap: softWrap,
      );
    }

    return Text(
      data,
      style: AppTypography.forText(data, base),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
