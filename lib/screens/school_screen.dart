import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  final List<String> schoolImages = [
    'https://picsum.photos/seed/school1/600/400',
    'https://picsum.photos/seed/school2/600/400',
    'https://picsum.photos/seed/school3/600/400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schools Information')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeOutCubic,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: schoolImages.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ).animate().fadeIn(duration: 500.ms, curve: Curves.easeOutCubic).scale(begin: const Offset(0.95, 0.95)),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Local Schools',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kDarkBg),
                  ),
                  const SizedBox(height: 16),
                  ...VillageData.schoolInfo.map((school) => _buildSchoolCard(school)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchoolCard(Map<String, dynamic> school) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.school, color: kPrimaryRed, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  school['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kDarkBg),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.location_on, school['location']),
          const SizedBox(height: 6),
          _buildDetailRow(Icons.people, '${school['students']} Students'),
          const SizedBox(height: 6),
          _buildDetailRow(Icons.person, '${school['teachers']} Teachers'),
        ],
      ),
    ).animate().slideX(duration: 350.ms, curve: Curves.easeOutCubic).fadeIn();
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[400]),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}
