import 'package:flutter/material.dart';
import 'package:mana_gramam/models/service_item.dart';
import 'package:mana_gramam/screens/splash_screen.dart';
import 'package:mana_gramam/utils/app_typography.dart';

class ServicePage extends StatefulWidget {
  final ServiceItem serviceItem;
  final AppLanguage initialLanguage;

  const ServicePage({
    super.key,
    required this.serviceItem,
    this.initialLanguage = AppLanguage.english,
  });

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
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
        child: Column(
          children: [
            // Top App Bar
            _buildTopHeader(isTelugu),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Section
                    _buildHeroSection(isTelugu),

                    // Content Section
                    _buildContentSection(isTelugu),

                    // Quick Actions
                    _buildQuickActions(isTelugu),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            _buildBottomNavigationBar(isTelugu),
          ],
        ),
      ),
      floatingActionButton: _buildVoiceButton(isTelugu),
    );
  }

  Widget _buildVoiceButton(bool isTelugu) {
    return FloatingActionButton(
      onPressed: () => _showVoiceModal(context, isTelugu),
      backgroundColor: const Color(0xFF38157F),
      elevation: 8,
      child: const Icon(Icons.mic_rounded, color: Colors.white),
    );
  }

  Widget _buildTopHeader(bool isTelugu) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back Button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
            color: const Color(0xFF1E1B4B),
          ),

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

  Widget _buildHeroSection(bool isTelugu) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.serviceItem.badgeColor.withValues(alpha: 0.9), widget.serviceItem.badgeColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.serviceItem.badgeColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.serviceItem.badgeIcon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.serviceItem.title,
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.serviceItem.subtitle,
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(bool isTelugu) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isTelugu ? 'సేవలు' : 'Services',
            style: AppTypography.font(
              isTelugu: isTelugu,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1B4B),
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            isTelugu ? 'అధికారిక సమాచారం' : 'Official Information',
            isTelugu ? 'ప్రభుత్వ సమాచారం మరియు నోటిఫికేషన్లు' : 'Government information and notifications',
            Icons.description_rounded,
            isTelugu,
          ),
          const SizedBox(height: 12),
          _buildServiceItem(
            isTelugu ? 'దరఖాస్తులు' : 'Applications',
            isTelugu ? 'ఆన్‌లైన్ దరఖాస్తులు మరియు స్థితి' : 'Online applications and status',
            Icons.file_upload_rounded,
            isTelugu,
          ),
          const SizedBox(height: 12),
          _buildServiceItem(
            isTelugu ? 'సహాయం' : 'Support',
            isTelugu ? 'సహాయం మరియు మార్గదర్శకత్వం' : 'Help and guidance',
            Icons.support_agent_rounded,
            isTelugu,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String subtitle, IconData icon, bool isTelugu) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.serviceItem.badgeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: widget.serviceItem.badgeColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E1B4B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.font(
                    isTelugu: isTelugu,
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFF94A3B8),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isTelugu) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isTelugu ? 'త్వరగా చేయడానికి' : 'Quick Actions',
            style: AppTypography.font(
              isTelugu: isTelugu,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1B4B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  isTelugu ? 'సర్చ్' : 'Search',
                  Icons.search_rounded,
                  isTelugu,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  isTelugu ? 'కాల్' : 'Call',
                  Icons.phone_rounded,
                  isTelugu,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  isTelugu ? 'స్థానం' : 'Location',
                  Icons.location_on_rounded,
                  isTelugu,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, bool isTelugu) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: widget.serviceItem.badgeColor,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.font(
              isTelugu: isTelugu,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1B4B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(bool isTelugu) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: isTelugu ? 'హోమ్' : 'Home',
                isSelected: _currentNavIndex == 0,
                onTap: () {
                  setState(() => _currentNavIndex = 0);
                  Navigator.pop(context);
                },
                isTelugu: isTelugu,
              ),
              _buildNavItem(
                icon: Icons.explore_rounded,
                label: isTelugu ? 'సేవలు' : 'Services',
                isSelected: _currentNavIndex == 1,
                onTap: () => setState(() => _currentNavIndex = 1),
                isTelugu: isTelugu,
              ),
              const SizedBox(width: 56), // Space for FAB
              _buildNavItem(
                icon: Icons.notifications_rounded,
                label: isTelugu ? 'నోటిఫికేషన్లు' : 'Alerts',
                isSelected: _currentNavIndex == 2,
                onTap: () => setState(() => _currentNavIndex = 2),
                isTelugu: isTelugu,
              ),
              _buildNavItem(
                icon: Icons.person_rounded,
                label: isTelugu ? 'ప్రొఫైల్' : 'Profile',
                isSelected: _currentNavIndex == 3,
                onTap: () => setState(() => _currentNavIndex = 3),
                isTelugu: isTelugu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isTelugu,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF38157F).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF38157F) : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.font(
                isTelugu: isTelugu,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF38157F) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}