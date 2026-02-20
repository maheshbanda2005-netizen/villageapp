import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/stat_card.dart';
import '../models/village_data.dart';

class VoterScreen extends StatelessWidget {
  const VoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final village = VillageData.villageInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voters Information'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with Animation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.people,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total Population: ${village['totalPopulation']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().scale(duration: 600.ms),

            const SizedBox(height: 20),

            // Statistics Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                StatCard(
                  title: 'Male Voters',
                  value: village['maleVoters'].toString(),
                  icon: Icons.male,
                  color: Colors.blue,
                ).animate().fadeIn(delay: 200.ms).slideY(),

                StatCard(
                  title: 'Female Voters',
                  value: village['femaleVoters'].toString(),
                  icon: Icons.female,
                  color: Colors.pink,
                ).animate().fadeIn(delay: 300.ms).slideY(),

                StatCard(
                  title: 'Transgender',
                  value: village['transgender'].toString(),
                  icon: Icons.transgender,
                  color: Colors.purple,
                ).animate().fadeIn(delay: 400.ms).slideY(),

                StatCard(
                  title: 'Children',
                  value: village['children'].toString(),
                  icon: Icons.child_care,
                  color: Colors.orange,
                ).animate().fadeIn(delay: 500.ms).slideY(),
              ],
            ),

            const SizedBox(height: 20),

            // Age Distribution Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Age Distribution',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAgeBar('0-18 Years', 35, Colors.blue),
                  _buildAgeBar('19-35 Years', 40, Colors.green),
                  _buildAgeBar('36-60 Years', 18, Colors.orange),
                  _buildAgeBar('60+ Years', 7, Colors.red),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeBar(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('$percentage%'),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
