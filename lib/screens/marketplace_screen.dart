import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 13: LOCAL MARKETPLACE ("Mana Market") & LISTING DETAILS
/// Matches 13a (Mana Market) & 13b (Listing Details) in design board:
/// - 13a: Search, Categories (Crops, Equipment, Shops, Buy & Sell, Rentals), Recent Listings, + Post Listing CTA
/// - 13b: Listing Details modal with Real Produce Photo, Price, Location, Seller, Call & Message CTAs
class MarketplaceScreen extends StatefulWidget {
  final bool isTelugu;
  const MarketplaceScreen({super.key, this.isTelugu = false});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Crops',
    'Equipment',
    'Shops',
    'Buy & Sell',
    'Rentals',
  ];

  final List<Map<String, dynamic>> _listings = [
    {
      'title': 'Paddy – 500 kg (BPT 5204)',
      'price': '₹2,350/qtl',
      'seller': 'Farmer (K. Venkat Rao)',
      'location': 'Your Village • 2 km',
      'condition': 'Cleaned, bagged & moisture tested',
      'phone': '+91 94401 99887',
      'image': 'assets/images/paddy_produce.jpg',
      'category': 'Crops',
    },
    {
      'title': 'Tractor for Rent (Mahindra 475)',
      'price': '₹800/hr',
      'seller': 'Ramesh Agro Rentals',
      'location': 'Near Panchayat Office • 500 m',
      'condition': 'With Driver + 9-Tyne Cultivator',
      'phone': '+91 98480 22334',
      'image': 'assets/images/service_jobs.jpg',
      'category': 'Rentals',
    },
    {
      'title': 'Organic Desi Cow Milk & Ghee',
      'price': '₹850 / kg',
      'seller': 'Gopal Dairy Farms',
      'location': 'East Ward, Kothapally • 1 km',
      'condition': '100% Pure Village Bilona Ghee',
      'phone': '+91 91234 44556',
      'image': 'assets/images/service_businesses.jpg',
      'category': 'Shops',
    },
  ];

  void _openListingDetails(Map<String, dynamic> item, bool isTe) {
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

              // Product Photo (13b)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.asset(
                    item['image'] as String,
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
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
                    ),
                  ),
                  Text(
                    item['price'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: ManaColors.purple),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 16, color: ManaColors.muted),
                  const SizedBox(width: 4),
                  Text(item['location'] as String, style: const TextStyle(fontSize: 13, color: ManaColors.muted)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Seller: ${item['seller']}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ManaColors.navy),
              ),
              const SizedBox(height: 4),
              Text(
                item['condition'] as String,
                style: const TextStyle(fontSize: 13, color: ManaColors.leaf, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 22),

              // Action Buttons: Call & Message (13b)
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling seller at ${item['phone']}...')),
                        );
                      },
                      icon: const Icon(Icons.phone_rounded),
                      label: ManaText(
                        isTe ? 'కాల్ చేయండి' : 'Call',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.danger, // Red call button in 13b
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Chat opened with ${item['seller']}.')),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: ManaText(
                        isTe ? 'సందేశం' : 'Message',
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

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'మన మార్కెట్' : 'Mana Market',
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
              // Search Bar (13a)
              FadeSlideIn(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ManaColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ManaColors.border),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      const Icon(Icons.search_rounded, color: ManaColors.muted),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: isTe ? 'పంటలు, పరికరాలు వెతకండి…' : 'Search crops, equipment, products…',
                            border: InputBorder.none,
                            hintStyle: const TextStyle(fontSize: 14, color: ManaColors.muted),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Categories Chips (13a: Crops, Equipment, Shops, Buy & Sell, Rentals)
              FadeSlideIn(
                delayMs: 30,
                child: SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, i) {
                      final c = _categories[i];
                      final isSelected = _selectedCategory == c;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(c, style: TextStyle(fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600, fontSize: 13)),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _selectedCategory = c),
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

              // Recent Listings
              FadeSlideIn(
                delayMs: 60,
                child: ManaText(
                  isTe ? 'తాజా జాబితాలు' : 'Recent Listings',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ManaColors.navy),
                ),
              ),
              const SizedBox(height: 12),

              ..._listings.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => _openListingDetails(item, isTe),
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
                              width: 84,
                              height: 84,
                              child: Image.asset(
                                item['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.purpleSoft),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: ManaColors.navy),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['price'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: ManaColors.purple),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['location'] as String,
                                  style: const TextStyle(fontSize: 11, color: ManaColors.muted),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['seller'] as String,
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ManaColors.text),
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

          // Bottom Fixed "+ Post Listing" Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post a Listing form opened.'), backgroundColor: ManaColors.purple),
                );
              },
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: ManaText(
                isTe ? 'కొత్త వస్తువును జాబితా చేయండి' : '+ Post Listing',
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
