import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 15: VILLAGE MAP (Google Maps Integration)
/// Visual map of village roads, facilities, civic assets, and emergency locations.
class VillageMapScreen extends StatefulWidget {
  final bool isTelugu;
  const VillageMapScreen({super.key, this.isTelugu = false});

  @override
  State<VillageMapScreen> createState() => _VillageMapScreenState();
}

class _VillageMapScreenState extends State<VillageMapScreen> {
  String _selectedFilter = 'All';
  int _selectedMarkerIndex = 0;

  final List<Map<String, dynamic>> _markers = [
    {
      'title': 'Kothapally Primary Health Center',
      'category': 'Healthcare',
      'icon': Icons.local_hospital_rounded,
      'accent': ManaColors.danger,
      'distance': '450 m',
      'time': '5 min walk',
      'phone': '+91 94401 23456',
      'status': 'Open • Doctor Available',
      'coords': const Offset(0.35, 0.42),
      'verified': true,
      'image': 'assets/images/service_healthcare.jpg',
    },
    {
      'title': 'Gram Panchayat Office',
      'category': 'Government',
      'icon': Icons.account_balance_rounded,
      'accent': ManaColors.navy,
      'distance': '200 m',
      'time': '2 min walk',
      'phone': '+91 98480 11223',
      'status': 'Open • Sarpanch Present',
      'coords': const Offset(0.50, 0.48),
      'verified': true,
      'image': 'assets/images/service_panchayat.jpg',
    },
    {
      'title': 'Zilla Parishad High School',
      'category': 'Schools',
      'icon': Icons.school_rounded,
      'accent': ManaColors.blue,
      'distance': '800 m',
      'time': '10 min walk',
      'phone': '+91 97000 55443',
      'status': 'Classes Ongoing',
      'coords': const Offset(0.68, 0.32),
      'verified': true,
      'image': 'assets/images/service_education.jpg',
    },
    {
      'title': 'Rythu Bharosa Kendra & Seed Hub',
      'category': 'Agriculture',
      'icon': Icons.spa_rounded,
      'accent': ManaColors.leaf,
      'distance': '600 m',
      'time': '7 min walk',
      'phone': '+91 91234 56789',
      'status': 'Fertilizer in Stock',
      'coords': const Offset(0.25, 0.65),
      'verified': true,
      'image': 'assets/images/service_agriculture.jpg',
    },
    {
      'title': 'Overhead Drinking Water Tank #2',
      'category': 'Assets',
      'icon': Icons.water_drop_rounded,
      'accent': ManaColors.blue,
      'distance': '350 m',
      'time': '4 min walk',
      'phone': '+91 99887 76655',
      'status': 'Operational • 50,000 L',
      'coords': const Offset(0.42, 0.28),
      'verified': true,
      'image': 'assets/images/village_bg.jpg',
    },
    {
      'title': 'Kothapally Weekly Sandha Market',
      'category': 'Shops',
      'icon': Icons.storefront_rounded,
      'accent': ManaColors.orange,
      'distance': '550 m',
      'time': '6 min walk',
      'phone': '+91 90001 22334',
      'status': 'Market Day (Thursday)',
      'coords': const Offset(0.72, 0.60),
      'verified': true,
      'image': 'assets/images/service_marketplace.jpg',
    },
    {
      'title': 'Sri Lakshmi Kirana & General Store',
      'category': 'Shops',
      'icon': Icons.shopping_bag_rounded,
      'accent': ManaColors.orange,
      'distance': '150 m',
      'time': '1 min walk',
      'phone': '+91 98888 12345',
      'status': 'Open • UPI Accepted',
      'coords': const Offset(0.55, 0.58),
      'verified': true,
      'image': 'assets/images/service_businesses.jpg',
    },
    {
      'title': 'Farm Tractor Operator & Hiring Hub',
      'category': 'Jobs',
      'icon': Icons.work_rounded,
      'accent': ManaColors.purple,
      'distance': '1.1 km',
      'time': '3 min drive',
      'phone': '+91 94411 99887',
      'status': '2 Tractors Available',
      'coords': const Offset(0.80, 0.45),
      'verified': true,
      'image': 'assets/images/service_jobs.jpg',
    },
  ];

  late final List<String> _filters;

  @override
  void initState() {
    super.initState();
    _filters = [
      'All',
      'Healthcare',
      'Shops',
      'Jobs',
      'Schools',
      'Government',
      'Agriculture',
      'Assets',
    ];
  }

  List<Map<String, dynamic>> get _filteredMarkers {
    if (_selectedFilter == 'All') return _markers;
    return _markers.where((m) => m['category'] == _selectedFilter).toList();
  }

  void _showPlaceDetails(Map<String, dynamic> place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: ManaColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: ManaColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Image.asset(
                    place['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: ManaColors.navySoft,
                      child: Icon(place['icon'] as IconData, size: 40, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (place['accent'] as Color).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(place['icon'] as IconData, size: 14, color: place['accent'] as Color),
                        const SizedBox(width: 4),
                        ManaText(
                          place['category'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: place['accent'] as Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (place['verified'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ManaColors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_rounded, size: 14, color: ManaColors.blue),
                          SizedBox(width: 4),
                          Text(
                            'Verified Asset',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ManaColors.blue),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              ManaText(
                place['title'] as String,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: ManaColors.navy,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.near_me_rounded, size: 15, color: ManaColors.purple),
                  const SizedBox(width: 4),
                  ManaText(
                    '${place['distance']} • ${place['time']}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: ManaColors.text),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.circle, size: 6, color: ManaColors.muted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      place['status'] as String,
                      style: const TextStyle(fontSize: 13, color: ManaColors.leaf, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${place['phone']}...')),
                        );
                      },
                      icon: const Icon(Icons.phone_rounded, color: ManaColors.purple),
                      label: const ManaText('Call', style: TextStyle(fontWeight: FontWeight.w700)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: ManaColors.purple),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Navigating to ${place['title']}...'),
                            backgroundColor: ManaColors.purple,
                          ),
                        );
                      },
                      icon: const Icon(Icons.directions_rounded),
                      label: const ManaText('Directions', style: TextStyle(fontWeight: FontWeight.w700)),
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Civic issue reporting opened for this asset.')),
                    );
                  },
                  icon: const Icon(Icons.flag_outlined, size: 16, color: ManaColors.muted),
                  label: const ManaText(
                    'Report problem at this location',
                    style: TextStyle(fontSize: 12, color: ManaColors.muted),
                  ),
                ),
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
    final filtered = _filteredMarkers;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      body: Stack(
        children: [
          // Simulated Google Maps styled Village Canvas
          Positioned.fill(
            child: _VillageMapCanvas(
              markers: filtered,
              selectedIndex: _selectedMarkerIndex,
              onMarkerTapped: (index) {
                setState(() => _selectedMarkerIndex = index);
                _showPlaceDetails(filtered[index]);
              },
            ),
          ),

          // Top Floating Navigation Bar & Category Filter Chips
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ManaColors.surface,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                              color: ManaColors.navy,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: ManaColors.surface,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: isTe ? 'స్థలాలు, ఆసుపత్రులు వెతకండి…' : 'Search village places, clinics…',
                                  hintStyle: const TextStyle(fontSize: 13, color: ManaColors.muted),
                                  prefixIcon: const Icon(Icons.search_rounded, color: ManaColors.purple),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: ManaColors.surface,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.layers_rounded, size: 20),
                              color: ManaColors.purple,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Satellite & Terrain map view available with Google Maps API key.'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filters.length,
                        itemBuilder: (context, i) {
                          final f = _filters[i];
                          final active = _selectedFilter == f;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(f),
                              selected: active,
                              onSelected: (_) => setState(() => _selectedFilter = f),
                              backgroundColor: ManaColors.surface,
                              selectedColor: ManaColors.purple,
                              labelStyle: TextStyle(
                                color: active ? Colors.white : ManaColors.navy,
                                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                                fontSize: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: active ? ManaColors.purple : Colors.white,
                                ),
                              ),
                              elevation: 2,
                              pressElevation: 3,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // Floating GPS My-Location Button
          Positioned(
            right: 16,
            bottom: 120,
            child: FloatingActionButton.small(
              heroTag: 'map_gps_fab',
              backgroundColor: ManaColors.surface,
              foregroundColor: ManaColors.purple,
              elevation: 4,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Centered on your location in Kothapally.'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Icon(Icons.my_location_rounded),
            ),
          ),

          // Bottom Floating Village Location Pill / Quick summary
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: FadeSlideIn(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ManaColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ManaColors.purpleSoft,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.location_on_rounded, color: ManaColors.purple, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ManaText(
                            isTe ? 'మీ లొకేషన్: Kothapally గ్రామం' : 'Your Location: Kothapally Village',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: ManaColors.navy,
                            ),
                          ),
                          const SizedBox(height: 2),
                          ManaText(
                            isTe ? '${filtered.length} ముఖ్య ప్రదేశాలు మ్యాప్‌లో' : '${filtered.length} village points of interest active',
                            style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (filtered.isNotEmpty) _showPlaceDetails(filtered.first);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                      child: ManaText(
                        isTe ? 'జాబితా' : 'Explore',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VillageMapCanvas extends StatelessWidget {
  final List<Map<String, dynamic>> markers;
  final int selectedIndex;
  final ValueChanged<int> onMarkerTapped;

  const _VillageMapCanvas({
    required this.markers,
    required this.selectedIndex,
    required this.onMarkerTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          children: [
            // Realistic vector map roads & background
            CustomPaint(
              size: Size(w, h),
              painter: _MapPainter(),
            ),

            // User Location Radar Pulse
            Positioned(
              left: w * 0.48 - 14,
              top: h * 0.52 - 14,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ManaColors.blue.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: ManaColors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
            ),

            // Render interactive marker pins
            ...List.generate(markers.length, (i) {
              final m = markers[i];
              final Offset rel = m['coords'] as Offset;
              final Color accent = m['accent'] as Color;
              final IconData icon = m['icon'] as IconData;
              final isSelected = selectedIndex == i;

              return Positioned(
                left: (w * rel.dx) - 22,
                top: (h * rel.dy) - 44,
                child: GestureDetector(
                  onTap: () => onMarkerTapped(i),
                  child: AnimatedScale(
                    scale: isSelected ? 1.18 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: isSelected ? ManaColors.purple : accent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(icon, color: Colors.white, size: 16),
                        ),
                        Container(
                          width: 3,
                          height: 7,
                          color: isSelected ? ManaColors.purple : accent,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Base land color (rural off-white warm earth tone)
    final bgPaint = Paint()..color = const Color(0xFFF1F3EE);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Natural vegetation areas (subtle pastel olive)
    final fieldPaint = Paint()..color = const Color(0xFFE2EAD8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(20, 100, 140, 160), const Radius.circular(24)),
      fieldPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(size.width - 160, 240, 140, 200), const Radius.circular(24)),
      fieldPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(40, size.height - 280, 160, 150), const Radius.circular(24)),
      fieldPaint,
    );

    // Village Water canal / Cheruvu (subtle blue)
    final waterPaint = Paint()
      ..color = const Color(0xFFD0E3F5)
      ..style = PaintingStyle.fill;
    final waterPath = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.18, size.width * 0.5, size.height * 0.28)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.40, size.width, size.height * 0.35)
      ..lineTo(size.width, size.height * 0.38)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.43, size.width * 0.5, size.height * 0.31)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.21, 0, size.height * 0.23)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // Major Village Main Road (Panchayat R&B Highway)
    final mainRoadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final roadBorderPaint = Paint()
      ..color = const Color(0xFFD4D8DD)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final roadPath = Path()
      ..moveTo(size.width * 0.1, size.height)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.65, size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.35, size.width * 0.85, 0);

    canvas.drawPath(roadPath, roadBorderPaint);
    canvas.drawPath(roadPath, mainRoadPaint);

    // Secondary Village Colony & Farm Roads
    final secondaryRoad = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final secBorder = Paint()
      ..color = const Color(0xFFE0E3E8)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final crossPath = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.45, size.height * 0.52, size.width, size.height * 0.62);

    canvas.drawPath(crossPath, secBorder);
    canvas.drawPath(crossPath, secondaryRoad);

    final schoolRoad = Path()
      ..moveTo(size.width * 0.5, size.height * 0.5)
      ..lineTo(size.width * 0.75, size.height * 0.3);

    canvas.drawPath(schoolRoad, secBorder);
    canvas.drawPath(schoolRoad, secondaryRoad);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
