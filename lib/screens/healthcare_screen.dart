import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 08: HEALTHCARE
/// Matches the 3-sub-view panel in the design board:
/// - 8a: Healthcare Home (Talk to Doctor, Book Appointment, Nearby Hospitals, ASHA Workers)
/// - 8b: Health Camps (Free Health Checkup, Photo, Time, Community Hall)
/// - 8c: Emergency (Red Emergency Card, 108 Ambulance, 100 Police, 101 Fire)
class HealthcareScreen extends StatefulWidget {
  final bool isTelugu;
  const HealthcareScreen({super.key, this.isTelugu = false});

  @override
  State<HealthcareScreen> createState() => _HealthcareScreenState();
}

class _HealthcareScreenState extends State<HealthcareScreen> {
  int _selectedTab = 0; // 0: Home, 1: Health Camps, 2: Emergency

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'ఆరోగ్యం' : 'Healthcare',
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
                _buildSubTab(0, isTe ? 'హోమ్' : 'Health Home', Icons.local_hospital_rounded),
                _buildSubTab(1, isTe ? 'శిబిరాలు' : 'Health Camps', Icons.campaign_rounded),
                _buildSubTab(2, isTe ? 'అత్యవసరం' : 'Emergency', Icons.emergency_rounded),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildHealthHomeView(isTe),
          _buildHealthCampsView(isTe),
          _buildEmergencyView(isTe),
        ],
      ),
    );
  }

  Widget _buildSubTab(int index, String title, IconData icon) {
    final selected = _selectedTab == index;
    final isEmergency = index == 2;
    final activeColor = isEmergency ? ManaColors.danger : ManaColors.purple;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: selected ? Colors.white : (isEmergency ? ManaColors.danger : ManaColors.navy)),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected ? Colors.white : (isEmergency ? ManaColors.danger : ManaColors.navy),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 8a: HEALTHCARE HOME
  Widget _buildHealthHomeView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Main CTAs: Talk to a Doctor & Book Appointment
        FadeSlideIn(
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connecting to On-Duty Rural Tele-Doctor...')),
                    );
                  },
                  icon: const Icon(Icons.phone_in_talk_rounded),
                  label: ManaText(
                    isTe ? 'డాక్టర్‌తో మాట్లాడండి' : 'Talk to a Doctor',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PHC Appointment booking modal opened.')),
                    );
                  },
                  icon: const Icon(Icons.calendar_today_rounded, color: ManaColors.purple, size: 16),
                  label: ManaText(
                    isTe ? 'అపాయింట్‌మెంట్' : 'Book Appointment',
                    style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: ManaColors.purple, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // Nearby Hospitals: Primary Health Center, Ravi Hospital, Srinivasa Clinic
        FadeSlideIn(
          delayMs: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ManaText(
                    isTe ? 'సమీప ఆసుపత్రులు' : 'Nearby Hospitals',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All', style: TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildHospitalItem('Primary Health Center (PHC)', '1.2 km', 'Open • Govt Doctor Present', '+91 94401 23456'),
              const SizedBox(height: 8),
              _buildHospitalItem('Ravi Multispeciality Hospital', '2.8 km', 'Open 24/7 • Emergency ICU', '+91 98480 11223'),
              const SizedBox(height: 8),
              _buildHospitalItem('Srinivasa Rural Clinic & Labs', '3.4 km', 'Open till 9 PM • Diagnostics', '+91 91234 55667'),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // Health Workers (ASHA Worker)
        FadeSlideIn(
          delayMs: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ManaText(
                    isTe ? 'ఆరోగ్య కార్యకర్తలు' : 'Health Workers (ASHA)',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All', style: TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildHealthWorkerItem('Smt. Lakshmi Devi', 'ASHA Worker • Ward 1-3', '+91 91234 11223'),
              const SizedBox(height: 8),
              _buildHealthWorkerItem('Smt. Padmavathi', 'ANM Staff Nurse • Village PHC', '+91 94411 33445'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHospitalItem(String name, String distance, String status, String phone) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ManaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ManaColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ManaColors.danger.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_hospital_rounded, color: ManaColors.danger, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                ),
                const SizedBox(height: 2),
                Text(
                  '$distance • $status',
                  style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone_rounded, color: ManaColors.purple),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling $name ($phone)...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHealthWorkerItem(String name, String role, String phone) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ManaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ManaColors.border),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: ManaColors.purpleSoft,
            child: Icon(Icons.person_outline_rounded, color: ManaColors.purple),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                ),
                const SizedBox(height: 2),
                Text(role, style: const TextStyle(fontSize: 12, color: ManaColors.muted)),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling $name ($phone)...')),
              );
            },
            icon: const Icon(Icons.call, size: 14),
            label: const Text('Call', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            style: FilledButton.styleFrom(
              backgroundColor: ManaColors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  // 8b: HEALTH CAMPS VIEW
  Widget _buildHealthCampsView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Health Camp Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/health_camp.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.75)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Positioned(
                  left: 16,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Village Health Camp • గ్రామీణ ఆరోగ్య శిబిరం',
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Free consultations, medicines & eye screenings',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Free Health Checkup Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: ManaColors.surface,
            borderRadius: BorderRadius.circular(20),
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
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ManaColors.orangeSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Free Medical Camp', style: TextStyle(color: ManaColors.orange, fontWeight: FontWeight.w800, fontSize: 11)),
                  ),
                  const Spacer(),
                  const Text('Sunday • 10 AM', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: ManaColors.navy)),
                ],
              ),
              const SizedBox(height: 12),
              ManaText(
                isTe ? 'ఉచిత ఆరోగ్య మరియు కంటి పరీక్షా శిబిరం' : 'Free Health Checkup & Eye Screening',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ManaColors.navy),
              ),
              const SizedBox(height: 6),
              const Row(
                children: [
                  Icon(Icons.location_on_rounded, size: 16, color: ManaColors.muted),
                  SizedBox(width: 4),
                  Text('Village Community Hall, Kothapally', style: TextStyle(fontSize: 13, color: ManaColors.muted)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Services: Blood Sugar, BP Screening, ECG for Seniors, Cataract Eye Tests, and Free Medicines for 30 Days.',
                style: TextStyle(fontSize: 13, color: ManaColors.text, height: 1.4),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registered for Free Health Checkup Camp! Registration ID: HC-982')),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Register for Camp', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Full schedule and doctor roster downloaded.')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ManaColors.navy),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('View Details →', style: TextStyle(fontWeight: FontWeight.w700, color: ManaColors.navy)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 8c: EMERGENCY SECTION (Strictly Red)
  Widget _buildEmergencyView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: ManaColors.danger.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: ManaColors.danger.withValues(alpha: 0.35), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: ManaColors.danger,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ManaColors.danger.withValues(alpha: 0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.emergency_rounded, color: Colors.white, size: 36),
                ),
              ),
              const SizedBox(height: 16),
              ManaText(
                isTe ? 'అత్యవసర సహాయం కావాలా?' : 'Need Immediate Help?',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: ManaColors.danger),
              ),
              const SizedBox(height: 4),
              Text(
                isTe ? 'తక్షణ సహాయం కోసం క్రింది బటన్ నొక్కండి' : 'Call Emergency Services',
                style: const TextStyle(fontSize: 14, color: ManaColors.muted, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              // Emergency 108 Ambulance Button
              _buildEmergencyActionButton(
                label: 'Ambulance (108)',
                sub: 'Free Medical & Accident Emergency',
                icon: Icons.local_hospital_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dialing 108 Ambulance Emergency...'), backgroundColor: ManaColors.danger),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Emergency 100 Police Button
              _buildEmergencyActionButton(
                label: 'Police (100)',
                sub: 'Ghatkesar Police Station Help',
                icon: Icons.local_police_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dialing 100 Police Helpline...'), backgroundColor: ManaColors.danger),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Emergency 101 Fire Button
              _buildEmergencyActionButton(
                label: 'Fire (101)',
                sub: 'Fire & Rescue Emergency Response',
                icon: Icons.local_fire_department_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dialing 101 Fire Helpline...'), backgroundColor: ManaColors.danger),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyActionButton({
    required String label,
    required String sub,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: ManaColors.danger,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ManaColors.danger.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }
}
