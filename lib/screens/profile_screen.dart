import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'admin_dashboard_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'village_selection_screen.dart';
import 'voice_assistant_screen.dart';

/// Screen 06: USER PROFILE
/// Complete profile according to Master Prompt with verified status, village switcher,
/// activity counters, services, settings navigation, and Panchayat admin access.
class ProfileScreen extends StatelessWidget {
  final bool isTelugu;
  final AuthUser? user;
  final VoidCallback? onLogout;
  final VoidCallback? onChangeLanguage;
  final bool showBack;

  const ProfileScreen({
    super.key,
    this.isTelugu = false,
    this.user,
    this.onLogout,
    this.onChangeLanguage,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = user?.name.isNotEmpty == true
        ? user!.name
        : (isTelugu ? 'రాహుల్ కుమార్' : 'Rahul Kumar');
    final village = user?.village.isNotEmpty == true
        ? user!.village
        : 'Kothapally';
    final villageLabel = isTelugu ? '$village గ్రామం' : '$village Village';

    return Scaffold(
      backgroundColor: ManaColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            // Top Bar
            FadeSlideIn(
              child: Row(
                children: [
                  if (showBack)
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      color: ManaColors.navy,
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: ManaText(
                      isTelugu ? 'నా ప్రొఫైల్' : 'My Profile',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: ManaColors.navy,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        manaPageRoute(SettingsScreen(isTelugu: isTelugu)),
                      );
                    },
                    icon: const Icon(Icons.settings_outlined, color: ManaColors.navy),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Profile Header Card
            FadeSlideIn(
              delayMs: 40,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ManaColors.purple, width: 2.5),
                    ),
                    child: const CircleAvatar(
                      radius: 46,
                      backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
                      backgroundColor: ManaColors.border,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ManaText(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: ManaColors.navy,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.blue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, size: 15, color: ManaColors.blue),
                        const SizedBox(width: 5),
                        ManaText(
                          isTelugu ? 'ధృవీకరించబడిన పౌరుడు' : '✓ Verified User',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ManaColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        manaPageRoute(VillageSelectionScreen(isTelugu: isTelugu, fromHome: true)),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_rounded, size: 16, color: ManaColors.purple),
                          const SizedBox(width: 4),
                          ManaText(
                            villageLabel,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ManaColors.navy,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.edit_outlined, size: 14, color: ManaColors.muted),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(isTelugu ? 'ప్రొఫైల్ ఎడిట్ చేయండి' : 'Edit profile opened')),
                      );
                    },
                    icon: const Icon(Icons.edit_rounded, size: 16, color: ManaColors.purple),
                    label: ManaText(
                      isTelugu ? 'ప్రొఫైల్ సవరించండి' : 'Edit Profile',
                      style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ManaColors.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SECTION: My Activity (5 Cards)
            FadeSlideIn(
              delayMs: 80,
              child: _SectionTitle(isTelugu ? 'నా కార్యకలాపాలు' : 'My Activity'),
            ),
            FadeSlideIn(
              delayMs: 100,
              child: _ActivityCard(
                items: [
                  _ActivityItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: isTelugu ? 'ఫిర్యాదులు' : 'Complaints',
                    count: 3,
                    accent: ManaColors.orange,
                  ),
                  _ActivityItem(
                    icon: Icons.work_outline_rounded,
                    title: isTelugu ? 'ఉద్యోగ దరఖాస్తులు' : 'Job Applications',
                    count: 2,
                    accent: ManaColors.purple,
                  ),
                  _ActivityItem(
                    icon: Icons.storefront_outlined,
                    title: isTelugu ? 'నా మార్కెట్ జాబితాలు' : 'My Listings',
                    count: 4,
                    accent: ManaColors.leaf,
                  ),
                  _ActivityItem(
                    icon: Icons.event_available_outlined,
                    title: isTelugu ? 'ఆరోగ్య అపాయింట్‌మెంట్లు' : 'Appointments',
                    count: 1,
                    accent: ManaColors.coral,
                  ),
                  _ActivityItem(
                    icon: Icons.bookmark_border_rounded,
                    title: isTelugu ? 'భద్రపరిచిన పథకాలు' : 'Saved Schemes',
                    count: 3,
                    accent: ManaColors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SECTION: My Services
            FadeSlideIn(
              delayMs: 140,
              child: _SectionTitle(isTelugu ? 'నా ప్రొఫైల్స్ & సేవలు' : 'My Services'),
            ),
            FadeSlideIn(
              delayMs: 160,
              child: Column(
                children: [
                  _ServiceTile(
                    title: isTelugu ? 'రైతు ప్రొఫైల్' : 'Farmer Profile',
                    subtitle: isTelugu ? 'పంట వివరాలు, భూమి సర్వే నంబర్లు' : 'Crops, 4.5 Acres, Rythu Bandhu active',
                    icon: Icons.agriculture_rounded,
                    accent: ManaColors.leaf,
                    onTap: () => _soon(context, isTelugu),
                  ),
                  const SizedBox(height: 10),
                  _ServiceTile(
                    title: isTelugu ? 'పని & నైపుణ్య ప్రొఫైల్' : 'Work Profile',
                    subtitle: isTelugu ? 'ట్రాక్టర్ డ్రైవింగ్, వ్యవసాయ నైపుణ్యాలు' : 'Tractor Driver, Farm Equipment Operator',
                    icon: Icons.badge_outlined,
                    accent: ManaColors.blue,
                    onTap: () => _soon(context, isTelugu),
                  ),
                  const SizedBox(height: 10),
                  _ServiceTile(
                    title: isTelugu ? 'వ్యాపార ప్రొఫైల్' : 'Business Profile',
                    subtitle: isTelugu ? 'స్థానిక కిరాణా లేదా సర్వీస్ షాప్' : 'Registered Village Merchant / Service Provider',
                    icon: Icons.storefront_rounded,
                    accent: ManaColors.purple,
                    onTap: () => _soon(context, isTelugu),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SECTION: Panchayat Staff / Admin Access
            FadeSlideIn(
              delayMs: 180,
              child: _SectionTitle(isTelugu ? 'గ్రామ పంచాయతీ పోర్టల్' : 'Panchayat Portal'),
            ),
            FadeSlideIn(
              delayMs: 190,
              child: Material(
                color: const Color(0xFFEDE9FE),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: ManaColors.purpleSoft),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ManaColors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 22),
                  ),
                  title: ManaText(
                    isTelugu ? 'పంచాయతీ అడ్మిన్ డాష్‌బోర్డ్' : 'Panchayat Admin Dashboard',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                  ),
                  subtitle: Text(
                    isTelugu ? 'సర్పంచ్, కార్యదర్శి మరియు సిబ్బంది లాగిన్' : 'Sarpanch, Secretary & Village Staff Console',
                    style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: ManaColors.purple),
                  onTap: () {
                    Navigator.push(
                      context,
                      manaPageRoute(AdminDashboardScreen(isTelugu: isTelugu)),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // SECTION: Settings (Master Prompt options)
            FadeSlideIn(
              delayMs: 200,
              child: _SectionTitle(isTelugu ? 'సెట్టింగ్‌లు' : 'Settings'),
            ),
            FadeSlideIn(
              delayMs: 220,
              child: _SettingsCard(
                children: [
                  _SettingsRow(
                    icon: Icons.language_rounded,
                    title: isTelugu ? 'భాష' : 'Language',
                    trailing: isTelugu ? 'తెలుగు' : 'English',
                    onTap: onChangeLanguage ?? () {},
                  ),
                  _SettingsRow(
                    icon: Icons.notifications_none_rounded,
                    title: isTelugu ? 'నోటిఫికేషన్లు' : 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        manaPageRoute(NotificationsScreen(isTelugu: isTelugu)),
                      );
                    },
                  ),
                  _SettingsRow(
                    icon: Icons.record_voice_over_outlined,
                    title: isTelugu ? 'వాయిస్ అసిస్టెంట్' : 'Voice Assistant',
                    onTap: () {
                      Navigator.push(
                        context,
                        manaPageRoute(VoiceAssistantScreen(isTelugu: isTelugu)),
                      );
                    },
                  ),
                  _SettingsRow(
                    icon: Icons.dark_mode_outlined,
                    title: isTelugu ? 'డార్క్ మోడ్ & ప్రాప్యత' : 'Dark Mode & Appearance',
                    onTap: () {
                      Navigator.push(
                        context,
                        manaPageRoute(SettingsScreen(isTelugu: isTelugu)),
                      );
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),

            if (onLogout != null) ...[
              const SizedBox(height: 24),
              FadeSlideIn(
                delayMs: 260,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout_rounded, color: ManaColors.danger),
                    label: ManaText(
                      isTelugu ? 'లాగ్ అవుట్' : 'Log out',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: ManaColors.danger),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFFECACA)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _soon(BuildContext context, bool isTelugu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: ManaText(isTelugu ? 'త్వరలో అందుబాటులో' : 'Service details coming soon')),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ManaText(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: ManaColors.navy,
        ),
      ),
    );
  }
}

class _ActivityItem {
  final IconData icon;
  final String title;
  final int count;
  final Color accent;
  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.count,
    this.accent = ManaColors.purple,
  });
}

class _ActivityCard extends StatelessWidget {
  final List<_ActivityItem> items;
  const _ActivityCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManaColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: ManaColors.border),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: items[i].accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(items[i].icon, color: items[i].accent, size: 20),
              ),
              title: ManaText(
                items[i].title,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: ManaColors.navy),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: items[i].accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${items[i].count}',
                  style: TextStyle(fontWeight: FontWeight.w800, color: items[i].accent, fontSize: 13),
                ),
              ),
              onTap: () {},
            ),
            if (i < items.length - 1)
              const Divider(height: 1, indent: 56, color: ManaColors.border),
          ],
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  const _ServiceTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManaColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ManaColors.border),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: accent, size: 22),
        ),
        title: ManaText(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: ManaColors.navy),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: ManaColors.muted),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: ManaColors.muted),
        onTap: onTap,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManaColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: ManaColors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final bool showDivider;

  const _SettingsRow({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: ManaColors.navy, size: 22),
          title: ManaText(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: ManaColors.navy),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing != null) ...[
                Text(trailing!, style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(width: 6),
              ],
              const Icon(Icons.chevron_right_rounded, color: ManaColors.muted),
            ],
          ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(height: 1, indent: 56, color: ManaColors.border),
      ],
    );
  }
}
