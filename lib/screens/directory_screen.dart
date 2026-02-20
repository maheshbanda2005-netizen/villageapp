import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/village_data.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Directory'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.directoryInfo.length,
        itemBuilder: (context, index) {
          final entry = VillageData.directoryInfo[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getCategoryColor(entry['type']).withOpacity(0.1),
                child: Icon(_getCategoryIcon(entry['type']), color: _getCategoryColor(entry['type'])),
              ),
              title: Text(entry['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(entry['contact']),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => launchUrl(Uri.parse('tel:${entry['contact']}')),
              ),
            ),
          ).animate().fadeIn(delay: (50 * index).ms).scale();
        },
      ),
    );
  }

  Color _getCategoryColor(String type) {
    switch (type) {
      case 'Emergency':
        return Colors.red;
      case 'Safety':
        return Colors.orange;
      case 'Healthcare':
        return Colors.blue;
      case 'Utility':
        return Colors.indigo;
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
