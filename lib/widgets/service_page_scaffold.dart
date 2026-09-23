import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import 'fade_slide_in.dart';

class ServiceAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;

  const ServiceAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.accent = ManaColors.navy,
  });
}

class ServicePageScaffold extends StatelessWidget {
  final String title;
  final String heroLabel;
  final IconData heroIcon;
  final String? imageAsset;
  final List<ServiceAction> actions;

  const ServicePageScaffold({
    super.key,
    required this.title,
    required this.heroLabel,
    required this.heroIcon,
    required this.actions,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ManaText(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          FadeSlideIn(
            child: ManaUI.hero(heroLabel, heroIcon, h: 150, imageAsset: imageAsset),
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            delayMs: 80,
            child: ManaUI.title('Explore'),
          ),
          ...List.generate(actions.length, (i) {
            final a = actions[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FadeSlideIn(
                delayMs: 100 + (i * 40),
                child: ManaUI.serviceRow(
                  title: a.title,
                  subtitle: a.subtitle,
                  icon: a.icon,
                  accent: a.accent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: ManaText('${a.title} — coming soon')),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
