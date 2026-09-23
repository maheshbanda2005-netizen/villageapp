import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';
import '../main.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Village Services')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.servicesInfo.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(VillageData.servicesInfo[index], index);
        },
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getIcon(service['icon']), color: kPrimaryRed, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: kPrimaryRed.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        service['status'],
                        style: const TextStyle(color: kPrimaryRed, fontWeight: FontWeight.w600, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 14),
          Text(
            service['description'],
            style: TextStyle(color: Colors.grey[600], height: 1.5, fontSize: 14),
          ),
        ],
      ),
    ).animate().fadeIn(
      delay: (80 * index).ms,
      duration: 350.ms,
      curve: Curves.easeOutCubic,
    ).slideX(begin: 0.03);
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'bolt':
        return Icons.bolt;
      case 'delete_sweep':
        return Icons.delete_sweep;
      case 'lightbulb':
        return Icons.lightbulb;
      default:
        return Icons.help_outline;
    }
  }
}
