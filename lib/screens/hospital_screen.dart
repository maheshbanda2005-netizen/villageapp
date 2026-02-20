import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/village_data.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Facilities'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: VillageData.hospitalInfo.length,
        itemBuilder: (context, index) {
          final hospital = VillageData.hospitalInfo[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.local_hospital, color: Colors.white),
              ),
              title: Text(
                hospital['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("Location: ${hospital['location']}"),
                  Text("Staff: ${hospital['staff']}"),
                  Text("Type: ${hospital['type']}"),
                ],
              ),
            ),
          ).animate().fadeIn(delay: (100 * index).ms).slideY();
        },
      ),
    );
  }
}
