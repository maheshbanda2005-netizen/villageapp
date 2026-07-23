import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/village_data.dart';
import '../main.dart';

class GrampanchayatScreen extends StatelessWidget {
  const GrampanchayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gp = VillageData.gramPanchayatInfo;

    return Scaffold(
      appBar: AppBar(title: const Text('Gram Panchayat')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kDarkBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.location_city, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    gp['officeName'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    gp['sarpanch'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutCubic),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Street Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    gp['streets'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: kPrimaryRed.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryRed,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gp['streets'][index]['name'],
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                                Text(
                                  'Houses: ${gp['streets'][index]['houses']}',
                                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${gp['streets'][index]['families']} Families',
                              style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (80 * index).ms, curve: Curves.easeOutCubic).slideX(begin: 0.03),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 150.ms, curve: Curves.easeOutCubic),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBg),
                  ),
                  const SizedBox(height: 16),
                  _buildContactRow(Icons.phone, gp['phone'], () => launchUrl(Uri.parse('tel:${gp['phone']}'))),
                  _buildContactRow(Icons.email, gp['email'], () => launchUrl(Uri.parse('mailto:${gp['email']}'))),
                  _buildContactRow(Icons.access_time, gp['timing'], null),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(icon, color: kPrimaryRed, size: 20),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
