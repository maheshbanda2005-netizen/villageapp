import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 14: LOCAL BUSINESSES & BUSINESS DETAILS
/// Matches 14a (Business Directory) & 14b (Business Details) in design board:
/// - 14a: Filter Chips (All, Shops, Services), Cards with distance, verified badge, Call/Directions
/// - 14b: Business Details modal with Shop Photo, Category, Verified status, Call & Directions CTAs
class BusinessesScreen extends StatefulWidget {
  final bool isTelugu;
  const BusinessesScreen({super.key, this.isTelugu = false});

  @override
  State<BusinessesScreen> createState() => _BusinessesScreenState();
}

class _BusinessesScreenState extends State<BusinessesScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Shops', 'Services'];

  final List<Map<String, dynamic>> _businesses = [
    {
      'name': 'Ravi Electricals',
      'nameTe': 'రవి ఎలక్ట్రికల్స్ & రిపేర్స్',
      'category': 'Electrical',
      'type': 'Services',
      'distance': '1.5 km',
      'status': 'Open • Verified Merchant',
      'phone': '+91 98480 88776',
      'verified': true,
      'image': 'assets/images/shop_ravi.jpg',
      'services': 'Motor rewinding, farm pump starter repair, home wiring & spares',
    },
    {
      'name': 'Sri Sai Medicals',
      'nameTe': 'శ్రీ సాయి మెడికల్స్ & ఫార్మసీ',
      'category': 'Pharmacy',
      'type': 'Shops',
      'distance': '2.1 km',
      'status': 'Open • Pharmacist On Duty',
      'phone': '+91 94401 55667',
      'verified': true,
      'image': 'assets/images/service_healthcare.jpg',
      'services': 'Prescription medicines, BP checks, infant nutrition & first aid',
    },
    {
      'name': 'Auto Garage & Tyre Works',
      'nameTe': 'ఆటో గ్యారేజ్ & ట్రాక్టర్ రిపేర్స్',
      'category': 'Mechanic',
      'type': 'Services',
      'distance': '800 m',
      'status': 'Open • Quick Puncture & Oil',
      'phone': '+91 97000 22334',
      'verified': false,
      'image': 'assets/images/service_jobs.jpg',
      'services': 'Tractor tyre puncture, motorcycle servicing & oil change',
    },
  ];

  void _openBusinessDetails(Map<String, dynamic> b, bool isTe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 44, height: 5, decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(height: 16),

              // Shop Front Photo (14b)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.asset(
                    b['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.purple),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      b['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
                    ),
                  ),
                  if (b['verified'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: ManaColors.blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_rounded, size: 14, color: ManaColors.blue),
                          SizedBox(width: 4),
                          Text('Verified', style: TextStyle(color: ManaColors.blue, fontWeight: FontWeight.w800, fontSize: 11)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${b['category']} • ${b['distance']} away',
                style: const TextStyle(fontSize: 13, color: ManaColors.muted, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                b['status'] as String,
                style: const TextStyle(fontSize: 13, color: ManaColors.leaf, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                'Services: ${b['services']}',
                style: const TextStyle(fontSize: 13, color: ManaColors.text, height: 1.4),
              ),

              const SizedBox(height: 22),

              // Action Buttons: Call & Directions (14b)
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${b['name']} (${b['phone']})...')),
                        );
                      },
                      icon: const Icon(Icons.phone_rounded),
                      label: ManaText(
                        isTe ? 'కాల్ చేయండి' : 'Call',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Navigating to ${b['name']} on Village Map...')),
                        );
                      },
                      icon: const Icon(Icons.directions_rounded, color: ManaColors.navy),
                      label: ManaText(
                        isTe ? 'దారి చూపండి' : 'Directions',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ManaColors.navy, width: 1.5),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;
    final filtered = _selectedFilter == 'All'
        ? _businesses
        : _businesses.where((b) => b['type'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'వ్యాపారాల డైరెక్టరీ' : 'Business Directory',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ManaColors.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
            children: [
              // Filter Chips (14a: All, Shops, Services)
              FadeSlideIn(
                child: SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, i) {
                      final f = _filters[i];
                      final isSelected = _selectedFilter == f;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(f, style: TextStyle(fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600, fontSize: 13)),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _selectedFilter = f),
                          selectedColor: ManaColors.purple,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : ManaColors.navy),
                          backgroundColor: ManaColors.surface,
                          side: BorderSide(color: isSelected ? ManaColors.purple : ManaColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Business Cards
              ...filtered.map((b) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => _openBusinessDetails(b, isTe),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: ManaColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: ManaColors.border),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset(
                                b['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.teal),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        b['name'] as String,
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                                      ),
                                    ),
                                    if (b['verified'] == true)
                                      const Icon(Icons.verified_rounded, size: 16, color: ManaColors.blue),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${b['category']} • ${b['distance']}',
                                  style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  b['status'] as String,
                                  style: const TextStyle(fontSize: 12, color: ManaColors.leaf, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),

          // Bottom Fixed "Register My Business" Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Register My Business form opened.'),
                    backgroundColor: ManaColors.purple,
                  ),
                );
              },
              icon: const Icon(Icons.add_business_rounded),
              label: ManaText(
                isTe ? 'వ్యాపారాన్ని నమోదు చేయండి' : 'Register My Business',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: ManaColors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
