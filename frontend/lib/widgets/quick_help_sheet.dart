import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showQuickHelp(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const _QuickHelpSheet(),
  );
}

class _QuickHelpSheet extends StatefulWidget {
  const _QuickHelpSheet();

  @override
  State<_QuickHelpSheet> createState() => _QuickHelpSheetState();
}

class _QuickHelpSheetState extends State<_QuickHelpSheet> {
  String _searchQuery = '';
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'getting-started',
      'label': 'Basics',
      'icon': Icons.rocket_launch,
      'color': Colors.blue
    },
    {
      'id': 'earnings',
      'label': 'Earnings',
      'icon': Icons.account_balance_wallet,
      'color': Colors.green
    },
    {
      'id': 'protection',
      'label': 'Insurance',
      'icon': Icons.shield,
      'color': Colors.purple
    },
    {
      'id': 'account',
      'label': 'Account',
      'icon': Icons.person,
      'color': Colors.orange
    },
  ];

  final Map<String, List<Map<String, String>>> _faqData = {
    'getting-started': [
      {
        'q': "What is Finva?",
        'a':
            "Finva is a financial wellness platform designed for gig workers to track earnings, save automatically, and get insured."
      },
      {
        'q': "Is Finva free to use?",
        'a':
            "Yes, the core app is free. We charge a small fee only for premium insurance plans and instant credit processing."
      },
    ],
    'earnings': [
      {
        'q': "How do I link my platform accounts?",
        'a':
            "Go to 'Linked Accounts' and select your gig platforms like Swiggy or Zomato to verify your earnings."
      },
      {
        'q': "Why is my earning data not updating?",
        'a':
            "Earning data usually updates every 24 hours. Please check your bank link status if it takes longer."
      },
    ],
    'protection': [
      {
        'q': "How do I claim insurance?",
        'a':
            "Navigate to the Protection page, select your active plan, and click 'File Claim'. Our team will guide you."
      },
    ],
    'account': [
      {
        'q': "How to update KYC?",
        'a':
            "Visit Profile > KYC Documents to upload your Aadhaar and PAN for verification."
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFaqs = [];
    if (_selectedCategory != null) {
      filteredFaqs = _faqData[_selectedCategory!] ?? [];
    } else {
      for (var list in _faqData.values) {
        filteredFaqs.addAll(list);
      }
    }

    if (_searchQuery.isNotEmpty) {
      filteredFaqs = filteredFaqs
          .where((f) =>
              f['q']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              f['a']!.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppTheme.divider,
                        borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Help Center',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textDark)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: AppTheme.background, shape: BoxShape.circle),
                      child: const Icon(Icons.close,
                          color: AppTheme.textGrey, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search for help...',
                  hintStyle:
                      const TextStyle(fontSize: 14, color: AppTheme.textLight),
                  prefixIcon: const Icon(Icons.search,
                      color: AppTheme.textLight, size: 20),
                  filled: true,
                  fillColor: AppTheme.background,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat['id'];
                    return GestureDetector(
                      onTap: () => setState(() =>
                          _selectedCategory = isSelected ? null : cat['id']),
                      child: Container(
                        width: 85,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.divider),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.1),
                                  blurRadius: 8)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(cat['icon'],
                                color: isSelected
                                    ? AppTheme.primary
                                    : cat['color'],
                                size: 22),
                            const SizedBox(height: 6),
                            Text(cat['label'],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? AppTheme.textDark
                                        : AppTheme.textGrey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Topic FAQs',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark)),
              const SizedBox(height: 16),
              if (filteredFaqs.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                      child: Text('No matching questions found.',
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.textLight))),
                )
              else
                ...filteredFaqs.map((faq) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppTheme.divider.withOpacity(0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(faq['q']!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark)),
                          const SizedBox(height: 8),
                          Text(faq['a']!,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textLight,
                                  height: 1.5)),
                        ],
                      ),
                    )),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text('Still need help?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text('Our support team is available 24/7',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6366F1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Chat with Support',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
