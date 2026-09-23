import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'agriculture_screen.dart';
import 'businesses_screen.dart';
import 'education_screen.dart';
import 'healthcare_screen.dart';
import 'jobs_screen.dart';
import 'login_screen.dart';
import 'marketplace_screen.dart';
import 'notifications_screen.dart';
import 'panchayat_screen.dart';
import 'profile_screen.dart';
import 'schemes_screen.dart';
import 'village_map_screen.dart';
import 'village_selection_screen.dart';
import 'village_gallery_screen.dart';
import 'voice_assistant_screen.dart';

/// Screen 05: MANA GRAMAM HOME SCREEN
/// The crown jewel of the Mana Gramam design system:
/// - Top header with logo, greeting, location switcher
/// - Search bar with direct microphone voice assistant trigger
/// - Village hero with photo/video overlay
/// - Warm orange important notice card
/// - 8 authentic service cards with real imagery
/// - Large red Emergency Help section (Ambulance, Police, Fire, Hospital)
/// - Nearby places map preview card
/// - 5-item bottom navigation with prominent purple central + action
class NewHomeScreen extends StatefulWidget {
  final bool isTelugu;
  const NewHomeScreen({super.key, this.isTelugu = false});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  int _tab = 0;
  AuthUser? _user;
  String _currentVillage = 'Kothapally Village';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthService.instance.currentUser();
    if (mounted) {
      setState(() {
        _user = user;
        if (user?.village.isNotEmpty == true) {
          _currentVillage = '${user!.village} Village';
        }
      });
    }
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (widget.isTelugu) {
      if (hour < 12) return 'శుభోదయం';
      if (hour < 17) return 'శుభ మధ్యాహ్నం';
      return 'శుభ సాయంత్రం';
    }
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void _openVillageSwitcher() async {
    final result = await Navigator.push<String>(
      context,
      manaPageRoute(VillageSelectionScreen(isTelugu: widget.isTelugu, fromHome: true)),
    );
    if (result != null && mounted) {
      setState(() => _currentVillage = '$result Village');
    }
  }

  void _openCentralActionModal() {
    final isTe = widget.isTelugu;
    showModalBottomSheet(
      context: context,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: ManaColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ManaText(
                  isTe ? 'త్వరిత గ్రామ చర్యలు' : 'Quick Village Actions',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ManaColors.navy),
                ),
                const SizedBox(height: 16),
                _QuickActionTile(
                  icon: Icons.report_problem_rounded,
                  accent: ManaColors.danger,
                  title: isTe ? 'పంచాయతీ ఫిర్యాదు నివేదించండి' : 'Report a Village Problem',
                  subtitle: isTe ? 'నీరు, వీధి దీపం, రోడ్డు సమస్యలు' : 'Water, streetlight, road, or sanitation',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, manaPageRoute(const PanchayatScreen()));
                  },
                ),
                const SizedBox(height: 10),
                _QuickActionTile(
                  icon: Icons.work_rounded,
                  accent: ManaColors.purple,
                  title: isTe ? 'ఉద్యోగం లేదా కూలీని ప్రకటించండి' : 'Post a Local Job',
                  subtitle: isTe ? 'వ్యవసాయ లేదా నైపుణ్య పనుల ప్రకటన' : 'Hire farm workers, drivers, electricians',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, manaPageRoute(const JobsScreen()));
                  },
                ),
                const SizedBox(height: 10),
                _QuickActionTile(
                  icon: Icons.storefront_rounded,
                  accent: ManaColors.orange,
                  title: isTe ? 'మార్కెట్‌లో అమ్మండి' : 'Post a Marketplace Listing',
                  subtitle: isTe ? 'ధాన్యం, పంటలు, ట్రాక్టర్ అద్దె' : 'Sell crops, seeds, or rent farm equipment',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, manaPageRoute(const MarketplaceScreen()));
                  },
                ),
                const SizedBox(height: 10),
                _QuickActionTile(
                  icon: Icons.mic_rounded,
                  accent: ManaColors.blue,
                  title: isTe ? 'గ్రామ మిత్రతో మాట్లాడండి' : 'Ask Voice Assistant',
                  subtitle: isTe ? 'తెలుగులో అడిగి సమాధానం పొందండి' : 'Speak in Telugu or English for instant answers',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, manaPageRoute(VoiceAssistantScreen(isTelugu: widget.isTelugu)));
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
    final pages = [
      _HomeTab(
        isTelugu: widget.isTelugu,
        user: _user,
        greeting: _greeting,
        villageName: _currentVillage,
        onVillageTap: _openVillageSwitcher,
        onOpenMap: () => setState(() => _tab = 1),
        onOpenNotifications: () {
          Navigator.push(
            context,
            manaPageRoute(NotificationsScreen(isTelugu: widget.isTelugu)),
          );
        },
        onOpenProfile: () => setState(() => _tab = 4),
        onOpenVoiceAssistant: () {
          Navigator.push(
            context,
            manaPageRoute(VoiceAssistantScreen(isTelugu: widget.isTelugu)),
          );
        },
      ),
      VillageMapScreen(isTelugu: widget.isTelugu),
      const SizedBox.shrink(), // placeholder for center action
      NotificationsScreen(isTelugu: widget.isTelugu),
      ProfileScreen(
        isTelugu: widget.isTelugu,
        user: _user,
        onLogout: () async {
          await AuthService.instance.logout();
          if (!context.mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            manaPageRoute(LoginScreen(isTelugu: widget.isTelugu)),
            (_) => false,
          );
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _tab == 2 ? 0 : _tab,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ManaColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          border: const Border(top: BorderSide(color: ManaColors.border)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                _NavBarItem(
                  icon: Icons.home_rounded,
                  label: widget.isTelugu ? 'హోమ్' : 'Home',
                  selected: _tab == 0,
                  onTap: () => setState(() => _tab = 0),
                ),
                _NavBarItem(
                  icon: Icons.map_rounded,
                  label: widget.isTelugu ? 'మ్యాప్' : 'Map',
                  selected: _tab == 1,
                  onTap: () => setState(() => _tab = 1),
                ),
                // Prominent Purple Central + Action Button
                Expanded(
                  child: GestureDetector(
                    onTap: _openCentralActionModal,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: ManaColors.purple,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ManaColors.purple.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.add_rounded, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),
                _NavBarItem(
                  icon: Icons.notifications_none_rounded,
                  label: widget.isTelugu ? 'అలర్ట్స్' : 'Alerts',
                  selected: _tab == 3,
                  onTap: () => setState(() => _tab = 3),
                ),
                _NavBarItem(
                  icon: Icons.person_outline_rounded,
                  label: widget.isTelugu ? 'ప్రొఫైల్' : 'Profile',
                  selected: _tab == 4,
                  onTap: () => setState(() => _tab = 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: selected ? ManaColors.purple : ManaColors.muted,
                  size: 24,
                ),
                const SizedBox(height: 3),
                ManaText(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                    color: selected ? ManaColors.purple : ManaColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final bool isTelugu;
  final AuthUser? user;
  final String greeting;
  final String villageName;
  final VoidCallback onVillageTap;
  final VoidCallback onOpenMap;
  final VoidCallback onOpenNotifications;
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenVoiceAssistant;

  const _HomeTab({
    required this.isTelugu,
    required this.user,
    required this.greeting,
    required this.villageName,
    required this.onVillageTap,
    required this.onOpenMap,
    required this.onOpenNotifications,
    required this.onOpenProfile,
    required this.onOpenVoiceAssistant,
  });

  static const List<_ServiceCardItem> _services = [
    _ServiceCardItem(
      titleEn: 'Agriculture',
      titleTe: 'వ్యవసాయం',
      descEn: 'Weather, market prices & crops',
      descTe: 'వాతావరణం, పంట ధరలు',
      imageAsset: 'assets/images/service_agriculture.jpg',
      icon: Icons.agriculture_rounded,
      accent: ManaColors.leaf,
      screen: AgricultureScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Healthcare',
      titleTe: 'ఆరోగ్యం',
      descEn: 'Doctors, PHC & health camps',
      descTe: 'వైద్యులు, ప్రాథమిక కేంద్రం',
      imageAsset: 'assets/images/service_healthcare.jpg',
      icon: Icons.local_hospital_rounded,
      accent: ManaColors.coral,
      screen: HealthcareScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Panchayat',
      titleTe: 'పంచాయతీ',
      descEn: 'Problem reporting & services',
      descTe: 'ఫిర్యాదులు, గ్రామ సేవలు',
      imageAsset: 'assets/images/service_panchayat.jpg',
      icon: Icons.account_balance_rounded,
      accent: ManaColors.navy,
      screen: PanchayatScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Jobs',
      titleTe: 'ఉద్యోగాలు',
      descEn: 'Farm workers, drivers & skill jobs',
      descTe: 'కూలీలు, డ్రైవర్లు, నైపుణ్య పనులు',
      imageAsset: 'assets/images/service_jobs.jpg',
      icon: Icons.work_rounded,
      accent: ManaColors.purple,
      screen: JobsScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Education',
      titleTe: 'విద్య',
      descEn: 'Skills, scholarships & exams',
      descTe: 'నైపుణ్యాలు, స్కాలర్‌షిప్‌లు',
      imageAsset: 'assets/images/service_education.jpg',
      icon: Icons.school_rounded,
      accent: ManaColors.blue,
      screen: EducationScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Govt Schemes',
      titleTe: 'ప్రభుత్వ పథకాలు',
      descEn: 'PM Kisan, Rythu Bandhu & welfare',
      descTe: 'రైతు బంధు, సంక్షేమ పథకాలు',
      imageAsset: 'assets/images/service_schemes.jpg',
      icon: Icons.payments_rounded,
      accent: ManaColors.orange,
      screen: SchemesScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Marketplace',
      titleTe: 'గ్రామ మార్కెట్',
      descEn: 'Buy & sell crops, seeds, tools',
      descTe: 'ధాన్యం, విత్తనాలు, పరికరాలు',
      imageAsset: 'assets/images/service_marketplace.jpg',
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFC026D3),
      screen: MarketplaceScreen(),
    ),
    _ServiceCardItem(
      titleEn: 'Local Businesses',
      titleTe: 'స్థానిక వ్యాపారాలు',
      descEn: 'Kirana, electricals & workshops',
      descTe: 'కిరాణా, మెకానిక్, దుకాణాలు',
      imageAsset: 'assets/images/service_businesses.jpg',
      icon: Icons.storefront_rounded,
      accent: ManaColors.teal,
      screen: BusinessesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final name = user?.name.isNotEmpty == true ? user!.name : 'Rahul 👋';

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // 1. TOP HEADER: Logo, Greeting, Village Location, Bell, Profile
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: FadeSlideIn(
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/mana_gramam_logo.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 42,
                          height: 42,
                          color: ManaColors.purple,
                          child: const Icon(Icons.cottage_rounded, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ManaText(
                            '$greeting, $name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: ManaColors.navy,
                              letterSpacing: -0.3,
                            ),
                          ),
                          GestureDetector(
                            onTap: onVillageTap,
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_rounded, size: 14, color: ManaColors.orange),
                                const SizedBox(width: 4),
                                ManaText(
                                  villageName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: ManaColors.muted,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded, size: 16, color: ManaColors.muted),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onOpenNotifications,
                      icon: const Badge(
                        smallSize: 8,
                        child: Icon(Icons.notifications_none_rounded, color: ManaColors.navy),
                      ),
                    ),
                    GestureDetector(
                      onTap: onOpenProfile,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
                        backgroundColor: ManaColors.border,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. SEARCH BAR with Microphone trigger
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: FadeSlideIn(
                delayMs: 40,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: ManaColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: ManaColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      const Icon(Icons.search_rounded, color: ManaColors.muted, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: isTelugu
                                ? 'సేవలు, పథకాలు, ప్రదేశాలు వెతకండి…'
                                : 'Search services, schemes, places…',
                            hintStyle: const TextStyle(fontSize: 14, color: ManaColors.muted),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ManaColors.purpleSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.mic_rounded, color: ManaColors.purple, size: 20),
                          onPressed: onOpenVoiceAssistant,
                          tooltip: 'Ask Mana Gramam Voice Assistant',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. VILLAGE HERO: Large Authentic Village Photography with Video Overlay
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: FadeSlideIn(
                delayMs: 40,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, manaPageRoute(VillageGalleryScreen(isTelugu: isTelugu)));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 180,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/village_bg.jpg',
                              fit: BoxFit.cover,
                              cacheWidth: 800,
                              errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navySoft),
                            ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.75),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.videocam_rounded, size: 14, color: ManaColors.orange),
                                SizedBox(width: 5),
                                Text(
                                  'Village Showcase',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Center(
                          child: Icon(
                            Icons.play_circle_fill_rounded,
                            size: 58,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 14,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ManaText(
                                villageName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isTelugu ? 'మీ డిజిటల్ గ్రామం • బలమైన రేపు' : 'Your Digital Village • Stronger Tomorrow',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
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
                ),
              ),
            ),
          ),
        ),
      ),

          // 4. IMPORTANT NOTICE: Warm Orange Notification Card (Opens Official Alert Modal)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: FadeSlideIn(
                delayMs: 60,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () => _openNoticeDetails(context, isTelugu),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ManaColors.warningBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: ManaColors.warningBorder),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ManaColors.orange.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.campaign_rounded, color: ManaColors.orange, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ManaText(
                                      isTelugu ? 'ముఖ్యమైన గ్రామ నోటీసు' : 'Important Notice',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        color: ManaColors.navy,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: ManaColors.orange,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'Panchayat',
                                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                ManaText(
                                  isTelugu
                                      ? 'రేపు ఉదయం 9 నుండి మధ్యాహ్నం 2 గంటల వరకు పైప్‌లైన్ పనుల వల్ల నీటి సరఫరా ఉండదు.'
                                      : 'Water supply may be unavailable tomorrow from 9 AM to 2 PM.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: ManaColors.text,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ManaText(
                                      isTelugu ? 'వివరాలు చూడండి (నోటీసు తెరవండి) →' : 'View Notice Details →',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: ManaColors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 5. SERVICE GRID HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
              child: FadeSlideIn(
                delayMs: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ManaText(
                      isTelugu ? 'గ్రామ సేవలు' : 'Village Services',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: ManaColors.navy,
                        letterSpacing: -0.4,
                      ),
                    ),
                    ManaText(
                      '8 Categories',
                      style: const TextStyle(fontSize: 12, color: ManaColors.muted, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 8 MAIN SERVICE CARDS with Real Photography
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final s = _services[i];
                  return FadeSlideIn(
                    delayMs: 100 + (i * 20),
                    child: _HomeServiceCard(
                      service: s,
                      isTelugu: isTelugu,
                      onTap: () {
                        Navigator.push(context, manaPageRoute(s.screen));
                      },
                    ),
                  );
                },
                childCount: _services.length,
              ),
            ),
          ),

          // 6. OUR VILLAGE (VILLAGE GALLERY): ONE UNIFIED SECTION
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
              child: FadeSlideIn(
                delayMs: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ManaColors.purpleSoft,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.cottage_rounded, color: ManaColors.purple, size: 22),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ManaText(
                              isTelugu ? 'మా గ్రామం (Our Village)' : 'Our Village',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: ManaColors.navy,
                              ),
                            ),
                            Text(
                              isTelugu
                                  ? 'ఫోటోలు, వీడియోలు మరియు ప్రదేశాల ద్వారా గ్రామాన్ని చూడండి'
                                  : 'Explore our village through photos, videos and places.',
                              style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // 2-Column Grid of Unified Village Places & Photos (Smooth, Bounded, Zero Layout Jank)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '🌾 Fields', 'పొలాలు', 'assets/images/service_agriculture.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🏭 Rice Mill', 'రైస్ మిల్లు', 'assets/images/gallery_ricemill.jpg', isTelugu)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '🏛 Panchayat', 'పంచాయతీ', 'assets/images/service_panchayat.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🏫 School', 'పాఠశాల', 'assets/images/service_education.jpg', isTelugu)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '🏥 Hospital', 'ఆసుపత్రి', 'assets/images/service_healthcare.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🛕 Temple', 'దేవాలయం', 'assets/images/gallery_temple.jpg', isTelugu)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '⛽ Petrol Bunk', 'పెట్రోల్ బంక్', 'assets/images/gallery_petrol.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🏪 Shops', 'దుకాణాలు', 'assets/images/service_businesses.jpg', isTelugu)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '🚌 Bus Stop', 'బస్సు స్టాప్', 'assets/images/gallery_busstop.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🛣 Streets', 'వీధులు', 'assets/images/gallery_street.jpg', isTelugu)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGalleryGridCard(context, '🐄 Animals', 'పాడి పశువులు', 'assets/images/gallery_animals.jpg', isTelugu)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGalleryGridCard(context, '🏞 Lake', 'పెద్ద చెరువు', 'assets/images/gallery_lake.jpg', isTelugu)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Prominent [ View All → ] Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, manaPageRoute(VillageGalleryScreen(isTelugu: isTelugu)));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ManaColors.purple, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ManaText(
                              isTelugu ? 'గ్రామ గ్యాలరీ మొత్తం చూడండి →' : 'View All (Village Gallery) →',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 7. EMERGENCY SECTION: Large Red Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
              child: FadeSlideIn(
                delayMs: 220,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: ManaColors.danger.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ManaColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ManaColors.danger,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.emergency_rounded, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ManaText(
                                isTelugu ? 'అత్యవసర సహాయం (24/7)' : 'Emergency Help (24/7)',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: ManaColors.danger,
                                ),
                              ),
                              Text(
                                isTelugu ? 'తక్షణ ఫోన్ కాల్ సహాయం' : 'Instant one-tap helpline dialing',
                                style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _EmergencyButton(
                            label: 'Ambulance\n108',
                            icon: Icons.local_hospital_rounded,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dialing 108 Ambulance Emergency Helpline...'),
                                  backgroundColor: ManaColors.danger,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          _EmergencyButton(
                            label: 'Police\n100',
                            icon: Icons.local_police_rounded,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dialing 100 Police Emergency Helpline...'),
                                  backgroundColor: ManaColors.danger,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          _EmergencyButton(
                            label: 'Fire\n101',
                            icon: Icons.local_fire_department_rounded,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dialing 101 Fire Emergency Helpline...'),
                                  backgroundColor: ManaColors.danger,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          _EmergencyButton(
                            label: 'PHC Doctor\nDirect',
                            icon: Icons.health_and_safety_rounded,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Connecting directly to Kothapally PHC on-duty doctor (+91 94401 23456)...'),
                                  backgroundColor: ManaColors.danger,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 7. NEARBY PLACES: Small Map Preview Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
              child: FadeSlideIn(
                delayMs: 250,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ManaColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ManaColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ManaColors.purpleSoft,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.explore_rounded, color: ManaColors.purple, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ManaText(
                              isTelugu ? 'సమీప ప్రదేశాలు & ఆస్తులు' : 'Nearby Places & Village Assets',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isTelugu ? 'ఆసుపత్రులు • దుకాణాలు • పనులు • సేవా కేంద్రాలు' : 'Hospitals • Shops • Jobs • Services',
                              style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: onOpenMap,
                        style: FilledButton.styleFrom(
                          backgroundColor: ManaColors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        ),
                        child: ManaText(
                          isTelugu ? 'మ్యాప్' : 'Open Map',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
    );
  }

  void _openNoticeDetails(BuildContext context, bool isTelugu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ManaColors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.campaign_rounded, color: ManaColors.orange, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: ManaColors.orange,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isTelugu ? 'అధికారిక గ్రామ పంచాయతీ నోటీసు' : 'Official Gram Panchayat Notice',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: 4),
                        ManaText(
                          isTelugu ? 'నీటి సరఫరా నిలిపివేత ప్రకటన' : 'Water Supply Suspension Notice',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: ManaColors.navy),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: ManaColors.bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ManaColors.border),
                ),
                child: Column(
                  children: [
                    _noticeRow(Icons.schedule_rounded, isTelugu ? 'సమయం / వ్యవధి' : 'Timings & Duration', isTelugu ? 'రేపు ఉదయం 9:00 - మధ్యాహ్నం 2:00 (5 గంటలు)' : 'Tomorrow • 9:00 AM – 2:00 PM (5 Hours)'),
                    const Divider(height: 18),
                    _noticeRow(Icons.location_on_rounded, isTelugu ? 'ప్రభావిత ప్రాంతాలు' : 'Affected Wards', isTelugu ? 'ఉత్తర వార్డు, ప్రధాన బజార్, ఆలయ వీధి, దక్షిణ కాలనీ' : 'North Ward, Main Bazaar, Temple Street, South Colony'),
                    const Divider(height: 18),
                    _noticeRow(Icons.build_circle_rounded, isTelugu ? 'పనుల కారణం' : 'Work Description', isTelugu ? 'కాలువ జంక్షన్ వద్ద 150 మి.మీ ప్రధాన తాగునీటి పైప్‌లైన్ మరమ్మతులు' : '150mm Main drinking water pipeline maintenance near Canal'),
                    const Divider(height: 18),
                    _noticeRow(Icons.local_shipping_rounded, isTelugu ? 'ప్రత్యామ్నాయ సదుపాయం' : 'Water Tanker Supply', isTelugu ? 'బస్టాండ్ సర్కిల్ & పంచాయతీ వద్ద ఉచిత వాటర్ ట్యాంకర్లు' : 'Free Water Tankers at Bus Stand Circle & Panchayat Office'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isTelugu ? 'లైన్‌మెన్ రమేష్ (+91 98480 12345) కు డయల్ చేయబడుతోంది...' : 'Calling Water Lineman Ramesh (+91 98480 12345)...'),
                            backgroundColor: ManaColors.purple,
                          ),
                        );
                      },
                      icon: const Icon(Icons.call_rounded),
                      label: ManaText(
                        isTelugu ? 'లైన్‌మెన్ కాల్' : 'Call Helpline',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.push(context, manaPageRoute(NotificationsScreen(isTelugu: isTelugu)));
                      },
                      icon: const Icon(Icons.notifications_active_rounded, color: ManaColors.navy),
                      label: ManaText(
                        isTelugu ? 'అన్ని అలర్ట్స్' : 'All Alerts',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: ManaColors.navy),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ManaColors.navy, width: 1.5),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _noticeRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: ManaColors.purple),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: ManaColors.muted, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 13, color: ManaColors.navy, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryGridCard(BuildContext context, String title, String titleTe, String imageAsset, bool isTe) {
    return InkWell(
      onTap: () {
        Navigator.push(context, manaPageRoute(VillageGalleryScreen(isTelugu: isTe)));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                cacheWidth: 400,
                errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 8,
                child: Text(
                  isTe ? titleTe : title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeServiceCard extends StatelessWidget {
  final _ServiceCardItem service;
  final bool isTelugu;
  final VoidCallback onTap;

  const _HomeServiceCard({
    required this.service,
    required this.isTelugu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManaColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: ManaColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        service.imageAsset,
                        fit: BoxFit.cover,
                        cacheWidth: 400,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: service.accent.withValues(alpha: 0.15),
                          child: Icon(service.icon, color: service.accent, size: 36),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: service.accent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(service.icon, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ManaText(
                      isTelugu ? service.titleTe : service.titleEn,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: ManaColors.navy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isTelugu ? service.descTe : service.descEn,
                      style: const TextStyle(fontSize: 10, color: ManaColors.muted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmergencyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _EmergencyButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ManaColors.danger.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: ManaColors.danger, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: ManaColors.navy,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.accent,
    required this.title,
    required this.subtitle,
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
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: ManaColors.muted),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: ManaColors.muted),
        onTap: onTap,
      ),
    );
  }
}

class _ServiceCardItem {
  final String titleEn;
  final String titleTe;
  final String descEn;
  final String descTe;
  final String imageAsset;
  final IconData icon;
  final Color accent;
  final Widget screen;

  const _ServiceCardItem({
    required this.titleEn,
    required this.titleTe,
    required this.descEn,
    required this.descTe,
    required this.imageAsset,
    required this.icon,
    required this.accent,
    required this.screen,
  });
}
