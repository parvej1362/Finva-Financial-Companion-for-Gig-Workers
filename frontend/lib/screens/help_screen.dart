import 'package:flutter/material.dart';
import 'instant_support_screen.dart';
import '../theme/app_theme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _searchController = TextEditingController();
  String? _activeCategory;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'getting-started',
      'label': 'Getting Started',
      'icon': Icons.rocket_launch_outlined,
      'color': Colors.blue
    },
    {
      'id': 'earnings',
      'label': 'My Earnings',
      'icon': Icons.payments_outlined,
      'color': Colors.green
    },
    {
      'id': 'protection',
      'label': 'Insurance',
      'icon': Icons.shield_outlined,
      'color': Colors.purple
    },
    {
      'id': 'account',
      'label': 'Account & KYC',
      'icon': Icons.person_outline,
      'color': Colors.amber
    },
  ];

  final Map<String, List<Map<String, String>>> _faqData = {
    'getting-started': [
      {
        'q': 'What is Finva?',
        'a':
            'Finva is a financial wellness platform designed for gig workers to track earnings, save automatically, and get insured.'
      },
      {
        'q': 'Is Finva free to use?',
        'a':
            'Yes, the core app is free. We charge a small fee only for premium insurance plans and instant credit processing.'
      },
    ],
    'earnings': [
      {
        'q': 'How do I link my platform accounts?',
        'a':
            'Go to "Linked Accounts" and select your gig platforms like Swiggy or Zomato to verify your earnings.'
      },
      {
        'q': 'Why is my earning data not updating?',
        'a':
            'Earning data usually updates every 24 hours. Please check your bank link status if it takes longer.'
      },
    ],
    'protection': [
      {
        'q': 'How do I claim insurance?',
        'a':
            'Navigate to the Protection page, select your active plan, and click "File Claim". Our team will guide you.'
      },
    ],
    'account': [
      {
        'q': 'How to update KYC?',
        'a':
            'Visit Profile > KYC Documents to upload your Aadhaar and PAN for verification.'
      },
    ]
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Dark Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            decoration: const BoxDecoration(
              color: Color(0xFF1A0B2E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.chevron_left, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Help Center',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _activeCategory = null),
                  style: const TextStyle(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search for help...',
                    hintStyle:
                        const TextStyle(color: AppTheme.textGrey, fontSize: 14),
                    prefixIcon:
                        const Icon(Icons.search, color: AppTheme.textGrey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories
                  if (_searchController.text.isEmpty) ...[
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _activeCategory == cat['id'];
                        return GestureDetector(
                          onTap: () {
                            if (cat['id'] == 'getting-started') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const InstantSupportScreen()));
                            } else {
                              setState(() => _activeCategory =
                                  isSelected ? null : cat['id']);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: isSelected
                                      ? AppTheme.primary
                                      : AppTheme.divider,
                                  width: isSelected ? 2 : 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: cat['color'].withOpacity(0.1),
                                      shape: BoxShape.circle),
                                  child: Icon(cat['icon'],
                                      color: cat['color'], size: 20),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cat['label'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? AppTheme.textDark
                                          : AppTheme.textGrey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                  // FAQs
                  Row(
                    children: [
                      const Icon(Icons.help_outline,
                          color: AppTheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        _searchController.text.isNotEmpty
                            ? 'Search Results'
                            : _activeCategory != null
                                ? 'Topic FAQs'
                                : 'Common Questions',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFaqList(),
                  const SizedBox(height: 32),
                  // Contact Support
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.indigo.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: const Icon(Icons.chat_bubble_outline,
                              color: Colors.white, size: 24),
                        ),
                        const SizedBox(height: 16),
                        const Text('Still need help?',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                        const SizedBox(height: 8),
                        const Text(
                          'Our support team is available 24/7 to assist you with any issues.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, color: Colors.white70, height: 1.4),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: const Text('Chat with Support',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _contactBtn(Icons.phone_outlined, 'Call Us'),
                            const SizedBox(width: 16),
                            _contactBtn(Icons.mail_outline, 'Email'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    List<Map<String, String>> faqs = [];
    if (_activeCategory != null) {
      faqs = _faqData[_activeCategory]!;
    } else {
      faqs = _faqData.values.expand((element) => element).toList();
      if (_searchController.text.isNotEmpty) {
        faqs = faqs
            .where((f) => f['q']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    }

    if (faqs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text('No matching articles found.',
              style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
        ),
      );
    }

    return Column(
      children: faqs
          .map((f) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f['q']!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    Text(f['a']!,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textGrey,
                            height: 1.5)),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _contactBtn(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
