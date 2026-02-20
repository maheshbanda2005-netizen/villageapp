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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> menuItems = [
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
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItem(menuItems[index], index);
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
