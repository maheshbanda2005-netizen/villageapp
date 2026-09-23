import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'village_selection_screen.dart';

/// Screen 02: LANGUAGE SELECTION
/// Allows rural users to choose their language (English, తెలుగు, हिन्दी, தமிழ், ಕನ್ನಡ)
/// with large readable cards, royal purple selected borders, and simple navigation.
class LanguageSelectionScreen extends StatefulWidget {
  final bool showBack;
  const LanguageSelectionScreen({super.key, this.showBack = false});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'తెలుగు';
  bool _saving = false;

  final List<Map<String, String>> _languages = [
    {'id': 'English', 'native': 'English', 'sub': 'Continue in English', 'isTe': 'false'},
    {'id': 'తెలుగు', 'native': 'తెలుగు', 'sub': 'తెలుగులో కొనసాగించండి', 'isTe': 'true'},
    {'id': 'हिन्दी', 'native': 'हिन्दी', 'sub': 'हिन्दी में जारी रखें', 'isTe': 'false'},
    {'id': 'தமிழ்', 'native': 'தமிழ்', 'sub': 'தமிழில் தொடரவும்', 'isTe': 'false'},
    {'id': 'ಕನ್ನಡ', 'native': 'ಕನ್ನಡ', 'sub': 'ಕನ್ನಡದಲ್ಲಿ ಮುಂದುವರಿಯಿರಿ', 'isTe': 'false'},
  ];

  Future<void> _continue() async {
    setState(() => _saving = true);
    final isTelugu = _selectedLanguage == 'తెలుగు';
    await AuthService.instance.setLanguage(isTelugu: isTelugu);
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      manaPageRoute(VillageSelectionScreen(isTelugu: isTelugu)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: ManaColors.navy,
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeSlideIn(
                child: Row(
                  children: [
                    Hero(
                      tag: 'mana_logo',
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/mana_gramam_logo.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 44,
                            height: 44,
                            color: ManaColors.purple,
                            child: const Icon(Icons.cottage_rounded, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ManaText(
                          'Mana Gramam',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: ManaColors.navy,
                          ),
                        ),
                        Text(
                          'Smart Village • Stronger Tomorrow',
                          style: TextStyle(fontSize: 11, color: ManaColors.muted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const FadeSlideIn(
                delayMs: 60,
                child: ManaText(
                  'Choose Your Language',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: ManaColors.navy,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const FadeSlideIn(
                delayMs: 90,
                child: ManaText(
                  'మీ ప్రాధాన్యత భాషను ఎంచుకోండి • Select your preferred language',
                  style: TextStyle(
                    fontSize: 14,
                    color: ManaColors.muted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, i) {
                    final lang = _languages[i];
                    final isSelected = _selectedLanguage == lang['id'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FadeSlideIn(
                        delayMs: 120 + (i * 30),
                        child: InkWell(
                          onTap: () => setState(() => _selectedLanguage = lang['id']!),
                          borderRadius: BorderRadius.circular(18),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? ManaColors.purpleSoft.withValues(alpha: 0.45) : ManaColors.surface,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected ? ManaColors.purple : ManaColors.border,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ManaText(
                                        lang['native']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                                          color: isSelected ? ManaColors.purple : ManaColors.navy,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        lang['sub']!,
                                        style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle_rounded, color: ManaColors.purple, size: 24)
                                else
                                  const Icon(Icons.radio_button_off_rounded, color: ManaColors.muted, size: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Center(
                child: Text(
                  'You can change your language anytime in Settings.',
                  style: TextStyle(fontSize: 12, color: ManaColors.muted),
                ),
              ),
              const SizedBox(height: 12),
              FadeSlideIn(
                delayMs: 260,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _saving ? null : _continue,
                    style: FilledButton.styleFrom(
                      backgroundColor: ManaColors.purple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ManaText(
                          _saving ? 'Please wait…' : 'Continue',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
