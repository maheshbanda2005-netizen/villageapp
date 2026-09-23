import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 11: EDUCATION & COURSE DETAILS
/// Matches 11a (Learning & Courses) and 11b (Course Details) in design board:
/// - 11a: 6 learning module cards (Learn Skills, Scholarships, Govt Exams, Skill Courses, Career Guidance, Education News)
/// - 11b: Course Details with classroom photo, beginner tags, syllabus checklist, and "Start Course" CTA
class EducationScreen extends StatelessWidget {
  final bool isTelugu;
  const EducationScreen({super.key, this.isTelugu = false});

  void _openCourseDetails(BuildContext context, bool isTe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 44, height: 5, decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(height: 16),

              // Course Photo (11b)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.asset(
                    'assets/images/service_education.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.blue),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.purpleSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Beginner', style: TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w800, fontSize: 11)),
                  ),
                  const SizedBox(width: 8),
                  const Text('10 Lessons • 2.5 hrs', style: TextStyle(fontSize: 12, color: ManaColors.muted, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.leaf.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.download_done_rounded, size: 14, color: ManaColors.leaf),
                        SizedBox(width: 4),
                        Text('Available Offline', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ManaColors.leaf)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ManaText(
                isTe ? 'ప్రాథమిక కంప్యూటర్ & స్మార్ట్‌ఫోన్ నైపుణ్యాలు' : 'Basic Computer Skills',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
              ),

              const SizedBox(height: 14),

              // Checklist (11b): Office Tools, Internet, Digital Safety
              _buildChecklistItem(Icons.business_center_rounded, 'Office Tools (Word, Excel, Typing)'),
              const SizedBox(height: 8),
              _buildChecklistItem(Icons.language_rounded, 'Internet, Email & Govt Portals'),
              const SizedBox(height: 8),
              _buildChecklistItem(Icons.security_rounded, 'Digital Safety & UPI Fraud Protection'),

              const SizedBox(height: 22),

              // Large Purple "Start Course" CTA
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Starting Lesson 1: Introduction to Computers'), backgroundColor: ManaColors.purple),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: ManaText(
                    isTe ? 'కోర్సు ప్రారంభించండి' : 'Start Course',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChecklistItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ManaColors.purpleSoft,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ManaColors.purple, size: 16),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ManaColors.navy),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = isTelugu;

    final List<Map<String, dynamic>> eduCards = [
      {'title': 'Learn Skills', 'titleTe': 'నైపుణ్యాలు', 'icon': Icons.lightbulb_outline_rounded, 'color': ManaColors.purple},
      {'title': 'Scholarships', 'titleTe': 'స్కాలర్‌షిప్‌లు', 'icon': Icons.card_giftcard_rounded, 'color': ManaColors.orange},
      {'title': 'Govt. Exams', 'titleTe': 'ప్రభుత్వ పరీక్షలు', 'icon': Icons.menu_book_rounded, 'color': ManaColors.blue},
      {'title': 'Skill Courses', 'titleTe': 'సర్టిఫికెట్ కోర్సులు', 'icon': Icons.laptop_chromebook_rounded, 'color': ManaColors.leaf},
      {'title': 'Career Guidance', 'titleTe': 'కెరీర్ గైడెన్స్', 'icon': Icons.explore_outlined, 'color': ManaColors.navy},
      {'title': 'Education News', 'titleTe': 'విద్యా వార్తలు', 'icon': Icons.newspaper_rounded, 'color': ManaColors.coral},
    ];

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'విద్య & నైపుణ్యాలు' : 'Education',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ManaColors.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // 6 Large Educational Cards (11a)
          FadeSlideIn(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: eduCards.length,
              itemBuilder: (context, i) {
                final c = eduCards[i];
                final color = c['color'] as Color;
                return InkWell(
                  onTap: () => _openCourseDetails(context, isTe),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ManaColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ManaColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(c['icon'] as IconData, color: color, size: 20),
                        ),
                        Text(
                          isTe ? c['titleTe'] as String : c['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Featured Course Card (11b preview)
          FadeSlideIn(
            delayMs: 60,
            child: InkWell(
              onTap: () => _openCourseDetails(context, isTe),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: ManaColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ManaColors.purpleSoft),
                  boxShadow: [
                    BoxShadow(
                      color: ManaColors.purple.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ManaColors.purpleSoft,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Beginner • 10 Lessons', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: ManaColors.purple)),
                        ),
                        const Spacer(),
                        const Text('Available Offline', style: TextStyle(fontSize: 11, color: ManaColors.leaf, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const ManaText(
                      'Basic Computer Skills',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ManaColors.navy),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Office Tools, Internet Browsing, Digital Safety & Online Certificate.',
                      style: TextStyle(fontSize: 13, color: ManaColors.muted),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => _openCourseDetails(context, isTe),
                        style: FilledButton.styleFrom(
                          backgroundColor: ManaColors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Start Course', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
