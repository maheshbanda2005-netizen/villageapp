import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agriculture & Crops')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.cropInfo.length,
        itemBuilder: (context, index) {
          final crop = VillageData.cropInfo[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    color: kPrimaryRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.grass, color: kPrimaryRed, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(crop['name'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: kDarkBg)),
                      const SizedBox(height: 4),
                      Text("Season: ${crop['season']}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: kPrimaryRed.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    crop['area'],
                    style: const TextStyle(fontSize: 12, color: kPrimaryRed, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: (80 * index).ms,
            duration: 350.ms,
            curve: Curves.easeOutCubic,
          ).slideX(begin: 0.03);
        },
      ),
    );
  }
}
