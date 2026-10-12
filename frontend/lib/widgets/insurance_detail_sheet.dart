import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showInsuranceDetail(BuildContext context, Map<String, dynamic> plan) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => _InsuranceDetailSheet(plan: plan),
  );
}

class _InsuranceDetailSheet extends StatelessWidget {
  final Map<String, dynamic> plan;
  const _InsuranceDetailSheet({required this.plan});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.divider, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (plan['iconBg'] as Color),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(plan['icon'] as IconData, color: plan['iconColor'] as Color, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan['title'] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(6)),
                          child: Text(plan['subtitle'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppTheme.textGrey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Why this plan?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              Text(plan['whyText'] as String, style: const TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.6)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('COVERAGE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textGrey, letterSpacing: 0.8)),
                          const SizedBox(height: 6),
                          Text(plan['coverage'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('MONTHLY COST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textGrey, letterSpacing: 0.8)),
                          const SizedBox(height: 6),
                          Text(plan['premium'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('All Benefits', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
              const SizedBox(height: 12),
              ...(plan['allBenefits'] as List<String>).map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 22, height: 22,
                      decoration: const BoxDecoration(color: AppTheme.greenLight, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: AppTheme.accent, size: 14),
                    ),
                    const SizedBox(width: 10),
                    Text(b, style: const TextStyle(fontSize: 13, color: AppTheme.textDark)),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Getting your custom quote...'), backgroundColor: AppTheme.accent),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Get Custom Quote', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Insurance plan data used by protection screen
final List<Map<String, dynamic>> insurancePlans = [
  {
    'icon': Icons.favorite_outline,
    'iconColor': AppTheme.red,
    'iconBg': AppTheme.redLight,
    'title': 'Health Insurance',
    'subtitle': 'Covers medical expenses due to illness',
    'coverage': '₹5,00,000',
    'premium': '₹450/mo',
    'badge': 'Suggested',
    'badgeColor': AppTheme.accent,
    'whyText': 'Comprehensive health coverage is essential for gig workers. This plan covers hospitalization expenses, surgeries, and critical illnesses. With our partner hospitals, you get cashless treatment so you don\'t have to worry about immediate funds.',
    'features': ['Cashless hospitalization', 'Pre & post hospitalization cover', 'Free health checkups'],
    'allBenefits': ['Cashless hospitalization', 'Pre & post hospitalization cover', 'Free health checkups', '24/7 Support', 'Fast Claim Process', 'Digital Policy'],
  },
  {
    'icon': Icons.directions_bike,
    'iconColor': AppTheme.orange,
    'iconBg': const Color(0xFFFFF3E8),
    'title': 'Bike Insurance',
    'subtitle': 'Third-party & Own Damage cover',
    'coverage': 'Market Value',
    'premium': '₹850/yr',
    'badge': 'Road Warrior',
    'badgeColor': AppTheme.orange,
    'whyText': 'As a delivery rider, your bike is your livelihood. This plan protects against accidents, theft, and third-party liability. Get back on the road quickly with our 24-hour claim settlement.',
    'features': ['Roadside assistance', 'Zero depreciation', 'Quick claim settlement'],
    'allBenefits': ['Roadside assistance', 'Zero depreciation', 'Quick claim settlement', 'Theft cover', 'Third-party liability', 'Cashless garage network'],
  },
  {
    'icon': Icons.phone_android,
    'iconColor': AppTheme.purple,
    'iconBg': AppTheme.purpleLight,
    'title': 'Mobile Insurance',
    'subtitle': 'Screen damage & theft',
    'coverage': '₹20,000',
    'premium': '₹99/mo',
    'badge': 'Must Have',
    'badgeColor': AppTheme.primary,
    'whyText': 'Your phone is your lifeline for accepting orders. This plan covers accidental drops, liquid damage, and theft, so you never miss an earning opportunity due to a damaged phone.',
    'features': ['Screen Replacement', 'Liquid Damage Cover', 'Theft Protection'],
    'allBenefits': ['Screen Replacement', 'Liquid Damage Cover', 'Theft Protection', 'Next Day Replacement', '24/7 Support', 'No Hidden Fees'],
  },
  {
    'icon': Icons.delivery_dining,
    'iconColor': AppTheme.orange,
    'iconBg': const Color(0xFFFFF3E8),
    'title': 'Accident Cover',
    'subtitle': 'Protection against accidental injuries',
    'coverage': '₹10,00,000',
    'premium': '₹150/mo',
    'badge': null,
    'badgeColor': Colors.transparent,
    'whyText': 'Riding on Indian roads comes with risks. This personal accident cover ensures financial support for you and your family in case of accidents, covering medical bills, disability, and more.',
    'features': ['Accidental death cover', 'Permanent disability benefits', 'Fracture cover'],
    'allBenefits': ['Accidental death cover', 'Permanent disability benefits', 'Fracture cover', 'Hospital daily allowance', 'Ambulance cover', 'Family benefit'],
  },
  {
    'icon': Icons.business_center,
    'iconColor': Colors.teal,
    'iconBg': const Color(0xFFE0F7F4),
    'title': 'Income Protection',
    'subtitle': 'Ensures income during work disruption',
    'coverage': '₹15,000/week',
    'premium': '₹300/mo',
    'badge': null,
    'badgeColor': Colors.transparent,
    'whyText': 'When illness or injury stops you from working, this plan replaces your income so your savings and family expenses are protected. Perfect for gig workers with variable daily earnings.',
    'features': ['Weekly income replacement', 'Loss of pay due to illness', 'Platform ban protection (limited)'],
    'allBenefits': ['Weekly income replacement', 'Loss of pay due to illness', 'Platform ban protection', 'Covers 26 weeks', 'No waiting period for accidents', 'Digital claims'],
  },
  {
    'icon': Icons.umbrella,
    'iconColor': Colors.blueGrey,
    'iconBg': const Color(0xFFECEFF1),
    'title': 'Term Life Insurance',
    'subtitle': 'Financial security for family',
    'coverage': '₹50,00,000',
    'premium': '₹499/mo',
    'badge': null,
    'badgeColor': Colors.transparent,
    'whyText': 'Protect your family\'s future with term life coverage. Low premium, high coverage ensures your family never struggles financially if something happens to you.',
    'features': ['Death Benefit', 'Critical Illness Rider', 'Tax Benefits'],
    'allBenefits': ['Death Benefit', 'Critical Illness Rider', 'Tax Benefits u/s 80C', 'Premium Waiver', 'Online Policy Management', 'Nominee Support'],
  },
];
