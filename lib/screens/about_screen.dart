import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Kaprai Pally')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://picsum.photos/seed/village_main/600/400',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutCubic).fadeIn(),
            const SizedBox(height: 24),
            Text(
              'History & Heritage',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: kDarkBg,
              ),
            ).animate().fadeIn(delay: 200.ms, curve: Curves.easeOutCubic).slideX(begin: 0.02),
            const SizedBox(height: 12),
            Text(
              VillageData.villageInfo['history'],
              style: TextStyle(fontSize: 15, height: 1.7, color: Colors.grey[700]),
            ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
            const SizedBox(height: 24),
            _buildInfoCard(
              context,
              'Village Statistics',
              [
                'Total Area: ${VillageData.villageInfo['area']}',
                'Total Population: ${VillageData.villageInfo['totalPopulation']}',
                'Total Houses: ${VillageData.villageInfo['numberOfHouses']}',
                'Literacy Rate: ${VillageData.villageInfo['literacyRate']}',
              ],
              Icons.analytics,
            ).animate().fadeIn(delay: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<String> details, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
              Icon(icon, color: kPrimaryRed, size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: kDarkBg),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 12),
          ...details.map((detail) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: kPrimaryRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(detail, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
