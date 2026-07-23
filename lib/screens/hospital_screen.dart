import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Healthcare Facilities')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.hospitalInfo.length,
        itemBuilder: (context, index) {
          final hospital = VillageData.hospitalInfo[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kPrimaryRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_hospital, color: kPrimaryRed, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital['name'],
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: kDarkBg),
                      ),
                      const SizedBox(height: 6),
                      Text("Location: ${hospital['location']}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                      Text("Staff: ${hospital['staff']}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                      Text("Type: ${hospital['type']}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: (80 * index).ms,
            duration: 350.ms,
            curve: Curves.easeOutCubic,
          ).slideY(begin: 0.05);
        },
      ),
    );
  }
}
