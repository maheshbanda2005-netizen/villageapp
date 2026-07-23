import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_header.dart';
import '../main.dart';
import 'gallery_screen.dart';
import 'voter_screen.dart';
import 'grampanchayat_screen.dart';
import 'school_screen.dart';
import 'hospital_screen.dart';
import 'land_screen.dart';
import 'crop_screen.dart';
import 'complaint_screen.dart';
import 'services_screen.dart';
import 'directory_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allMenuItems = [
    {
      'title': 'About Village',
      'icon': Icons.info_outline,
      'color': kPrimaryRed,
      'screen': const AboutScreen(),
    },
    {
      'title': 'Voters Information',
      'icon': Icons.people,
      'color': const Color(0xFF4A4A4A),
      'screen': const VoterScreen(),
    },
    {
      'title': 'Gram Panchayat',
      'icon': Icons.location_city,
      'color': kDarkBg,
      'screen': const GrampanchayatScreen(),
    },
    {
      'title': 'Schools',
      'icon': Icons.school,
      'color': const Color(0xFF6B7280),
      'screen': const SchoolScreen(),
    },
    {
      'title': 'Hospitals',
      'icon': Icons.local_hospital,
      'color': kPrimaryRed,
      'screen': const HospitalScreen(),
    },
    {
      'title': 'Lands',
      'icon': Icons.landscape,
      'color': const Color(0xFF4A4A4A),
      'screen': const LandScreen(),
    },
    {
      'title': 'Crops',
      'icon': Icons.grass,
      'color': const Color(0xFF6B7280),
      'screen': const CropScreen(),
    },
    {
      'title': 'Village Services',
      'icon': Icons.settings_suggest,
      'color': kDarkBg,
      'screen': const ServicesScreen(),
    },
    {
      'title': 'Local Directory',
      'icon': Icons.contact_phone,
      'color': kPrimaryRed,
      'screen': const DirectoryScreen(),
    },
    {
      'title': 'Complaints',
      'icon': Icons.report_problem,
      'color': const Color(0xFF4A4A4A),
      'screen': const ComplaintScreen(),
    },
    {
      'title': 'Village Gallery',
      'icon': Icons.photo_library,
      'color': const Color(0xFF6B7280),
      'screen': const GalleryScreen(),
    },
  ];

  late List<Map<String, dynamic>> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = allMenuItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = allMenuItems
          .where((item) =>
              item['title'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kLightBg,
        child: SafeArea(
          child: Column(
            children: [
              const AnimatedHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterItems,
                    decoration: InputDecoration(
                      hintText: 'Search village info...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[400]),
                              onPressed: () {
                                _searchController.clear();
                                _filterItems('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, curve: Curves.easeOutCubic),
              ),
              Expanded(
                child: filteredItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                            const SizedBox(height: 12),
                            Text(
                              'No results found',
                              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return _buildMenuItem(filteredItems[index], index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, int index) {
    final color = item['color'] as Color;
    return Container(
      key: ValueKey(item['title']),
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => item['screen'],
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kDarkBg,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[300],
                  size: 22,
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: (60 * index).ms,
            duration: 350.ms,
            curve: Curves.easeOutCubic,
          ).slideX(
            delay: (60 * index).ms,
            duration: 350.ms,
            begin: 0.08,
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );
  }
}
