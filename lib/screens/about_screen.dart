import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Kaprai Pally'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://picsum.photos/seed/village_main/600/400',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ).animate().scale().fadeIn(),
            ),
            const SizedBox(height: 24),
            Text(
              'History & Heritage',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
            ).animate().fadeIn(delay: 200.ms).slideX(),
            const SizedBox(height: 12),
            Text(
              VillageData.history,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 24),
            _buildInfoCard(
              context,
              'Village Statistics',
              [
                'Total Area: ${VillageData.geographicInfo['total_area']}',
                'Total Population: ${VillageData.population}',
                'Total Houses: ${VillageData.houses}',
                'Literacy Rate: ${VillageData.literacyRate}',
              ],
              Icons.analytics,
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<String> details, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Divider(),
            ...details.map((detail) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(detail, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
