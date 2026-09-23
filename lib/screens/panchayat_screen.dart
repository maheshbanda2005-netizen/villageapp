import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';

/// Screen 09: PANCHAYAT & VILLAGE SERVICES
/// Matches the 3-sub-view panel in the design board:
/// - 9a: Panchayat Services (Report CTA, My Complaints count, Announcements, Events)
/// - 9b: Report a Problem (What is the problem? 8 categories, Next button)
/// - 9c: Complaint Tracking (Complaint #MG-1042 timeline: Submitted -> Acknowledged -> In Progress -> Resolved)
class PanchayatScreen extends StatefulWidget {
  final bool isTelugu;
  const PanchayatScreen({super.key, this.isTelugu = false});

  @override
  State<PanchayatScreen> createState() => _PanchayatScreenState();
}

class _PanchayatScreenState extends State<PanchayatScreen> {
  int _selectedTab = 0; // 0: Services, 1: Report Problem, 2: Tracking
  String _chosenCategory = 'Streetlight';

  final List<Map<String, dynamic>> _complaintCategories = [
    {'title': 'Water', 'titleTe': 'నీరు', 'icon': Icons.water_drop_rounded, 'color': ManaColors.blue},
    {'title': 'Streetlight', 'titleTe': 'వీధి దీపం', 'icon': Icons.lightbulb_rounded, 'color': ManaColors.orange},
    {'title': 'Road', 'titleTe': 'రహదారి', 'icon': Icons.alt_route_rounded, 'color': ManaColors.navy},
    {'title': 'Garbage', 'titleTe': 'చెత్త', 'icon': Icons.delete_outline_rounded, 'color': ManaColors.purple},
    {'title': 'Drainage', 'titleTe': 'కాలువ', 'icon': Icons.waves_rounded, 'color': ManaColors.blue},
    {'title': 'Electricity', 'titleTe': 'విద్యుత్', 'icon': Icons.electric_bolt_rounded, 'color': ManaColors.orange},
    {'title': 'School', 'titleTe': 'పాఠశాల', 'icon': Icons.school_rounded, 'color': ManaColors.purple},
    {'title': 'Other', 'titleTe': 'ఇతర', 'icon': Icons.more_horiz_rounded, 'color': ManaColors.muted},
  ];

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'పంచాయతీ సేవలు' : 'Panchayat & Village Services',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ManaColors.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: ManaColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ManaColors.border),
            ),
            child: Row(
              children: [
                _buildSubTab(0, isTe ? 'సేవలు' : 'Services', Icons.account_balance_rounded),
                _buildSubTab(1, isTe ? 'ఫిర్యాదు' : 'Report Issue', Icons.report_problem_rounded),
                _buildSubTab(2, isTe ? 'ట్రాకింగ్' : 'Tracking', Icons.track_changes_rounded),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildServicesView(isTe),
          _buildReportProblemView(isTe),
          _buildComplaintTrackingView(isTe),
        ],
      ),
    );
  }

  Widget _buildSubTab(int index, String title, IconData icon) {
    final selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? ManaColors.purple : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: selected ? Colors.white : ManaColors.navy),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected ? Colors.white : ManaColors.navy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 9a: PANCHAYAT SERVICES
  Widget _buildServicesView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Hero Banner
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 170,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/service_panchayat.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManaText(
                        isTe ? 'కోతపల్లి గ్రామ పంచాయతీ' : 'Kothapally Gram Panchayat',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        isTe ? 'పారదర్శక గ్రామీణ సేవలు & ప్రజా సమస్యల పరిష్కారం' : 'Citizen Grievances, Public Works & Ward Services',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Report a Problem Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: ManaColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ManaColors.purpleSoft),
            boxShadow: [
              BoxShadow(
                color: ManaColors.purple.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ManaColors.purpleSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.campaign_rounded, color: ManaColors.purple, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ManaText(
                      isTe ? 'సమస్యను నివేదించండి' : 'Report a Problem',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isTe ? 'వీధి దీపం, రోడ్డు, నీరు మొదలైనవి' : 'Street/paving Problem, water, lighting',
                      style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => setState(() => _selectedTab = 1),
                style: FilledButton.styleFrom(
                  backgroundColor: ManaColors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Report Now', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // My Complaints Card (3 Complaints: 1 In Progress, 2 Resolved)
        Container(
          padding: const EdgeInsets.all(18),
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
                  ManaText(
                    isTe ? 'నా ఫిర్యాదులు' : 'My Complaints',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _selectedTab = 2),
                    child: const Text('Track →', style: TextStyle(fontWeight: FontWeight.w800, color: ManaColors.purple)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                '3 Total Complaints (1 In Progress • 2 Resolved)',
                style: TextStyle(fontSize: 13, color: ManaColors.muted, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Announcements
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ManaText(
              isTe ? 'గ్రామ ప్రకటనలు' : 'Announcements',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildNoticeTile('Pipeline maintenance scheduled for Ward 4 tomorrow.', '2h ago'),
        const SizedBox(height: 8),
        _buildNoticeTile('Gram Sabha meeting on Saturday at 10 AM regarding water tanks.', '1d ago'),

        const SizedBox(height: 20),

        // Events
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ManaText(
              isTe ? 'గ్రామ కార్యక్రమాలు' : 'Events',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildNoticeTile('Haritha Haram Village Tree Plantation Drive', 'Sunday • 8 AM'),
      ],
    );
  }

  Widget _buildNoticeTile(String title, String time) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ManaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ManaColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: ManaColors.purple, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ManaColors.navy),
            ),
          ),
          const SizedBox(width: 8),
          Text(time, style: const TextStyle(fontSize: 11, color: ManaColors.muted)),
        ],
      ),
    );
  }

  // 9b: REPORT A PROBLEM VIEW
  Widget _buildReportProblemView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        ManaText(
          isTe ? 'సమస్య ఏమిటి?' : 'What is the problem?',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: ManaColors.navy),
        ),
        const SizedBox(height: 4),
        Text(
          isTe ? 'సంబంధిత విభాగాన్ని ఎంచుకోండి' : 'Select category to alert Panchayat ward officer',
          style: const TextStyle(fontSize: 13, color: ManaColors.muted),
        ),
        const SizedBox(height: 20),

        // 8 Categories Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: _complaintCategories.length,
          itemBuilder: (context, i) {
            final cat = _complaintCategories[i];
            final isSelected = _chosenCategory == cat['title'];
            final color = cat['color'] as Color;

            return InkWell(
              onTap: () => setState(() => _chosenCategory = cat['title'] as String),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isSelected ? ManaColors.purpleSoft : ManaColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? ManaColors.purple : ManaColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(cat['icon'] as IconData, color: color, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isTe ? cat['titleTe'] as String : cat['title'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? ManaColors.purple : ManaColors.navy,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 28),

        // Next Button
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              _showComplaintFormSheet(isTe);
            },
            style: FilledButton.styleFrom(
              backgroundColor: ManaColors.purple,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: ManaText(
              isTe ? 'తదుపరి (Next) →' : 'Next →',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }

  void _showComplaintFormSheet(bool isTe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 44, height: 5, decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(height: 16),
              Text(
                'Report $_chosenCategory Issue',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: ManaColors.navy),
              ),
              const SizedBox(height: 14),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Location / Ward Number',
                  hintText: 'e.g., Ward 3, Near Water Tank',
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Describe the Problem',
                  hintText: 'Provide details for the lineman or supervisor...',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_rounded, size: 16),
                    label: const Text('Add Photo'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      setState(() => _selectedTab = 2);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Complaint #MG-1042 registered successfully!'),
                          backgroundColor: ManaColors.purple,
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(backgroundColor: ManaColors.purple),
                    child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 9c: COMPLAINT TRACKING
  Widget _buildComplaintTrackingView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ManaColors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: ManaColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.purpleSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Complaint #MG-1042', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: ManaColors.purple)),
                  ),
                  const Text('Submitted: 21 Sep 2025', style: TextStyle(fontSize: 11, color: ManaColors.muted)),
                ],
              ),
              const SizedBox(height: 14),
              const ManaText(
                'Streetlight Problem • Ward 3',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: ManaColors.navy),
              ),
              const SizedBox(height: 4),
              const Text(
                'Opposite Hanuman Temple. Light blinking and wire hanging.',
                style: TextStyle(fontSize: 13, color: ManaColors.text),
              ),
              const SizedBox(height: 24),

              // Timeline: Submitted -> Acknowledged -> In Progress -> Resolved
              _buildTimelineStep(1, 'Submitted', '21 Sep 2025, 09:30 AM', isDone: true, isCurrent: false),
              _buildTimelineStep(2, 'Acknowledged', 'Panchayat Secretary verified', isDone: true, isCurrent: false),
              _buildTimelineStep(3, 'In Progress', 'Assigned to Lineman Ramesh (+91 98480 11223)', isDone: false, isCurrent: true),
              _buildTimelineStep(4, 'Resolved', 'Estimated within 24 hrs', isDone: false, isCurrent: false, isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep(int step, String title, String sub, {required bool isDone, required bool isCurrent, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? ManaColors.purple
                    : isCurrent
                        ? ManaColors.orange
                        : ManaColors.border,
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : isCurrent
                        ? const Icon(Icons.circle, size: 10, color: Colors.white)
                        : Text('$step', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: ManaColors.muted)),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 44,
                color: isDone ? ManaColors.purple : ManaColors.border,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: isCurrent ? ManaColors.orange : (isDone ? ManaColors.navy : ManaColors.muted),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
