import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/village_data.dart';
import '../main.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Directory')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.directoryInfo.length,
        itemBuilder: (context, index) {
          final entry = VillageData.directoryInfo[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getCategoryColor(entry['type']).withValues(alpha: 0.08),
                  radius: 22,
                  child: Icon(
                    _getCategoryIcon(entry['type']),
                    color: _getCategoryColor(entry['type']),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: kDarkBg)),
                      const SizedBox(height: 2),
                      Text(entry['contact'], style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.call, color: kPrimaryRed, size: 20),
                    onPressed: () => _makeCall(context, entry['contact']),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: (40 * index).ms,
            duration: 300.ms,
            curve: Curves.easeOutCubic,
          ).scale(begin: const Offset(0.97, 0.97));
        },
      ),
    );
  }

  Future<void> _makeCall(BuildContext context, String contact) async {
    final uri = Uri(scheme: 'tel', path: contact);
    bool launched = false;
    try {
      launched = await launchUrl(uri);
    } catch (_) {
      launched = false;
    }
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not call $contact'), backgroundColor: kDarkBg),
      );
    }
  }

  Color _getCategoryColor(String type) {
    switch (type) {
      case 'Emergency':
        return kPrimaryRed;
      case 'Safety':
        return const Color(0xFF4A4A4A);
      case 'Healthcare':
        return const Color(0xFF6B7280);
      case 'Utility':
        return kDarkBg;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String type) {
    switch (type) {
      case 'Emergency':
        return Icons.emergency;
      case 'Safety':
        return Icons.security;
      case 'Healthcare':
        return Icons.health_and_safety;
      case 'Utility':
        return Icons.settings_suggest;
      default:
        return Icons.person;
    }
  }
}
