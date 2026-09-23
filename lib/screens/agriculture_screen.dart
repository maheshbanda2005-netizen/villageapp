import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'schemes_screen.dart';

/// Screen 07: AGRICULTURE
/// Exactly matches the 3-sub-view panel in the design board:
/// - 7a: Agriculture Home (Weather card, Mandi Prices, Govt Agri Schemes)
/// - 7b: Crop Advice (Field photo, Planting, Irrigation, Fertilizer, Pest, Harvesting)
/// - 7c: Crop Problem (Camera AI scanner, Take Photo, Choose Gallery, Farm Equipment)
class AgricultureScreen extends StatefulWidget {
  final bool isTelugu;
  const AgricultureScreen({super.key, this.isTelugu = false});

  @override
  State<AgricultureScreen> createState() => _AgricultureScreenState();
}

class _AgricultureScreenState extends State<AgricultureScreen> {
  int _selectedTab = 0; // 0: Home, 1: Crop Advice, 2: Crop Problem

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'వ్యవసాయం' : 'Agriculture',
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
                _buildSubTab(0, isTe ? 'హోమ్' : 'Agri Home', Icons.agriculture_rounded),
                _buildSubTab(1, isTe ? 'పంట సలహాలు' : 'Crop Advice', Icons.spa_rounded),
                _buildSubTab(2, isTe ? 'సమస్య పరీక్ష' : 'Crop Problem', Icons.camera_alt_rounded),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildAgriHomeView(isTe),
          _buildCropAdviceView(isTe),
          _buildCropProblemView(isTe),
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

  // 7a: AGRICULTURE HOME
  Widget _buildAgriHomeView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Weather Card (28°C Partly Cloudy, Rain chance 60%)
        FadeSlideIn(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE0F2FE), Color(0xFFF0F9FF)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFBAE6FD)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTe ? 'నేటి వాతావరణం' : 'Today\'s Weather',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: ManaColors.blue),
                    ),
                    const Text('Kothapally Village', style: TextStyle(fontSize: 12, color: ManaColors.muted)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      '28°C',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: ManaColors.navy,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isTe ? 'పాక్షికంగా మేఘావృతం' : 'Partly Cloudy',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: ManaColors.navy),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Rain chance: 60%',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: ManaColors.blue),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.cloudy_snowing, color: ManaColors.blue, size: 40),
                  ],
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('7-Day Farm Weather Forecast: Moderate rainfall expected tomorrow.')),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        isTe ? 'పూర్తి వివరాలు చూడండి →' : 'View Details →',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: ManaColors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Live Market Prices: Paddy, Maize, Cotton
        FadeSlideIn(
          delayMs: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ManaText(
                    isTe ? 'మార్కెట్ ధరలు (Market Prices)' : 'Market Prices',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                  ),
                  const Text('Ghatkesar Mandi', style: TextStyle(fontSize: 12, color: ManaColors.muted)),
                ],
              ),
              const SizedBox(height: 12),
              _buildPriceRow('Paddy (వరి)', '₹2,350/qtl', '+₹40 today'),
              const SizedBox(height: 8),
              _buildPriceRow('Maize (మొక్కజొన్న)', '₹1,800/qtl', 'Stable'),
              const SizedBox(height: 8),
              _buildPriceRow('Cotton (పత్తి)', '₹5,200/qtl', '+₹120 today'),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Showing all 24 Telangana APMC mandi rates.')),
                    );
                  },
                  child: ManaText(
                    isTe ? 'అన్ని ధరలు చూడండి →' : 'View All Prices →',
                    style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Government Agriculture Schemes Button
        FadeSlideIn(
          delayMs: 80,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ManaColors.orangeSoft.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ManaColors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded, color: ManaColors.orange, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManaText(
                        isTe ? 'రైతు సంక్షేమ పథకాలు' : 'Government Agri Schemes',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isTe ? 'పీఎం కిసాన్, రైతు బంధు, పంటల బీమా' : 'PM Kisan, Rythu Bandhu & Subsidies',
                        style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(context, manaPageRoute(SchemesScreen(isTelugu: isTe)));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('View', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String crop, String price, String change) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ManaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ManaColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              crop,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: ManaColors.purple),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: ManaColors.purpleSoft,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              change,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ManaColors.purple),
            ),
          ),
        ],
      ),
    );
  }

  // 7b: CROP ADVICE VIEW
  Widget _buildCropAdviceView(bool isTe) {
    final adviceStages = [
      {'title': 'Planting', 'desc': 'Best sowing window: June–July for Kharif, Nov–Dec for Rabi. Certified seed rate: 20-25 kg/acre.', 'icon': Icons.spa_rounded},
      {'title': 'Irrigation', 'desc': 'Maintain 2-3 cm shallow water during tillering. Drain field 7 days before harvesting.', 'icon': Icons.water_drop_rounded},
      {'title': 'Fertilizer', 'desc': 'Apply Urea, DAP, and Potash in split doses. Soil testing recommended before application.', 'icon': Icons.science_rounded},
      {'title': 'Pest Management', 'desc': 'Monitor stem borer and leaf folder. Spray Neem oil 5 ml/L for organic preventive control.', 'icon': Icons.bug_report_rounded},
      {'title': 'Harvesting', 'desc': 'Harvest when 85% of grains turn golden yellow. Moisture content should be 14-16%.', 'icon': Icons.agriculture_rounded},
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Crop Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/agri_farmer.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
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
                        'Paddy & Maize Scientific Advisory',
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'University of Agricultural Sciences, Telangana',
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

        ManaText(
          isTe ? 'పంట దశల సలహాలు' : 'Crop Growth Stages',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
        ),
        const SizedBox(height: 12),

        ...adviceStages.map((stage) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ManaColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ManaColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ManaColors.purpleSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(stage['icon'] as IconData, color: ManaColors.purple, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ManaColors.navy),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stage['desc'] as String,
                        style: const TextStyle(fontSize: 13, color: ManaColors.text, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading Complete Crop Advisory PDF Guide...')),
              );
            },
            child: ManaText(
              isTe ? 'పూర్తి సలహా వివరాలు చూడండి →' : 'View Advice →',
              style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  // 7c: CROP PROBLEM (Camera AI Scanner & Farm Equipment)
  Widget _buildCropProblemView(bool isTe) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Camera Card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: ManaColors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: ManaColors.purpleSoft, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: ManaColors.purple.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: ManaColors.purple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ManaColors.purple.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.photo_camera_rounded, color: Colors.white, size: 38),
                ),
              ),
              const SizedBox(height: 16),
              ManaText(
                isTe ? 'పంట తెగులు పరీక్షించండి' : 'Check Crop Problem',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: ManaColors.navy),
              ),
              const SizedBox(height: 6),
              Text(
                isTe
                    ? 'మీ పంట ఆకు ఫోటో తీయండి. AI నివారణ మందులను వెంటనే సూచిస్తుంది.'
                    : 'Take a clear photo of affected leaf. AI diagnoses disease & recommends medicines instantly.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: ManaColors.muted, height: 1.35),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    _showDiagnosisResult(isTe);
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: ManaText(
                    isTe ? 'ఫోటో తీయండి' : 'Take Photo',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showDiagnosisResult(isTe);
                  },
                  icon: const Icon(Icons.photo_library_rounded, color: ManaColors.navy),
                  label: ManaText(
                    isTe ? 'గ్యాలరీ నుండి ఎంచుకోండి' : 'Choose from Gallery',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: ManaColors.navy),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ManaColors.border),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Farm Equipment Section
        ManaText(
          isTe ? 'వ్యవసాయ పరికరాలు & యంత్రాలు' : 'Farm Equipment For Rent',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
        ),
        const SizedBox(height: 12),

        _buildEquipmentCard('Mahindra 575 DI Tractor', '₹800 / hour', 'Available • Kothapally Ward 2', Icons.agriculture_rounded),
        const SizedBox(height: 8),
        _buildEquipmentCard('Paddy Combine Harvester', '₹2,200 / hour', 'Available • Ghatkesar Road', Icons.car_rental_rounded),
        const SizedBox(height: 8),
        _buildEquipmentCard('Battery Sprayer & Drone', '₹350 / acre', 'Available • Rythu Seva Hub', Icons.precision_manufacturing_rounded),
      ],
    );
  }

  Widget _buildEquipmentCard(String title, String rate, String status, IconData icon) {
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
              color: ManaColors.purpleSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ManaColors.purple, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                ),
                const SizedBox(height: 2),
                Text(
                  rate,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: ManaColors.purple),
                ),
                const SizedBox(height: 2),
                Text(status, style: const TextStyle(fontSize: 11, color: ManaColors.muted)),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Contacting owner for $title...')),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: ManaColors.navy,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Hire', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _showDiagnosisResult(bool isTe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: ManaColors.purple, size: 28),
                  const SizedBox(width: 10),
                  ManaText(
                    isTe ? 'పంట పరీక్ష ఫలితం (AI Diagnosis)' : 'AI Crop Diagnosis Result',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: ManaColors.navy),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: ManaColors.orangeSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: ManaColors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Detected: Bacterial Leaf Blight (BLB) • 94% Confidence',
                        style: TextStyle(fontWeight: FontWeight.w800, color: ManaColors.navy, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Recommended Treatment:',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
              ),
              const SizedBox(height: 6),
              const Text(
                '1. Spray Streptocycline 1 g + Copper Oxychloride 30 g in 10 L water.\n2. Avoid excess Nitrogen application until recovery.\n3. Drain standing water for 48 hours.',
                style: TextStyle(fontSize: 13, height: 1.45, color: ManaColors.text),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
