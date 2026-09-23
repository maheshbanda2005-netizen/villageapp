import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 18: ADMIN DASHBOARD (Panchayat Administrative Web/Desktop & Mobile Console)
/// Enterprise dashboard for Sarpanch, Panchayat Secretary, and District Village Administrators.
class AdminDashboardScreen extends StatefulWidget {
  final bool isTelugu;
  const AdminDashboardScreen({super.key, this.isTelugu = false});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedNavIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard_rounded},
    {'title': 'Users & Citizens', 'icon': Icons.people_alt_rounded},
    {'title': 'Villages', 'icon': Icons.holiday_village_rounded},
    {'title': 'Complaints', 'icon': Icons.report_problem_rounded},
    {'title': 'Panchayat', 'icon': Icons.account_balance_rounded},
    {'title': 'Village Assets', 'icon': Icons.water_drop_rounded},
    {'title': 'Agriculture', 'icon': Icons.agriculture_rounded},
    {'title': 'Healthcare', 'icon': Icons.local_hospital_rounded},
    {'title': 'Jobs', 'icon': Icons.work_rounded},
    {'title': 'Businesses', 'icon': Icons.storefront_rounded},
    {'title': 'Marketplace', 'icon': Icons.shopping_bag_rounded},
    {'title': 'Education', 'icon': Icons.school_rounded},
    {'title': 'Govt Schemes', 'icon': Icons.payments_rounded},
    {'title': 'Notifications', 'icon': Icons.notifications_rounded},
    {'title': 'Analytics', 'icon': Icons.bar_chart_rounded},
    {'title': 'Settings', 'icon': Icons.settings_rounded},
  ];

  final List<Map<String, dynamic>> _summaryCards = [
    {
      'title': 'Total Citizens',
      'value': '1,240',
      'delta': '+12% this month',
      'icon': Icons.group_rounded,
      'color': ManaColors.navy,
      'accent': ManaColors.purple,
    },
    {
      'title': 'Total Complaints',
      'value': '126',
      'delta': '18 pending',
      'icon': Icons.report_problem_rounded,
      'color': ManaColors.orange,
      'accent': ManaColors.orange,
    },
    {
      'title': 'Resolved Issues',
      'value': '98',
      'delta': '78% resolution rate',
      'icon': Icons.check_circle_rounded,
      'color': ManaColors.blue,
      'accent': ManaColors.blue,
    },
    {
      'title': 'In Progress',
      'value': '21',
      'delta': 'Target: < 48 hrs',
      'icon': Icons.pending_actions_rounded,
      'color': ManaColors.purple,
      'accent': ManaColors.purple,
    },
    {
      'title': 'Active Jobs',
      'value': '32',
      'delta': '8 filled this week',
      'icon': Icons.work_rounded,
      'color': ManaColors.navy,
      'accent': ManaColors.leaf,
    },
    {
      'title': 'Registered Businesses',
      'value': '84',
      'delta': '6 awaiting review',
      'icon': Icons.storefront_rounded,
      'color': ManaColors.blue,
      'accent': ManaColors.orange,
    },
  ];

  final List<Map<String, dynamic>> _recentActivity = [
    {
      'title': 'Water leakage complaint registered at Ward 4',
      'time': '12 mins ago',
      'category': 'Water Works',
      'badge': 'Urgent',
      'color': ManaColors.danger,
    },
    {
      'title': 'Sri Lakshmi Kirana business license verified',
      'time': '45 mins ago',
      'category': 'Business',
      'badge': 'Verified',
      'color': ManaColors.blue,
    },
    {
      'title': '2 Harvester operator jobs posted by Reddy Farms',
      'time': '2 hours ago',
      'category': 'Jobs',
      'badge': 'New Job',
      'color': ManaColors.purple,
    },
    {
      'title': 'Panchayat Yellow Weather Alert broadcasted',
      'time': '4 hours ago',
      'category': 'Broadcast',
      'badge': 'Notice',
      'color': ManaColors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        backgroundColor: ManaColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ManaColors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'ADMIN CONSOLE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: ManaText(
                'Kothapally Gram Panchayat',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_none_rounded, color: ManaColors.navy),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: ManaColors.navy,
              child: Text('SA', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar (if Desktop screen)
          if (isDesktop)
            Container(
              width: 240,
              decoration: const BoxDecoration(
                color: ManaColors.surface,
                border: Border(right: BorderSide(color: ManaColors.border)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: _navItems.length,
                itemBuilder: (context, i) {
                  final item = _navItems[i];
                  final active = _selectedNavIndex == i;
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      item['icon'] as IconData,
                      color: active ? ManaColors.purple : ManaColors.muted,
                      size: 20,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: active ? ManaColors.purple : ManaColors.text,
                        fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    tileColor: active ? ManaColors.purpleSoft.withValues(alpha: 0.4) : null,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: () => setState(() => _selectedNavIndex = i),
                  );
                },
              ),
            ),

          // Main Dashboard Workspace
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Top Search & Quick Action bar
                FadeSlideIn(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search grievances, citizens, asset ID, or survey number…',
                            prefixIcon: const Icon(Icons.search_rounded, color: ManaColors.muted),
                            filled: true,
                            fillColor: ManaColors.surface,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: ManaColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: ManaColors.border),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Panchayat Public Announcement Broadcast Composer opened.'),
                              backgroundColor: ManaColors.purple,
                            ),
                          );
                        },
                        icon: const Icon(Icons.campaign_rounded, size: 18),
                        label: const ManaText('Broadcast Notice', style: TextStyle(fontWeight: FontWeight.w700)),
                        style: FilledButton.styleFrom(
                          backgroundColor: ManaColors.purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 6 Metrics Summary Cards Grid
                FadeSlideIn(
                  delayMs: 60,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: isDesktop ? 2.0 : 1.35,
                    ),
                    itemCount: _summaryCards.length,
                    itemBuilder: (context, i) {
                      final c = _summaryCards[i];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ManaColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: ManaColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  c['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: ManaColors.muted,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: (c['accent'] as Color).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 18),
                                ),
                              ],
                            ),
                            Text(
                              c['value'] as String,
                              style: TextStyle(
                                fontSize: isDesktop ? 28 : 22,
                                fontWeight: FontWeight.w900,
                                color: ManaColors.navy,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              c['delta'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: (c['accent'] as Color),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Complaint Analytics & Status Bars
                FadeSlideIn(
                  delayMs: 120,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ManaColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ManaColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ManaText(
                              'Complaints Resolution by Category',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: ManaColors.purpleSoft,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Avg. Resolution: 34h',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: ManaColors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _CategoryBar(title: 'Drinking Water & Borewells', pct: 0.42, count: 53, color: ManaColors.blue),
                        const SizedBox(height: 12),
                        _CategoryBar(title: 'Roads & Drainage Works', pct: 0.28, count: 35, color: ManaColors.navy),
                        const SizedBox(height: 12),
                        _CategoryBar(title: 'Streetlights & Electrical', pct: 0.18, count: 23, color: ManaColors.orange),
                        const SizedBox(height: 12),
                        _CategoryBar(title: 'Primary Health Center & Sanitation', pct: 0.12, count: 15, color: ManaColors.danger),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Recent Civic Activity Feed
                FadeSlideIn(
                  delayMs: 160,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ManaColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ManaColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ManaText(
                          'Recent Civic Activity & Village Logs',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(_recentActivity.length, (i) {
                          final a = _recentActivity[i];
                          final Color color = a['color'] as Color;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a['title'] as String,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: ManaColors.navy,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${a['category']} • ${a['time']}',
                                        style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    a['badge'] as String,
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final String title;
  final double pct;
  final int count;
  final Color color;

  const _CategoryBar({
    required this.title,
    required this.pct,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final pctText = '${(pct * 100).toInt()}%';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ManaColors.text)),
            Text('$count cases ($pctText)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: ManaColors.muted)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 8,
            backgroundColor: ManaColors.border,
            color: color,
          ),
        ),
      ],
    );
  }
}
