import 'package:flutter/material.dart';
import 'package:mana_gramam/models/service_item.dart';
import 'package:mana_gramam/screens/splash_screen.dart';
import 'package:mana_gramam/screens/service_page.dart';
import 'package:mana_gramam/utils/app_typography.dart';

class HomeScreen extends StatefulWidget {
  final AppLanguage initialLanguage;

  const HomeScreen({
    super.key,
    this.initialLanguage = AppLanguage.english,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppLanguage _selectedLanguage;
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialLanguage;
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == AppLanguage.english
          ? AppLanguage.telugu
          : AppLanguage.english;
    });
  }

  void _showVoiceModal(BuildContext context, bool isTelugu) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF38157F), Color(0xFF6723D4)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5A22C5).withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.mic_rounded, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 18),
            Text(
              isTelugu ? 'నేను వింటున్నాను...' : 'Listening...',
              style: AppTypography.font(
                isTelugu: isTelugu,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E1B4B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isTelugu
                  ? '"నేటి పంచాయతీ సమయం ఏమిటి?" అని అడగండి'
                  : 'Ask "What are the latest government schemes?"',
              textAlign: TextAlign.center,
              style: AppTypography.font(
                isTelugu: isTelugu,
                fontSize: 13,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTelugu = _selectedLanguage == AppLanguage.telugu;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Top Header App Bar
            _buildTopHeader(isTelugu),

            // 2. Scrollable Home Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. Live Village Video Card
                    _buildLiveVideoCard(isTelugu),
                    const SizedBox(height: 14),

                    // B. Good Morning & Weather Card
                    _buildGreetingAndWeatherCard(isTelugu),
                    const SizedBox(height: 14),

                    // C. 8 Service Cards (4 Columns x 2 Rows)
                    _buildServiceCardsGrid(isTelugu),
                    const SizedBox(height: 18),

                    // D. Quick Links Section
                    _buildQuickLinksSection(isTelugu),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. Custom Bottom Navigation Bar with Center Voice Mic FAB
      bottomNavigationBar: _buildBottomNavigationBar(isTelugu),
    );
  }

  /// Top App Bar matching mockup: Logo + App Name + Slogan + Language Switch + Notification + Profile
  Widget _buildTopHeader(bool isTelugu) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Logo emblem
          Image.asset(
            'assets/images/mana_gramam_logo.png',
            width: 38,
            height: 38,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),

          // Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isTelugu ? 'మన గ్రామం' : 'Mana Gramam',
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E1B4B),
                    letterSpacing: -0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  isTelugu
                      ? 'స్మార్ట్ గ్రామం • బలమైన రేపు'
                      : 'Smart Village • Stronger Tomorrow',
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Language Switch Pill
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language, size: 14, color: Color(0xFF4F46E5)),
                  const SizedBox(width: 4),
                  Text(
                    isTelugu ? 'English' : 'తెలుగు',
                    style: AppTypography.font(
                      isTelugu: isTelugu,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Notification Bell with unread indicator
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 20,
                  color: Color(0xFF1E293B),
                ),
              ),
              Positioned(
                top: 4,
                right: 5,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),

          // Profile Avatar
          Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4F46E5), width: 1.5),
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  /// Live Village Video player banner
  Widget _buildLiveVideoCard(bool isTelugu) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Video Thumbnail
            Positioned.fill(
              child: Image.asset(
                'assets/images/video_thumb.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // Subtle dark gradient vignette for readable text
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.35),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),

            // Top-left: "Live Village Video" pill tag
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isTelugu ? 'లైవ్ గ్రామ వీడియో' : 'Live Village Video',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center: Translucent circular play button
            Center(
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.35),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 2),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),

            // Bottom bar: Location title + duration + fullscreen
            Positioned(
              left: 12,
              right: 12,
              bottom: 10,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      isTelugu
                          ? 'నా గ్రామం - అందమైన, పచ్చని, ఐక్యతగల'
                          : 'My Village - Beautiful, Green, United',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '0:45 / 1:30',
                    style: AppTypography.font(
                      isTelugu: isTelugu,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Greeting (Good Morning) & Weather Card
  Widget _buildGreetingAndWeatherCard(bool isTelugu) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Greeting Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.wb_sunny_rounded, color: Color(0xFFF59E0B), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      isTelugu ? 'శుభోదయం,' : 'Good Morning,',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isTelugu ? 'మీ గ్రామానికి స్వాగతం' : 'Welcome to Your Village',
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isTelugu
                      ? 'కలిసి మంచి రేపటిని నిర్మిద్దాం'
                      : 'Together we build a better tomorrow',
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 10.5,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Right: Weather Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F6FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.cloud_queue_rounded, color: Color(0xFF38BDF8), size: 18),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '28°C',
                          style: AppTypography.font(
                            isTelugu: isTelugu,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          isTelugu ? 'పాక్షికంగా మేఘాలు' : 'Partly Cloudy',
                          style: AppTypography.font(
                            isTelugu: isTelugu,
                            fontSize: 9.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 11, color: Color(0xFF3B82F6)),
                    const SizedBox(width: 2),
                    Text(
                      isTelugu ? 'నర్సాపూర్' : 'Narsapur Village',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 12, color: Color(0xFF94A3B8)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 8 Service Cards in 3 columns (3+3+2) for better readability
  Widget _buildServiceCardsGrid(bool isTelugu) {
    // Row 1 Items
    final row1 = [
      ServiceItem(
        title: isTelugu ? 'వ్యవసాయం' : 'Agriculture',
        subtitle: isTelugu ? 'మెరుగైన సాగు, అధిక దిగుబడి' : 'Better farming, higher yields',
        imageAsset: 'assets/images/service_agriculture.jpg',
        badgeColor: const Color(0xFF10B981),
        badgeIcon: Icons.eco_rounded,
      ),
      ServiceItem(
        title: isTelugu ? 'ఆరోగ్యం' : 'Healthcare',
        subtitle: isTelugu ? 'ఆరోగ్య ప్రజలు, బలమైన గ్రామం' : 'Healthy people, stronger villages',
        imageAsset: 'assets/images/service_healthcare.jpg',
        badgeColor: const Color(0xFFEF4444),
        badgeIcon: Icons.favorite_rounded,
      ),
      ServiceItem(
        title: isTelugu ? 'పంచాయతీ' : 'Panchayat',
        subtitle: isTelugu ? 'మీ గళం, మా ప్రాధాన్యత' : 'Your voice, our priority',
        imageAsset: 'assets/images/service_panchayat.jpg',
        badgeColor: const Color(0xFF4F46E5),
        badgeIcon: Icons.account_balance_rounded,
      ),
    ];

    // Row 2 Items
    final row2 = [
      ServiceItem(
        title: isTelugu ? 'ఉద్యోగాలు' : 'Jobs',
        subtitle: isTelugu ? 'కొత్త అవకాశాలు, ఉజ్వల రేపు' : 'New opportunities, better future',
        imageAsset: 'assets/images/service_jobs.jpg',
        badgeColor: const Color(0xFFF97316),
        badgeIcon: Icons.business_center_rounded,
      ),
      ServiceItem(
        title: isTelugu ? 'విద్య' : 'Education',
        subtitle: isTelugu ? 'నేడు నేర్చుకోండి, రేపు నడపండి' : 'Learn today, lead tomorrow',
        imageAsset: 'assets/images/service_education.jpg',
        badgeColor: const Color(0xFF2563EB),
        badgeIcon: Icons.school_rounded,
      ),
      ServiceItem(
        title: isTelugu ? 'పథకాలు' : 'Schemes',
        subtitle: isTelugu ? 'మీ ఎదుగుదలకు ప్రభుత్వ తోడ్పాటు' : 'Government support for your growth',
        imageAsset: 'assets/images/service_schemes.jpg',
        badgeColor: const Color(0xFFF59E0B),
        badgeIcon: Icons.currency_rupee_rounded,
      ),
    ];

    // Row 3 Items
    final row3 = [
      ServiceItem(
        title: isTelugu ? 'మార్కెట్' : 'Marketplace',
        subtitle: isTelugu ? 'కొనుగోలు • అమ్మకం • వృద్ధి' : 'Buy • Sell • Grow locally',
        imageAsset: 'assets/images/service_marketplace.jpg',
        badgeColor: const Color(0xFFEC4899),
        badgeIcon: Icons.shopping_bag_rounded,
      ),
      ServiceItem(
        title: isTelugu ? 'వ్యాపారాలు' : 'Businesses',
        subtitle: isTelugu ? 'స్థానిక వ్యాపారాలకు మద్దతు' : 'Support local businesses',
        imageAsset: 'assets/images/service_businesses.jpg',
        badgeColor: const Color(0xFF0D9488),
        badgeIcon: Icons.storefront_rounded,
      ),
    ];

    return Column(
      children: [
        _buildThreeCardRow(row1, isTelugu),
        const SizedBox(height: 12),
        _buildThreeCardRow(row2, isTelugu),
        const SizedBox(height: 12),
        _buildTwoCardRow(row3, isTelugu),
      ],
    );
  }

  Widget _buildThreeCardRow(List<ServiceItem> items, bool isTelugu) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var item in items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildServiceCard(item, isTelugu),
            ),
          ),
      ],
    );
  }

  Widget _buildTwoCardRow(List<ServiceItem> items, bool isTelugu) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox()), // Spacer for centering
        for (var item in items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildServiceCard(item, isTelugu),
            ),
          ),
        const Expanded(child: SizedBox()), // Spacer for centering
      ],
    );
  }

  Widget _buildServiceCard(ServiceItem item, bool isTelugu) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicePage(
              serviceItem: item,
              initialLanguage: _selectedLanguage,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image with overlapping circular badge
            SizedBox(
              height: 100,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      item.imageAsset,
                      width: double.infinity,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Overlapping Icon Badge
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: item.badgeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: item.badgeColor.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(item.badgeIcon, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Content: Title + Subtitle + Action Arrow
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.font(
                      isTelugu: isTelugu,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 32,
                    child: Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: item.badgeColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: item.badgeColor,
                      ),
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

  /// Quick Links Section matching mockup
  Widget _buildQuickLinksSection(bool isTelugu) {
    final quickLinks = [
      _QuickLink(
        title: isTelugu ? 'వాతావరణం' : 'Weather',
        icon: Icons.cloud_queue_rounded,
        iconColor: const Color(0xFF0284C7),
        bgColor: const Color(0xFFE0F2FE),
      ),
      _QuickLink(
        title: isTelugu ? 'మ్యాప్' : 'Map',
        icon: Icons.location_on_rounded,
        iconColor: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      ),
      _QuickLink(
        title: isTelugu ? 'అత్యవసరం' : 'Emergency',
        icon: Icons.emergency_rounded,
        iconColor: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      ),
      _QuickLink(
        title: isTelugu ? 'ఫిర్యాదులు' : 'Complaints',
        icon: Icons.description_rounded,
        iconColor: const Color(0xFF2563EB),
        bgColor: const Color(0xFFDBEAFE),
      ),
      _QuickLink(
        title: isTelugu ? 'నోటిఫికేషన్' : 'Notifications',
        icon: Icons.notifications_rounded,
        iconColor: const Color(0xFF0284C7),
        bgColor: const Color(0xFFE0F2FE),
      ),
      _QuickLink(
        title: isTelugu ? 'సహాయం' : 'Help',
        icon: Icons.headset_mic_rounded,
        iconColor: const Color(0xFF7C3AED),
        bgColor: const Color(0xFFEDE9FE),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Quick Links + View All >
          Row(
            children: [
              const Icon(Icons.link_rounded, color: Color(0xFF4F46E5), size: 18),
              const SizedBox(width: 6),
              Text(
                isTelugu ? 'త్వరిత లింకులు' : 'Quick Links',
                style: AppTypography.font(
                  isTelugu: isTelugu,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isTelugu ? 'అన్నీ చూడండి' : 'View All',
                    style: AppTypography.font(
                      isTelugu: isTelugu,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF4F46E5)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 6 Circle Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: quickLinks.map((link) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: link.bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(link.icon, color: link.iconColor, size: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    link.title,
                    style: AppTypography.font(
                      isTelugu: isTelugu,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Bottom Navigation Bar with centered floating Voice Mic FAB
  Widget _buildBottomNavigationBar(bool isTelugu) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Navigation Items Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_rounded,
                    label: isTelugu ? 'హోమ్' : 'Home',
                    isTelugu: isTelugu,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.location_on_outlined,
                    label: isTelugu ? 'మ్యాప్' : 'Map',
                    isTelugu: isTelugu,
                  ),
                  const SizedBox(width: 54), // Space for center FAB
                  _buildNavItem(
                    index: 2,
                    icon: Icons.notifications_none_rounded,
                    label: isTelugu ? 'హెచ్చరికలు' : 'Alerts',
                    isTelugu: isTelugu,
                    showBadge: true,
                  ),
                  _buildNavItem(
                    index: 3,
                    icon: Icons.person_outline_rounded,
                    label: isTelugu ? 'ప్రొఫైల్' : 'Profile',
                    isTelugu: isTelugu,
                  ),
                ],
              ),

              // Centered Floating Mic Button
              Positioned(
                top: -18,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _showVoiceModal(context, isTelugu),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF38157F), Color(0xFF6723D4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5A22C5).withValues(alpha: 0.42),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
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

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isTelugu,
    bool showBadge = false,
  }) {
    final isSelected = _currentNavIndex == index;
    final color = isSelected ? const Color(0xFF38157F) : const Color(0xFF64748B);

    return InkWell(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 22),
                if (showBadge)
                  Positioned(
                    top: -1,
                    right: -2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.font(
                isTelugu: isTelugu,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLink {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  _QuickLink({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
