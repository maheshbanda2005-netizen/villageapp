import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'login_screen.dart';

/// Screen 03: SELECT YOUR VILLAGE
/// Allows rural users to choose their village, auto-detect location,
/// and specify their persona (Farmer, Student, Job Seeker, Business Owner, General User).
class VillageSelectionScreen extends StatefulWidget {
  final bool isTelugu;
  final bool fromHome;

  const VillageSelectionScreen({
    super.key,
    this.isTelugu = false,
    this.fromHome = false,
  });

  @override
  State<VillageSelectionScreen> createState() => _VillageSelectionScreenState();
}

class _VillageSelectionScreenState extends State<VillageSelectionScreen> {
  String _selectedVillage = 'Kothapally';
  String _selectedRole = 'Farmer';
  bool _locating = false;

  final List<Map<String, String>> _villages = [
    {'name': 'Kothapally', 'mandal': 'Ghatkesar', 'district': 'Medchal-Malkajgiri'},
    {'name': 'Ghatkesar Rural', 'mandal': 'Ghatkesar', 'district': 'Medchal-Malkajgiri'},
    {'name': 'Shameerpet', 'mandal': 'Shameerpet', 'district': 'Medchal-Malkajgiri'},
    {'name': 'Kondapur Gramam', 'mandal': 'Ghatkesar', 'district': 'Medchal-Malkajgiri'},
    {'name': 'Bibinagar Rural', 'mandal': 'Bibinagar', 'district': 'Yadadri Bhuvanagiri'},
    {'name': 'Medchal Gramam', 'mandal': 'Medchal', 'district': 'Medchal-Malkajgiri'},
  ];

  late final List<Map<String, dynamic>> _roles;

  @override
  void initState() {
    super.initState();
    _roles = [
      {'id': 'Farmer', 'icon': '🌾', 'en': 'Farmer', 'te': 'రైతు'},
      {'id': 'Student', 'icon': '🎓', 'en': 'Student', 'te': 'విద్యార్థి'},
      {'id': 'Job Seeker', 'icon': '💼', 'en': 'Job Seeker', 'te': 'ఉద్యోగార్థి'},
      {'id': 'Business Owner', 'icon': '🏪', 'en': 'Business Owner', 'te': 'వ్యాపారి'},
      {'id': 'General User', 'icon': '👤', 'en': 'General User', 'te': 'గ్రామవాసి'},
    ];
  }

  void _detectLocation() {
    setState(() => _locating = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _locating = false;
        _selectedVillage = 'Kothapally';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ManaText(
            widget.isTelugu
                ? 'మీ ప్రస్తుత లొకేషన్ గుర్తించబడింది: Kothapally'
                : 'Current location detected: Kothapally Village',
          ),
          backgroundColor: ManaColors.purple,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  Future<void> _continue() async {
    await AuthService.instance.setVillage(_selectedVillage);

    if (!mounted) return;

    if (widget.fromHome) {
      Navigator.pop(context, _selectedVillage);
      return;
    }

    Navigator.of(context).pushReplacement(
      manaPageRoute(LoginScreen(isTelugu: widget.isTelugu)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: ManaColors.navy,
          onPressed: () => Navigator.pop(context),
        ),
        title: ManaText(
          isTe ? 'గ్రామాన్ని ఎంచుకోండి' : 'Select Your Village',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: ManaColors.navy,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            FadeSlideIn(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 170,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/village_bg.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: ManaColors.navySoft,
                          child: const Icon(Icons.location_city_rounded, size: 48, color: Colors.white70),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              ManaColors.navy.withValues(alpha: 0.85),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        right: 16,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ManaColors.purple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ManaText(
                                    _selectedVillage,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  ManaText(
                                    isTe
                                        ? 'మేడ్చల్-మల్కాజిగిరి జిల్లా • తెలంగాణ'
                                        : 'Medchal-Malkajgiri District • Telangana',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.85),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeSlideIn(
              delayMs: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ManaText(
                    isTe ? 'మీ గ్రామం' : 'Choose village',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: ManaColors.navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ManaColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedVillage,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: ManaColors.purple),
                        items: _villages.map((v) {
                          final name = v['name']!;
                          final sub = '${v['mandal']}, ${v['district']}';
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Row(
                              children: [
                                const Icon(Icons.holiday_village_rounded, size: 20, color: ManaColors.purple),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ManaText(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: ManaColors.navy,
                                        ),
                                      ),
                                      Text(
                                        sub,
                                        style: const TextStyle(fontSize: 11, color: ManaColors.muted),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedVillage = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FadeSlideIn(
              delayMs: 90,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _locating ? null : _detectLocation,
                  icon: _locating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: ManaColors.purple),
                        )
                      : const Icon(Icons.my_location_rounded, color: ManaColors.purple),
                  label: ManaText(
                    isTe ? 'ప్రస్తుత లొకేషన్ ఉపయోగించండి' : 'Use Current Location',
                    style: const TextStyle(
                      color: ManaColors.purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: ManaColors.purple, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: ManaColors.purpleSoft.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeSlideIn(
              delayMs: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ManaText(
                    isTe ? 'మీ పాత్ర ఏమిటి?' : 'What describes you?',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: ManaColors.navy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ManaText(
                    isTe
                        ? 'మీకు అనుకూలమైన సేవలను చూపడానికి ఇది ఉపయోగపడుతుంది'
                        : 'Select your primary role for personalized village services',
                    style: const TextStyle(fontSize: 13, color: ManaColors.muted),
                  ),
                  const SizedBox(height: 14),
                  ..._roles.map((r) {
                    final id = r['id'] as String;
                    final icon = r['icon'] as String;
                    final label = isTe ? r['te'] as String : r['en'] as String;
                    final selected = _selectedRole == id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () => setState(() => _selectedRole = id),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: selected ? ManaColors.purpleSoft.withValues(alpha: 0.5) : ManaColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selected ? ManaColors.purple : ManaColors.border,
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(icon, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: ManaText(
                                  label,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                                    color: selected ? ManaColors.purple : ManaColors.text,
                                  ),
                                ),
                              ),
                              if (selected)
                                const Icon(Icons.check_circle_rounded, color: ManaColors.purple)
                              else
                                const Icon(Icons.radio_button_off_rounded, color: ManaColors.muted),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FadeSlideIn(
              delayMs: 160,
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _continue,
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
                        isTe ? 'కొనసాగించండి' : 'Continue',
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
    );
  }
}
