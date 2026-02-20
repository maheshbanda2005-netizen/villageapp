import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_header.dart';
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
      'color': Colors.teal,
      'screen': const AboutScreen(),
    },
    {
      'title': 'Voters Information',
      'icon': Icons.people,
      'color': Colors.blue,
      'screen': const VoterScreen(),
    },
    {
      'title': 'Gram Panchayat',
      'icon': Icons.location_city,
      'color': Colors.green,
      'screen': const GrampanchayatScreen(),
    },
    {
      'title': 'Schools',
      'icon': Icons.school,
      'color': Colors.orange,
      'screen': const SchoolScreen(),
    },
    {
      'title': 'Hospitals',
      'icon': Icons.local_hospital,
      'color': Colors.red,
      'screen': const HospitalScreen(),
    },
    {
      'title': 'Lands',
      'icon': Icons.landscape,
      'color': Colors.brown,
      'screen': const LandScreen(),
    },
    {
      'title': 'Crops',
      'icon': Icons.grass,
      'color': Colors.green,
      'screen': const CropScreen(),
    },
    {
      'title': 'Village Services',
      'icon': Icons.settings_suggest,
      'color': Colors.indigo,
      'screen': const ServicesScreen(),
    },
    {
      'title': 'Local Directory',
      'icon': Icons.contact_phone,
      'color': Colors.teal,
      'screen': const DirectoryScreen(),
    },
    {
      'title': 'Complaints',
      'icon': Icons.report_problem,
      'color': Colors.red,
      'screen': const ComplaintScreen(),
    },
    {
      'title': 'Village Gallery',
      'icon': Icons.photo_library,
      'color': Colors.deepPurple,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const AnimatedHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterItems,
                    decoration: InputDecoration(
                      hintText: 'Search village info...',
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ).animate().fadeIn().slideY(begin: -0.2),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
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
    return Container(
      key: ValueKey(item['title']),
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item['screen']),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (item['color'] as Color).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap to view details',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: item['color'] as Color,
                  size: 20,
                ),
              ],
            ),
          ).animate().fadeIn(delay: (100 * index).ms).slideX(),
        ),
      ),
    );
  }
}
