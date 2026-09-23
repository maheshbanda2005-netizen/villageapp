import 'package:flutter/material.dart';
import 'package:mana_gramam/screens/home_screen.dart';
import 'package:mana_gramam/utils/app_typography.dart';

enum AppLanguage { english, telugu }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppLanguage _selectedLanguage = AppLanguage.english;
  int _activeDotIndex = 0;

  void _setLanguage(AppLanguage language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(initialLanguage: _selectedLanguage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTelugu = _selectedLanguage == AppLanguage.telugu;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background village landscape photo
          Positioned.fill(
            child: Image.asset(
              'assets/images/village_bg.jpg',
              fit: BoxFit.cover,
              alignment: const Alignment(0.0, -0.15),
            ),
          ),

          // 2. Soft top gradient overlay for crystal clear header text readability
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 310,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.94),
                    Colors.white.withValues(alpha: 0.82),
                    Colors.white.withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.8, 1.0],
                ),
              ),
            ),
          ),

          // 3. Main content area
          Column(
            children: [
              // Top Header: Logo + App Name + Slogan
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo circle with subtle shadow
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/mana_gramam_logo.png',
                          width: 96,
                          height: 96,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // "Mana Gramam" Title
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF221356), Color(0xFF3F198C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          isTelugu ? 'మన గ్రామం' : 'Mana Gramam',
                          style: AppTypography.font(
                            isTelugu: isTelugu,
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Tagline
                      Text(
                        isTelugu
                            ? 'స్మార్ట్ గ్రామం  •  బలమైన రేపు'
                            : 'Smart Village  •  Stronger Tomorrow',
                        style: AppTypography.font(
                          isTelugu: isTelugu,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Curved Welcome Card
              CurvedBottomCard(
                isTelugu: isTelugu,
                selectedLanguage: _selectedLanguage,
                activeDotIndex: _activeDotIndex,
                onLanguageChanged: _setLanguage,
                onGetStarted: _navigateToHome,
                onDotTapped: (index) {
                  setState(() {
                    _activeDotIndex = index;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The bottom white sheet with convex curved top arch and decorative lavender wave
class CurvedBottomCard extends StatelessWidget {
  final bool isTelugu;
  final AppLanguage selectedLanguage;
  final int activeDotIndex;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final VoidCallback onGetStarted;
  final ValueChanged<int> onDotTapped;

  const CurvedBottomCard({
    super.key,
    required this.isTelugu,
    required this.selectedLanguage,
    required this.activeDotIndex,
    required this.onLanguageChanged,
    required this.onGetStarted,
    required this.onDotTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ConvexTopClipper(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            // Delicate bottom lavender decorative wave
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 70,
              child: CustomPaint(
                painter: BottomWaveDecorationPainter(),
              ),
            ),

            // Card content
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // "Welcome to"
                    Text(
                      isTelugu ? 'స్వాగతం' : 'Welcome to',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E293B),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // "Mana Gramam"
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF2C1371), Color(0xFF5D24C7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        isTelugu ? 'మన గ్రామం' : 'Mana Gramam',
                        style: AppTypography.font(
                          isTelugu: isTelugu,
                          fontSize: 27,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // "Your Village • Your Services • Your Information"
                    Text(
                      isTelugu
                          ? 'మీ గ్రామం  •  మీ సేవలు  •  మీ సమాచారం'
                          : 'Your Village  •  Your Services  •  Your Information',
                      style: AppTypography.font(
                        isTelugu: isTelugu,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Language Selector Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: LanguagePillButton(
                            title: 'English',
                            icon: Icons.language_rounded,
                            isSelected: selectedLanguage == AppLanguage.english,
                            isTelugu: isTelugu,
                            onTap: () => onLanguageChanged(AppLanguage.english),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: LanguagePillButton(
                            title: 'తెలుగు',
                            icon: Icons.sync_rounded,
                            isSelected: selectedLanguage == AppLanguage.telugu,
                            isTelugu: isTelugu,
                            onTap: () => onLanguageChanged(AppLanguage.telugu),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // "Get Started →" Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF38157F), Color(0xFF6627E5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5C24D5).withValues(alpha: 0.38),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: onGetStarted,
                            splashColor: Colors.white.withValues(alpha: 0.2),
                            highlightColor: Colors.white.withValues(alpha: 0.1),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isTelugu ? 'ప్రారంభించండి' : 'Get Started',
                                    style: AppTypography.font(
                                      isTelugu: isTelugu,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Dot page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final isActive = index == activeDotIndex;
                        return GestureDetector(
                          onTap: () => onDotTapped(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.5),
                            width: 7.5,
                            height: 7.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? const Color(0xFF5A22C5)
                                  : const Color(0xFFD6CEE8),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Language pill button supporting active gradient fill and inactive purple outline
class LanguagePillButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool isTelugu;
  final VoidCallback onTap;

  const LanguagePillButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.isTelugu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF38157F), Color(0xFF6627E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isSelected ? null : Colors.white,
        border: isSelected
            ? null
            : Border.all(
                color: const Color(0xFF6627E5),
                width: 1.5,
              ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF5C24D5).withValues(alpha: 0.32),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          splashColor: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : const Color(0xFF6627E5).withValues(alpha: 0.1),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? Colors.white : const Color(0xFF6627E5),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTypography.font(
                    isTelugu: title == 'తెలుగు',
                    color: isSelected ? Colors.white : const Color(0xFF6627E5),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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

/// Custom clipper to create the smooth convex arched top edge of the card
class ConvexTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Starts at Y = 28 on the left, arches up to Y = -6 at center, then back down to Y = 28 on the right
    path.moveTo(0, 28);
    path.quadraticBezierTo(size.width / 2, -6, size.width, 28);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Custom painter to draw the decorative subtle lavender waves at the bottom of the card
class BottomWaveDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Upper subtle wave
    final paint1 = Paint()
      ..color = const Color(0xFFF2EDFC).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height - 24);
    path1.quadraticBezierTo(
      size.width * 0.35,
      size.height - 45,
      size.width * 0.68,
      size.height - 18,
    );
    path1.quadraticBezierTo(
      size.width * 0.88,
      size.height - 4,
      size.width,
      size.height - 15,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Lower subtle wave
    final paint2 = Paint()
      ..color = const Color(0xFFEBE3FB).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height - 8);
    path2.quadraticBezierTo(
      size.width * 0.45,
      size.height - 28,
      size.width * 0.78,
      size.height - 10,
    );
    path2.quadraticBezierTo(
      size.width * 0.92,
      size.height,
      size.width,
      size.height - 4,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
