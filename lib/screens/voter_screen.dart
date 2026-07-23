import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/stat_card.dart';
import '../models/village_data.dart';
import '../main.dart';

class VoterScreen extends StatelessWidget {
  const VoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final village = VillageData.villageInfo;

    return Scaffold(
      appBar: AppBar(title: const Text('Voters Information')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kDarkBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.people, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    'Total Population: ${village['totalPopulation']}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutCubic),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                StatCard(
                  title: 'Male Voters',
                  value: village['maleVoters'].toString(),
                  icon: Icons.male,
                  color: const Color(0xFF4A4A4A),
                ).animate().fadeIn(delay: 150.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05),
                StatCard(
                  title: 'Female Voters',
                  value: village['femaleVoters'].toString(),
                  icon: Icons.female,
                  color: kPrimaryRed,
                ).animate().fadeIn(delay: 250.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05),
                StatCard(
                  title: 'Transgender',
                  value: village['transgender'].toString(),
                  icon: Icons.transgender,
                  color: const Color(0xFF6B7280),
                ).animate().fadeIn(delay: 350.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05),
                StatCard(
                  title: 'Children',
                  value: village['children'].toString(),
                  icon: Icons.child_care,
                  color: const Color(0xFF9CA3AF),
                ).animate().fadeIn(delay: 450.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Age Distribution',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg),
                  ),
                  const SizedBox(height: 16),
                  _buildAgeBar('0-18 Years', 35, kPrimaryRed),
                  _buildAgeBar('19-35 Years', 40, const Color(0xFF4A4A4A)),
                  _buildAgeBar('36-60 Years', 18, const Color(0xFF6B7280)),
                  _buildAgeBar('60+ Years', 7, Colors.grey),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeBar(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              Text('$percentage%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
