import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agriculture & Crops'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.cropInfo.length,
        itemBuilder: (context, index) {
          final crop = VillageData.cropInfo[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.grass, color: Colors.green, size: 40),
              title: Text(crop['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text("Season: ${crop['season']}"),
              trailing: Text(crop['area'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ).animate().fadeIn(delay: (100 * index).ms).slideX();
        },
      ),
    );
  }
}
