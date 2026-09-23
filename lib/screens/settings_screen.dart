import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';

/// Screen 19: SETTINGS & DARK MODE
/// User preferences, appearance modes (Deep Navy Dark Mode), accessibility font sizing,
/// data permissions, and village emergency directory.
class SettingsScreen extends StatefulWidget {
  final bool isTelugu;
  const SettingsScreen({super.key, this.isTelugu = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  double _fontSizeFactor = 1.0;
  bool _voiceAutoRead = true;
  bool _offlineMode = false;
  bool _locationPermission = true;
  bool _notificationsEnabled = true;
  bool _dataSaver = false;
  late bool _isTelugu;

  @override
  void initState() {
    super.initState();
    _isTelugu = widget.isTelugu;
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _darkMode ? const Color(0xFF161F38) : ManaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ManaText(
                  _isTelugu ? 'భాషను ఎంచుకోండి' : 'Select Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _darkMode ? Colors.white : ManaColors.navy,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: Text(
                    'English',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _darkMode ? Colors.white : ManaColors.text,
                    ),
                  ),
                  trailing: !_isTelugu ? const Icon(Icons.check_circle_rounded, color: ManaColors.purple) : null,
                  onTap: () {
                    setState(() => _isTelugu = false);
                    AuthService.instance.setLanguage(isTelugu: false);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'తెలుగు (Telugu)',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _darkMode ? Colors.white : ManaColors.text,
                    ),
                  ),
                  trailing: _isTelugu ? const Icon(Icons.check_circle_rounded, color: ManaColors.purple) : null,
                  onTap: () {
                    setState(() => _isTelugu = true);
                    AuthService.instance.setLanguage(isTelugu: true);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = _isTelugu;

    // Responsive theme colors depending on Dark Mode toggle
    final bgColor = _darkMode ? const Color(0xFF0B1120) : ManaColors.bg;
    final surfaceColor = _darkMode ? const Color(0xFF161F38) : ManaColors.surface;
    final cardColor = _darkMode ? const Color(0xFF1E294B) : ManaColors.surface;
    final borderColor = _darkMode ? const Color(0xFF28355E) : ManaColors.border;
    final headingColor = _darkMode ? Colors.white : ManaColors.navy;
    final textColor = _darkMode ? const Color(0xFFE2E8F0) : ManaColors.text;
    final subtextColor = _darkMode ? const Color(0xFF94A3B8) : ManaColors.muted;

    return Theme(
      data: _darkMode ? ManaTheme.darkData() : ManaTheme.data(isTelugu: isTe),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: surfaceColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: headingColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: ManaText(
            isTe ? 'సెట్టింగ్‌లు' : 'Settings',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: headingColor),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            // Section 1: APPEARANCE
            _SectionHeader(title: isTe ? 'రూపురేఖలు (Appearance)' : 'APPEARANCE', color: ManaColors.purple),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    value: _darkMode,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.purple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.dark_mode_rounded, color: ManaColors.purple, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'డార్క్ మోడ్' : 'Dark Mode',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'రాత్రి వేళల్లో కంటికి సురక్షితమైన నీలి రంగు రూపం' : 'Deep navy palette with high contrast',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _darkMode = val),
                  ),
                  Divider(height: 1, color: borderColor),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ManaColors.orange.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.format_size_rounded, color: ManaColors.orange, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ManaText(
                                    isTe ? 'అక్షర పరిమాణం (Font Size)' : 'Text Size & Accessibility',
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                                  ),
                                  Text(
                                    isTe ? 'వృద్ధుల కోసం పెద్ద అక్షరాలు' : 'Larger readable fonts for rural comfort',
                                    style: TextStyle(fontSize: 12, color: subtextColor),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _fontSizeFactor > 1.15 ? 'Large' : (_fontSizeFactor < 0.95 ? 'Small' : 'Standard'),
                              style: TextStyle(fontWeight: FontWeight.w700, color: ManaColors.purple, fontSize: 13),
                            ),
                          ],
                        ),
                        Slider(
                          value: _fontSizeFactor,
                          min: 0.85,
                          max: 1.35,
                          divisions: 4,
                          activeColor: ManaColors.purple,
                          inactiveColor: borderColor,
                          onChanged: (val) => setState(() => _fontSizeFactor = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section 2: ACCESSIBILITY & VOICE
            _SectionHeader(title: isTe ? 'వాయిస్ & ప్రాప్యత' : 'ACCESSIBILITY & VOICE', color: ManaColors.purple),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.translate_rounded, color: ManaColors.blue, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'యాప్ భాష' : 'App Language',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      _isTelugu ? 'తెలుగు (Telugu)' : 'English',
                      style: TextStyle(fontSize: 12, color: ManaColors.purple, fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded, color: ManaColors.muted),
                    onTap: _showLanguagePicker,
                  ),
                  Divider(height: 1, color: borderColor),
                  SwitchListTile(
                    value: _voiceAutoRead,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.purple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.record_voice_over_rounded, color: ManaColors.purple, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'వాయిస్ అసిస్టెంట్ ఆటో-రీడ్' : 'Voice Assistant Auto-Read',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'సమాధానాలను తెలుగులో చదివి వినిపిస్తుంది' : 'Speaks answers automatically in Telugu/English',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _voiceAutoRead = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section 3: DATA & PERMISSIONS
            _SectionHeader(title: isTe ? 'డేటా & అనుమతులు' : 'DATA & PERMISSIONS', color: ManaColors.purple),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    value: _offlineMode,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.orange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.offline_bolt_rounded, color: ManaColors.orange, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'ఆఫ్‌లైన్ మోడ్ (తక్కువ ఇంటర్నెట్)' : 'Offline / Low-Internet Mode',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'ఇంటర్నెట్ లేనప్పుడు కూడా ముఖ్య సమాచారం చూపించు' : 'Caches village contacts & emergency helplines locally',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _offlineMode = val),
                  ),
                  Divider(height: 1, color: borderColor),
                  SwitchListTile(
                    value: _locationPermission,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.my_location_rounded, color: ManaColors.blue, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'లొకేషన్ అనుమతి' : 'GPS Location Permission',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'సమీపంలోని సేవల దూరాన్ని లెక్కించడానికి' : 'Shows precise walking/driving distance to village assets',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _locationPermission = val),
                  ),
                  Divider(height: 1, color: borderColor),
                  SwitchListTile(
                    value: _notificationsEnabled,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.navy.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.notifications_active_rounded, color: ManaColors.navy, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'నోటిఫికేషన్‌లు' : 'Push Notifications',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'నీటి కోత, వర్ష హెచ్చరికలు, గ్రామ నోటీసులు' : 'Immediate alerts for water shutoffs & weather warnings',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  Divider(height: 1, color: borderColor),
                  SwitchListTile(
                    value: _dataSaver,
                    activeThumbColor: ManaColors.purple,
                    activeTrackColor: ManaColors.purpleSoft,
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.leaf.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.data_saver_on_rounded, color: ManaColors.leaf, size: 20),
                    ),
                    title: ManaText(
                      isTe ? 'మొబైల్ డేటా ఆదా (Data Saver)' : 'Mobile Data Saver',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                    ),
                    subtitle: Text(
                      isTe ? 'తక్కువ ఇంటర్నెట్ వినియోగం' : 'Reduces image quality on 2G/3G rural networks',
                      style: TextStyle(fontSize: 12, color: subtextColor),
                    ),
                    onChanged: (val) => setState(() => _dataSaver = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section 4: EMERGENCY HELPLINE SHORTCUTS
            _SectionHeader(title: isTe ? 'అత్యవసర ఫోన్ నంబర్లు' : 'EMERGENCY CONTACTS', color: ManaColors.danger),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.danger.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.local_hospital_rounded, color: ManaColors.danger, size: 20),
                    ),
                    title: const Text('108 Emergency Ambulance', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    subtitle: const Text('Toll Free • 24/7 Medical Response', style: TextStyle(fontSize: 11)),
                    trailing: FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(backgroundColor: ManaColors.danger.withValues(alpha: 0.15)),
                      child: const Text('Call 108', style: TextStyle(fontWeight: FontWeight.w800, color: ManaColors.danger)),
                    ),
                  ),
                  Divider(height: 1, color: borderColor),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ManaColors.blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.local_police_rounded, color: ManaColors.blue, size: 20),
                    ),
                    title: const Text('100 Police Helpline', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    subtitle: const Text('Toll Free • Immediate Police Assistance', style: TextStyle(fontSize: 11)),
                    trailing: FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(backgroundColor: ManaColors.blue.withValues(alpha: 0.15)),
                      child: const Text('Call 100', style: TextStyle(fontWeight: FontWeight.w800, color: ManaColors.blue)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // App branding & version
            Center(
              child: Column(
                children: [
                  ManaText(
                    'Mana Gramam v1.0.0',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: headingColor),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Smart Village • Stronger Tomorrow\nస్మార్ట్ విలేజ్ • బలమైన రేపు',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: ManaColors.muted, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
