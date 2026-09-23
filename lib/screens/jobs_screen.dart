import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 10: LOCAL JOBS & JOB DETAILS
/// Matches 10a (Local Jobs) & 10b (Job Details) in the design board:
/// - 10a: Local Jobs with Filter Chips (Nearby, Today, Part-time, Full-time), Job Cards, Post a Job CTA
/// - 10b: Job Details modal with Field Photo, Salary, Workers needed, Date, Call & Apply buttons
class JobsScreen extends StatefulWidget {
  final bool isTelugu;
  const JobsScreen({super.key, this.isTelugu = false});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String _selectedFilter = 'Nearby';
  final List<String> _filters = ['Nearby', 'Today', 'Part-time', 'Full-time'];

  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Farm Worker',
      'titleTe': 'వ్యవసాయ కూలీ',
      'employer': 'Reddy Mango Orchards',
      'location': 'Kothapally East',
      'distance': '3 km',
      'salary': '₹700 / day',
      'workersNeeded': '2 workers required',
      'date': 'Tomorrow',
      'category': 'Farm work',
      'phone': '+91 94401 12345',
      'image': 'assets/images/service_jobs.jpg',
      'desc': 'Harvesting and weeding in mango orchard. Lunch and drinking water provided by farm owner.',
    },
    {
      'title': 'Electrician',
      'titleTe': 'ఎలక్ట్రీషియన్',
      'employer': 'Panchayat Borewell Maintenance',
      'location': 'Your Village',
      'distance': '500 m',
      'salary': '₹500 / day',
      'workersNeeded': '1 worker required',
      'date': 'Today',
      'category': 'Electrical work',
      'phone': '+91 99000 88776',
      'image': 'assets/images/service_jobs.jpg',
      'desc': 'Starter switchboard repair and single-phase motor wiring check.',
    },
    {
      'title': 'Driver',
      'titleTe': 'డ్రైవర్ (ట్రాక్టర్ & కార్)',
      'employer': 'Sri Balaji Agro Supply',
      'location': 'Ghatkesar Road',
      'distance': '5 km',
      'salary': '₹1,000 / day',
      'workersNeeded': '1 driver required',
      'date': 'Today',
      'category': 'Transport work',
      'phone': '+91 98480 33221',
      'image': 'assets/images/service_jobs.jpg',
      'desc': 'Tractor driving for fertilizer transport from Ghatkesar godown to Kothapally village center.',
    },
    {
      'title': 'Construction Worker',
      'titleTe': 'భవన నిర్మాణ కూలీ',
      'employer': 'Panchayat Community Hall Project',
      'location': 'Near ZP High School',
      'distance': '800 m',
      'salary': '₹850 / day',
      'workersNeeded': '4 workers required',
      'date': 'Tomorrow',
      'category': 'Construction work',
      'phone': '+91 97000 44556',
      'image': 'assets/images/service_jobs.jpg',
      'desc': 'Mason helper, brick loading, and cement mixing work.',
    },
  ];

  void _openJobDetails(Map<String, dynamic> job, bool isTe) {
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

              // Job Details Hero Photo (10b)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.asset(
                    job['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.purple),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.purpleSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      job['salary'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: ManaColors.purple),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 16, color: ManaColors.muted),
                  const SizedBox(width: 4),
                  Text('${job['location']} • ${job['distance']}', style: const TextStyle(fontSize: 13, color: ManaColors.muted)),
                ],
              ),
              const SizedBox(height: 14),

              // Meta Tags (10b): Workers needed, Date, Category
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTag(Icons.people_outline_rounded, job['workersNeeded'] as String),
                  _buildTag(Icons.calendar_today_rounded, job['date'] as String),
                  _buildTag(Icons.work_outline_rounded, job['category'] as String),
                ],
              ),

              const SizedBox(height: 14),
              Text(
                job['desc'] as String,
                style: const TextStyle(fontSize: 13, color: ManaColors.text, height: 1.4),
              ),

              const SizedBox(height: 22),

              // Two prominent buttons: Call & Apply (10b)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling employer at ${job['phone']}...')),
                        );
                      },
                      icon: const Icon(Icons.phone_rounded, color: ManaColors.purple),
                      label: ManaText(
                        isTe ? 'కాల్ చేయండి' : 'Call',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.purple),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ManaColors.purple, width: 1.5),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Applied for ${job['title']}! Employer will contact you shortly.'),
                            backgroundColor: ManaColors.purple,
                          ),
                        );
                      },
                      icon: const Icon(Icons.send_rounded),
                      label: ManaText(
                        isTe ? 'దరఖాస్తు చేయండి' : 'Apply',
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ManaColors.bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ManaColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: ManaColors.purple),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: ManaColors.navy)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'స్థానిక ఉద్యోగాలు' : 'Local Jobs',
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
              // Filter Chips: Nearby, Today, Part-time, Full-time
              FadeSlideIn(
                child: SizedBox(
                  height: 40,
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

              // Job Cards
              ..._jobs.map((job) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => _openJobDetails(job, isTe),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ManaColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: ManaColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  job['title'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
                                ),
                              ),
                              Text(
                                job['salary'] as String,
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: ManaColors.purple),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${job['distance']} • ${job['workersNeeded']} • ${job['date']}',
                            style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                job['employer'] as String,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: ManaColors.navy),
                              ),
                              const Spacer(),
                              FilledButton(
                                onPressed: () => _openJobDetails(job, isTe),
                                style: FilledButton.styleFrom(
                                  backgroundColor: ManaColors.purple,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Contact', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),

          // Bottom Fixed "Post a Job" Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post a Job form opened.'), backgroundColor: ManaColors.purple),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: ManaText(
                isTe ? 'ఉద్యోగం ప్రకటించండి' : 'Post a Job',
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
