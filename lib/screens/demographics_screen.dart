import 'package:flutter/material.dart';
import '../models/village_model.dart';

class DemographicsScreen extends StatelessWidget {
  final Demographics demographics;

  const DemographicsScreen({super.key, required this.demographics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Population Statistics",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _statTile("Total Population", demographics.totalPopulation.toString(), Icons.groups),
              _statTile("Total Houses", demographics.numberOfHouses.toString(), Icons.house),
              _statTile("Registered Voters", demographics.numberOfVoters.toString(), Icons.how_to_vote),
              const SizedBox(height: 30),
              const Text(
                "Age-wise Distribution",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...demographics.ageDistribution.entries.map((entry) {
                return _ageDistributionTile(entry.key, entry.value, demographics.totalPopulation);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statTile(String title, String value, IconData icon) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _ageDistributionTile(String ageGroup, int count, int total) {
    double percentage = count / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ageGroup, style: const TextStyle(fontSize: 16)),
              Text("$count (${(percentage * 100).toStringAsFixed(1)}%)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}
