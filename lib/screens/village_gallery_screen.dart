import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'village_map_screen.dart';

/// Screen: ONE UNIFIED VILLAGE GALLERY ("Our Village / Village Gallery")
/// Contains all village photos, videos, places, animals, fields, rice mill, school,
/// hospital, temple, petrol bunk, shops, bus stop, and streets in a single unified feed.
class VillageGalleryScreen extends StatefulWidget {
  final bool isTelugu;
  const VillageGalleryScreen({super.key, this.isTelugu = false});

  @override
  State<VillageGalleryScreen> createState() => _VillageGalleryScreenState();
}

class _VillageGalleryScreenState extends State<VillageGalleryScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Photos',
    'Videos',
    'Places',
    'Animals',
    'Agriculture',
  ];

  final List<Map<String, dynamic>> _galleryItems = [
    {
      'title': 'Village Fields & Crop Lands',
      'titleTe': 'పచ్చని పంట పొలాలు',
      'category': 'Agriculture',
      'mediaType': 'photo',
      'image': 'assets/images/service_agriculture.jpg',
      'location': 'Village Outskirts • 1.2 km',
      'locationTe': 'గ్రామ శివారు ప్రాంతం',
      'date': 'Updated Today',
      'verified': true,
      'desc': 'Lush green agricultural fields stretching across Kothapally village. Cultivation of BPT 5204 paddy, organic maize, and seasonal pulses.',
    },
    {
      'title': 'Sri Lakshmi Rice Mill',
      'titleTe': 'శ్రీ లక్ష్మి రైస్ మిల్లు',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_ricemill.jpg',
      'location': 'Main Road, Near Canal',
      'locationTe': 'ప్రధాన రహదారి, కాలువ వద్ద',
      'date': 'Operational Since 2012',
      'verified': true,
      'desc': 'Primary paddy de-husking and grain processing center for Kothapally and 8 neighboring rural villages. Equipped with modern sorting machines.',
    },
    {
      'title': 'Village Cattle, Buffaloes & Sheep',
      'titleTe': 'పాడి పశువులు, గేదెలు & గొర్రెలు',
      'category': 'Animals',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_animals.jpg',
      'location': 'Gopal Dairy Pastures & Pond',
      'locationTe': 'పాడి గోశాల మరియు చెరువు గట్టు',
      'date': 'Daily Grazing',
      'verified': true,
      'desc': 'Authentic village dairy livestock including indigenous Sahiwal cows, Murrah water buffaloes, and sheep herds grazing peacefully.',
    },
    {
      'title': 'Village Annual Bonalu Festival',
      'titleTe': 'గ్రామ బోనాల ఉత్సవం',
      'category': 'Videos',
      'mediaType': 'video',
      'image': 'assets/images/gallery_festival.jpg',
      'location': 'Village Center Temple Square',
      'locationTe': 'గ్రామ దేవాలయ ప్రాంగణం',
      'date': '20 Sep 2026',
      'verified': true,
      'desc': 'Traditional village cultural celebration with folk drums, decorated pots, and community feast celebrated with vibrant devotion.',
    },
    {
      'title': 'Gram Panchayat Administrative Office',
      'titleTe': 'గ్రామ పంచాయతీ కార్యాలయం',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/service_panchayat.jpg',
      'location': 'Village Center, Ward 1',
      'locationTe': 'గ్రామ కేంద్రం, వార్డు 1',
      'date': 'Govt Office',
      'verified': true,
      'desc': 'Democratically elected local governance office managing civic amenities, water pipeline works, LED streetlights, and resident records.',
    },
    {
      'title': 'Zilla Parishad High School',
      'titleTe': 'జిల్లా పరిషత్ ఉన్నత పాఠశాల',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/service_education.jpg',
      'location': 'ZP School Road, Ward 2',
      'locationTe': 'పాఠశాల రోడ్డు, వార్డు 2',
      'date': 'Established 1985',
      'verified': true,
      'desc': 'Modernized digital government school with computer lab, playground, mid-day meals facility, and qualified teaching staff.',
    },
    {
      'title': 'Primary Health Center (PHC)',
      'titleTe': 'ప్రాథమిక ఆరోగ్య కేంద్రం',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/service_healthcare.jpg',
      'location': 'Hospital Road • 450 m',
      'locationTe': 'హాస్పిటల్ రోడ్డు • 450 మీ.',
      'date': '24/7 Emergency',
      'verified': true,
      'desc': 'Community healthcare facility offering free doctor consultations, diagnostic tests, vaccines, delivery wing, and essential medications.',
    },
    {
      'title': 'Ancient Sri Sita Rama Temple',
      'titleTe': 'శ్రీ సీతారామ దేవాలయం',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_temple.jpg',
      'location': 'Temple Street, Village Heart',
      'locationTe': 'దేవాలయ వీధి, గ్రామ హృదయం',
      'date': 'Historic Heritage',
      'verified': true,
      'desc': 'Century-old spiritual center and peaceful temple with stone carvings, pond, and annual Sri Rama Navami Kalyanam.',
    },
    {
      'title': 'Indian Oil Rural Petrol Bunk',
      'titleTe': 'ఇండియన్ ఆయిల్ పెట్రోల్ బంక్',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_petrol.jpg',
      'location': 'Ghatkesar Highway Junction',
      'locationTe': 'హైవే జంక్షన్ వద్ద',
      'date': 'Open 6 AM - 11 PM',
      'verified': true,
      'desc': 'Fuel station providing diesel for agricultural tractors, motor fuel, clean drinking water, and air pressure check.',
    },
    {
      'title': 'Local Village Bazaar & Kirana Shops',
      'titleTe': 'గ్రామ బజార్ & కిరాణా దుకాణాలు',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/service_businesses.jpg',
      'location': 'Main Bazaar Street',
      'locationTe': 'ప్రధాన బజార్ వీధి',
      'date': 'Daily Market',
      'verified': true,
      'desc': 'Lively village commerce street with grocery stores, tea stalls, fresh vegetable vendors, and tailoring services.',
    },
    {
      'title': 'RTC Village Bus Stop',
      'titleTe': 'ఆర్టీసీ బస్సు స్టాప్',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_busstop.jpg',
      'location': 'Kothapally Cross Roads',
      'locationTe': 'కోతపల్లి చౌరస్తా',
      'date': 'Buses Every 30 mins',
      'verified': true,
      'desc': 'Frequent TSRTC buses connecting Kothapally to Ghatkesar, Secunderabad, and district headquarters.',
    },
    {
      'title': 'Concrete Paved Village Streets',
      'titleTe': 'సిమెంట్ రోడ్లు & వీధులు',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_street.jpg',
      'location': 'North & South Wards',
      'locationTe': 'ఉత్తర మరియు దక్షిణ వార్డులు',
      'date': 'Development Works',
      'verified': true,
      'desc': 'All-weather concrete paved roads with underground drainage and automated solar street lighting.',
    },
    {
      'title': 'Pedda Cheruvu Lake & Water Reservoir',
      'titleTe': 'పెద్ద చెరువు & నీటి జలాశయం',
      'category': 'Places',
      'mediaType': 'photo',
      'image': 'assets/images/gallery_lake.jpg',
      'location': 'South Village Boundary',
      'locationTe': 'దక్షిణ గ్రామ సరిహద్దు',
      'date': 'Natural Lake',
      'verified': true,
      'desc': 'Key irrigation water reservoir supporting 600 acres of paddy cultivation and local fish farming.',
    },
    {
      'title': 'Village Community & Citizens',
      'titleTe': 'గ్రామస్తుల కలయిక',
      'category': 'Photos',
      'mediaType': 'photo',
      'image': 'assets/images/login_community.jpg',
      'location': 'Panchayat Courtyard',
      'locationTe': 'పంచాయతీ ఆవరణం',
      'date': 'Gram Sabha 2026',
      'verified': true,
      'desc': 'United rural village community participating in village welfare decisions and developmental councils.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openItemDetail(Map<String, dynamic> item) {
    final isTe = widget.isTelugu;
    final isVideo = item['mediaType'] == 'video';

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
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(color: ManaColors.border, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(height: 16),

              // Full Photo / Video Player Frame
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        item['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      if (isVideo)
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow_rounded, color: ManaColors.purple, size: 38),
                          ),
                        ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isVideo ? Icons.videocam_rounded : Icons.photo_camera_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isVideo ? 'Village Video' : 'Village Photo',
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      isTe ? item['titleTe'] as String : item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
                    ),
                  ),
                  if (item['verified'] == true)
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
                          Text('Verified Place', style: TextStyle(color: ManaColors.blue, fontWeight: FontWeight.w800, fontSize: 11)),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 16, color: ManaColors.orange),
                  const SizedBox(width: 4),
                  Text(
                    isTe ? item['locationTe'] as String : item['location'] as String,
                    style: const TextStyle(fontSize: 13, color: ManaColors.muted, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    item['date'] as String,
                    style: const TextStyle(fontSize: 12, color: ManaColors.muted),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                item['desc'] as String,
                style: const TextStyle(fontSize: 13, color: ManaColors.text, height: 1.4),
              ),

              const SizedBox(height: 22),

              // Action Buttons: View on Map & Get Directions
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.push(context, manaPageRoute(VillageMapScreen(isTelugu: isTe)));
                      },
                      icon: const Icon(Icons.map_rounded),
                      label: ManaText(
                        isTe ? 'మ్యాప్‌లో చూడండి' : 'View on Map',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
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
                          SnackBar(content: Text('Starting GPS directions to ${item['title']}...')),
                        );
                      },
                      icon: const Icon(Icons.directions_rounded, color: ManaColors.navy),
                      label: ManaText(
                        isTe ? 'దారి పొందండి' : 'Get Directions',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
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

    // Filter items based on Category Filter & Search Query
    final filtered = _galleryItems.where((item) {
      // Filter tab
      bool matchFilter = true;
      if (_selectedFilter == 'Photos') {
        matchFilter = item['mediaType'] == 'photo';
      } else if (_selectedFilter == 'Videos') {
        matchFilter = item['mediaType'] == 'video';
      } else if (_selectedFilter == 'Places') {
        matchFilter = item['category'] == 'Places';
      } else if (_selectedFilter == 'Animals') {
        matchFilter = item['category'] == 'Animals';
      } else if (_selectedFilter == 'Agriculture') {
        matchFilter = item['category'] == 'Agriculture';
      }

      // Search Query
      bool matchSearch = true;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final title = (item['title'] as String).toLowerCase();
        final titleTe = (item['titleTe'] as String).toLowerCase();
        final location = (item['location'] as String).toLowerCase();
        matchSearch = title.contains(q) || titleTe.contains(q) || location.contains(q);
      }

      return matchFilter && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'గ్రామ గ్యాలరీ (మా గ్రామం)' : 'Our Village Gallery',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ManaColors.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // 1. Search Village Box
          FadeSlideIn(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ManaColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ManaColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(Icons.search_rounded, color: ManaColors.muted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val.trim()),
                      decoration: InputDecoration(
                        hintText: isTe ? 'గ్రామ ప్రదేశాలు, పొలాలు, ఆలయాలు వెతకండి…' : 'Search village fields, temples, places…',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(fontSize: 14, color: ManaColors.muted),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18, color: ManaColors.muted),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 2. Filter Chips: [ All ] [ Photos ] [ Videos ] [ Places ] [ Animals ] [ Agriculture ]
          FadeSlideIn(
            delayMs: 30,
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
                      label: Text(
                        f,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
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

          const SizedBox(height: 18),

          // Header summary
          FadeSlideIn(
            delayMs: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ManaText(
                  isTe ? 'అన్ని ప్రదేశాలు & దృశ్యాలు' : 'All Places & Visual Stories',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
                ),
                Text(
                  '${filtered.length} Items',
                  style: const TextStyle(fontSize: 12, color: ManaColors.muted, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 3. Mixed Grid / Masonry Feed of Cards
          ...filtered.map((item) {
            final isVideo = item['mediaType'] == 'video';

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => _openItemDetail(item),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: ManaColors.surface,
                    borderRadius: BorderRadius.circular(20),
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
                      // Large Photo / Video Frame
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 190,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                item['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.navy),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.65),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              if (isVideo)
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.play_arrow_rounded, color: ManaColors.purple, size: 34),
                                  ),
                                ),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item['category'] as String,
                                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 14,
                                right: 14,
                                bottom: 12,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        isTe ? item['titleTe'] as String : item['title'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (item['verified'] == true)
                                      const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF60A5FA)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Card Bottom Details & Quick Actions
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_rounded, size: 15, color: ManaColors.orange),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                isTe ? item['locationTe'] as String : item['location'] as String,
                                style: const TextStyle(fontSize: 12, color: ManaColors.muted, fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['date'] as String,
                              style: const TextStyle(fontSize: 11, color: ManaColors.muted),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: ManaColors.purple),
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
    );
  }
}
