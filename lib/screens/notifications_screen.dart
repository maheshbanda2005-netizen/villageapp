import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 16: NOTIFICATIONS & ALERTS
/// Real-time village announcements, weather warnings, health camps, and job alerts.
class NotificationsScreen extends StatefulWidget {
  final bool isTelugu;
  const NotificationsScreen({super.key, this.isTelugu = false});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'title': 'Water Supply Update',
      'titleTe': 'నీటి సరఫరా ప్రకటన',
      'desc': 'Drinking water pipeline maintenance tomorrow. Supply shut down between 9:00 AM – 2:00 PM.',
      'descTe': 'రేపు ఉదయం 9:00 నుండి మధ్యాహ్నం 2:00 వరకు పైప్‌లైన్ మరమ్మతుల వల్ల నీటి సరఫరా ఉండదు.',
      'category': 'Village',
      'icon': Icons.water_drop_rounded,
      'color': ManaColors.orange,
      'time': '15 mins ago',
      'unread': true,
      'badge': 'Notice',
      'action': 'Panchayat Details',
    },
    {
      'id': '2',
      'title': 'Heavy Rain & Thunderstorm Alert',
      'titleTe': 'భారీ వర్షం హెచ్చరిక',
      'desc': 'IMD issued yellow alert for Medchal district. Protect harvested crops and secure livestock.',
      'descTe': 'మేడ్చల్ జిల్లాకు భారీ వర్ష సూచన. కోసిన ధాన్యాన్ని, పశువులను సురక్షిత ప్రాంతాలకు తరలించండి.',
      'category': 'Agriculture',
      'icon': Icons.thunderstorm_rounded,
      'color': ManaColors.danger,
      'time': '1 hour ago',
      'unread': true,
      'badge': 'Urgent',
      'action': 'Weather Advice',
    },
    {
      'id': '3',
      'title': 'Free Village Health Camp This Sunday',
      'titleTe': 'ఉచిత గ్రామ ఆరోగ్య శిబిరం',
      'desc': 'Specialist doctors visiting Kothapally PHC from 9 AM. Free BP, Sugar & Eye checkups for seniors.',
      'descTe': 'ఈ ఆదివారం ప్రాథమిక ఆరోగ్య కేంద్రంలో ఉచిత వైద్య శిబిరం. బీపీ, షుగర్, కంటి పరీక్షలు ఉచితం.',
      'category': 'Health',
      'icon': Icons.local_hospital_rounded,
      'color': ManaColors.coral,
      'time': '3 hours ago',
      'unread': false,
      'badge': 'Camp',
      'action': 'Book Slot',
    },
    {
      'id': '4',
      'title': '5 New Farm Jobs Available',
      'titleTe': '5 కొత్త వ్యవసాయ పనులు అందుబాటులో ఉన్నాయి',
      'desc': 'Tractor driver and harvesting workers needed at Reddy Gardens. Daily wage ₹800 + lunch.',
      'descTe': 'రెడ్డి గార్డెన్స్‌లో ట్రాక్టర్ డ్రైవర్, కూలీలు కావలెను. రోజు కూలీ ₹800 మరియు భోజనం.',
      'category': 'Jobs',
      'icon': Icons.work_rounded,
      'color': ManaColors.purple,
      'time': 'Yesterday',
      'unread': false,
      'badge': 'Job',
      'action': 'Call Employer',
    },
    {
      'id': '5',
      'title': 'Panchayat CC Road Work Sanctioned',
      'titleTe': 'పంచాయతీ సిమెంట్ రోడ్డు పనులు ప్రారంభం',
      'desc': 'Road work between Hanuman Temple and East Ward started. Traffic diversion via Lake Road.',
      'descTe': 'హనుమాన్ దేవాలయం నుండి తూర్పు వార్డు వరకు సిమెంట్ రోడ్డు పనులు ప్రారంభమైనవి.',
      'category': 'Village',
      'icon': Icons.construction_rounded,
      'color': ManaColors.navy,
      'time': '2 days ago',
      'unread': false,
      'badge': 'Update',
      'action': 'View Route',
    },
    {
      'id': '6',
      'title': 'Rythu Bandhu 12th Phase Disbursement',
      'titleTe': 'రైతు బంధు 12వ విడత జమ ప్రారంభం',
      'desc': 'Government has begun transferring ₹5,000/acre directly to bank accounts. Check eligibility list.',
      'descTe': 'ఎకరాకు ₹5,000 నేరుగా రైతుల ఖాతాల్లో జమ అవుతున్నాయి. మీ పేరును తనిఖీ చేసుకోండి.',
      'category': 'Agriculture',
      'icon': Icons.payments_rounded,
      'color': ManaColors.leaf,
      'time': '3 days ago',
      'unread': false,
      'badge': 'Scheme',
      'action': 'Check Status',
    },
  ];

  late final List<String> _categories;

  @override
  void initState() {
    super.initState();
    _categories = ['All', 'Village', 'Agriculture', 'Health', 'Jobs'];
  }

  void _markAllAsRead() {
    setState(() {
      for (final item in _items) {
        item['unread'] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ManaText(
          widget.isTelugu ? 'అన్ని నోటిఫికేషన్‌లు చదివినట్లు గుర్తించబడ్డాయి' : 'All notifications marked as read',
        ),
        backgroundColor: ManaColors.purple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;
    final filtered = _selectedCategory == 'All'
        ? _items
        : _items.where((i) => i['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'నోటిఫికేషన్‌లు' : 'Notifications',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ManaColors.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: ManaText(
              isTe ? 'అన్నీ చదివాను' : 'Mark all read',
              style: const TextStyle(fontWeight: FontWeight.w700, color: ManaColors.purple, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Category Tabs
            Container(
              height: 48,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  final active = _selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: active,
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                      selectedColor: ManaColors.purple,
                      backgroundColor: ManaColors.surface,
                      labelStyle: TextStyle(
                        color: active ? Colors.white : ManaColors.navy,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: active ? ManaColors.purple : ManaColors.border,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Notification List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_off_outlined, size: 54, color: ManaColors.muted.withValues(alpha: 0.5)),
                          const SizedBox(height: 12),
                          ManaText(
                            isTe ? 'నోటిఫికేషన్‌లు లేవు' : 'No notifications in this category',
                            style: const TextStyle(fontWeight: FontWeight.w600, color: ManaColors.muted),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final n = filtered[i];
                        final unread = n['unread'] == true;
                        final color = n['color'] as Color;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FadeSlideIn(
                            delayMs: i * 40,
                            child: Material(
                              color: unread ? ManaColors.purpleSoft.withValues(alpha: 0.25) : ManaColors.surface,
                              borderRadius: BorderRadius.circular(18),
                              child: InkWell(
                                onTap: () {
                                  setState(() => n['unread'] = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${n['title']}: ${n['action']} selected.'),
                                      backgroundColor: ManaColors.purple,
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: unread ? ManaColors.purple.withValues(alpha: 0.4) : ManaColors.border,
                                      width: unread ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Icon(n['icon'] as IconData, color: color, size: 24),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: color.withValues(alpha: 0.15),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    n['badge'] as String,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w800,
                                                      color: color,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  n['time'] as String,
                                                  style: const TextStyle(fontSize: 11, color: ManaColors.muted),
                                                ),
                                                if (unread) ...[
                                                  const SizedBox(width: 6),
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: const BoxDecoration(
                                                      color: ManaColors.purple,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            ManaText(
                                              isTe ? n['titleTe'] as String : n['title'] as String,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: unread ? FontWeight.w800 : FontWeight.w700,
                                                color: ManaColors.navy,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            ManaText(
                                              isTe ? n['descTe'] as String : n['desc'] as String,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: ManaColors.text,
                                                height: 1.35,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                ManaText(
                                                  n['action'] as String,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                    color: ManaColors.purple,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(Icons.arrow_forward_rounded, size: 14, color: ManaColors.purple),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
