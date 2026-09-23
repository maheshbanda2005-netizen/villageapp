import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Land Details')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.landInfo.length,
        itemBuilder: (context, index) {
          final land = VillageData.landInfo[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      land['type'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kPrimaryRed.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.landscape, color: kPrimaryRed, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade100, height: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat("Area", land['area']),
                    _buildStat("Owners", land['owners'].toString()),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: (80 * index).ms,
            duration: 350.ms,
            curve: Curves.easeOutCubic,
          ).scale(begin: const Offset(0.97, 0.97));
        },
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
      ],
    );
  }
}
