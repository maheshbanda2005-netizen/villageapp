import 'package:flutter/material.dart';
import '../models/village_model.dart';

class FacilitiesScreen extends StatelessWidget {
  final List<Facility> offices;
  final List<Facility> schools;
  final List<Facility> hospitals;

  const FacilitiesScreen({
    super.key,
    required this.offices,
    required this.schools,
    required this.hospitals,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(icon: Icon(Icons.business), text: "Offices"),
            Tab(icon: Icon(Icons.school), text: "Schools"),
            Tab(icon: Icon(Icons.local_hospital), text: "Hospitals"),
          ],
        ),
        body: TabBarView(
          children: [
            _facilityList(offices),
            _facilityList(schools),
            _facilityList(hospitals),
          ],
        ),
      ),
    );
  }

  Widget _facilityList(List<Facility> facilities) {
    if (facilities.isEmpty) {
      return const Center(child: Text("No data available"));
    }
    return ListView.builder(
      itemCount: facilities.length,
      itemBuilder: (context, index) {
        final facility = facilities[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  facility.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        facility.location,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                if (facility.contact != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(facility.contact!),
                    ],
                  ),
                ],
                if (facility.description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    facility.description!,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
