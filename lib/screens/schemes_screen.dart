import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 12: GOVERNMENT SCHEMES & SCHEME DETAILS
/// Matches 12a (Schemes for You) & 12b (Scheme Details) in design board:
/// - 12a: Categories (Farmers, Women, Students, Senior Citizens, Workers, Housing, Business)
/// - 12b: Scheme Details modal with Photo, Benefits, Eligibility, Required Documents, Apply Online & Official Website CTAs
class SchemesScreen extends StatefulWidget {
  final bool isTelugu;
  const SchemesScreen({super.key, this.isTelugu = false});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  String _selectedCategory = 'Farmers';

  final List<String> _categories = [
    'Farmers',
    'Women',
    'Students',
    'Senior Citizens',
    'Workers',
    'Housing',
  ];

  final List<Map<String, dynamic>> _schemes = [
    {
      'title': 'PM Kisan Samman Nidhi',
      'titleTe': 'పీఎం కిసాన్ సమ్మాన్ నిధి',
      'category': 'Farmers',
      'benefits': '₹6,000 per year (3 installments)',
      'eligibility': 'Small & marginal landholding farmers',
      'documents': 'Aadhaar, Bank Account, Land Records (Pattadar)',
      'lastUpdated': 'Updated 20 Sep 2026',
      'source': 'pmkisan.gov.in',
      'image': 'assets/images/service_schemes.jpg',
    },
    {
      'title': 'Rythu Bandhu Investment Support',
      'titleTe': 'రైతు బంధు పథకం',
      'category': 'Farmers',
      'benefits': '₹5,000 / acre per crop season',
      'eligibility': 'All agricultural landowning farmers in Telangana',
      'documents': 'Pattadar Passbook, Aadhaar, Bank Account',
      'lastUpdated': 'Updated 18 Sep 2026',
      'source': 'rythubandhu.telangana.gov.in',
      'image': 'assets/images/service_schemes.jpg',
    },
    {
      'title': 'Mahalakshmi Scheme',
      'titleTe': 'మహాలక్ష్మి మహిళా పథకం',
      'category': 'Women',
      'benefits': 'Free RTC bus travel & ₹500 LPG cylinder',
      'eligibility': 'Resident women of Telangana with White Ration Card',
      'documents': 'Aadhaar Card, Food Security Card',
      'lastUpdated': 'Updated 15 Sep 2026',
      'source': 'telangana.gov.in',
      'image': 'assets/images/service_schemes.jpg',
    },
    {
      'title': 'Indiramma Housing Scheme',
      'titleTe': 'ఇందిరమ్మ గృహ నిర్మాణం',
      'category': 'Housing',
      'benefits': '₹5 Lakh financial aid for house construction',
      'eligibility': 'Homeless families with residential plot in village',
      'documents': 'Plot Documents, Income Certificate, Ration Card',
      'lastUpdated': 'Updated 12 Sep 2026',
      'source': 'housing.telangana.gov.in',
      'image': 'assets/images/service_schemes.jpg',
    },
  ];

  void _openSchemeDetails(Map<String, dynamic> scheme, bool isTe) {
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

              // Scheme Photo (12b)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.asset(
                    scheme['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: ManaColors.orange),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: ManaColors.leaf.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified_rounded, size: 14, color: ManaColors.leaf),
                        SizedBox(width: 4),
                        Text('Official Scheme', style: TextStyle(color: ManaColors.leaf, fontWeight: FontWeight.w800, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(scheme['lastUpdated'] as String, style: const TextStyle(fontSize: 11, color: ManaColors.muted)),
                ],
              ),

              const SizedBox(height: 8),

              ManaText(
                isTe ? scheme['titleTe'] as String : scheme['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ManaColors.navy),
              ),

              const SizedBox(height: 14),

              // Benefits, Eligibility, Documents (12b)
              _buildDetailItem(Icons.card_giftcard_rounded, 'Benefits', scheme['benefits'] as String),
              const SizedBox(height: 8),
              _buildDetailItem(Icons.how_to_reg_rounded, 'Eligibility', scheme['eligibility'] as String),
              const SizedBox(height: 8),
              _buildDetailItem(Icons.description_rounded, 'Documents', scheme['documents'] as String),

              const SizedBox(height: 22),

              // Action Buttons: Apply Online & Official Website (12b)
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Opening online portal for ${scheme['title']}...'),
                            backgroundColor: ManaColors.purple,
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: ManaColors.purple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Apply Online', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opening official website: ${scheme['source']}')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ManaColors.navy, width: 1.5),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Official Website', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: ManaColors.navy)),
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

  Widget _buildDetailItem(IconData icon, String title, String val) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: ManaColors.purple),
        const SizedBox(width: 10),
        Text('$title: ', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: ManaColors.navy)),
        Expanded(
          child: Text(val, style: const TextStyle(fontSize: 13, color: ManaColors.text)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;
    final filtered = _schemes.where((s) => s['category'] == _selectedCategory || _selectedCategory == 'Farmers').toList();

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        title: ManaText(
          isTe ? 'ప్రభుత్వ పథకాలు' : 'Government Schemes',
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
          // Category Chips (12a: Schemes for You)
          FadeSlideIn(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat, style: TextStyle(fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600, fontSize: 13)),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedCategory = cat),
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

          // Scheme Cards
          ...filtered.map((s) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: InkWell(
                onTap: () => _openSchemeDetails(s, isTe),
                borderRadius: BorderRadius.circular(20),
                child: Container(
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
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: ManaColors.purpleSoft,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              s['category'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: ManaColors.purple),
                            ),
                          ),
                          const Spacer(),
                          const Row(
                            children: [
                              Icon(Icons.verified_rounded, size: 14, color: ManaColors.leaf),
                              SizedBox(width: 4),
                              Text('Govt Verified', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: ManaColors.leaf)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ManaText(
                        isTe ? s['titleTe'] as String : s['title'] as String,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ManaColors.navy),
                      ),
                      const SizedBox(height: 6),
                      Text('Benefits: ${s['benefits']}', style: const TextStyle(fontSize: 13, color: ManaColors.text, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () => _openSchemeDetails(s, isTe),
                            style: FilledButton.styleFrom(
                              backgroundColor: ManaColors.purple,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Apply Online', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () => _openSchemeDetails(s, isTe),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: ManaColors.navy),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('View Details →', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: ManaColors.navy)),
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
    );
  }
}
