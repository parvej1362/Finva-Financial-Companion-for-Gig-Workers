import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'link_bank_screen.dart';

class EarningsConnectionScreen extends StatefulWidget {
  const EarningsConnectionScreen({super.key});

  @override
  State<EarningsConnectionScreen> createState() => _EarningsConnectionScreenState();
}

class _EarningsConnectionScreenState extends State<EarningsConnectionScreen> {
  String _selectedMethod = 'email';
  bool _isLoading = false;
  bool _showSuggestion = false;
  final TextEditingController _suggestionController = TextEditingController();
  bool _suggestionSent = false;

  final List<Map<String, dynamic>> _platforms = [
    {'name': 'Swiggy', 'icon': Icons.directions_bike, 'color': Colors.orange, 'bg': Colors.orange.withOpacity(0.1)},
    {'name': 'Zomato', 'icon': Icons.local_pizza, 'color': Colors.red, 'bg': Colors.red.withOpacity(0.1)},
    {'name': 'Uber', 'icon': Icons.directions_car, 'color': Colors.black, 'bg': Colors.grey.withOpacity(0.1)},
    {'name': 'Rapido', 'icon': Icons.directions_bike, 'color': Colors.yellow.shade700, 'bg': Colors.yellow.withOpacity(0.1)},
    {'name': 'Blinkit', 'icon': Icons.shopping_bag, 'color': Colors.green, 'bg': Colors.green.withOpacity(0.1)},
    {'name': 'Porter', 'icon': Icons.local_shipping, 'color': Colors.blue, 'bg': Colors.blue.withOpacity(0.1)},
  ];

  final List<Map<String, dynamic>> _methods = [
    {
      'id': 'email',
      'title': 'Email/SMS Alerts',
      'subtitle': 'Forward earning alerts to us',
      'icon': Icons.mail_outline,
      'recommended': true,
    },
    {
      'id': 'bank',
      'title': 'Bank Credit Signals',
      'subtitle': 'Track via bank transactions',
      'icon': Icons.account_balance_outlined,
    },
    {
      'id': 'statement',
      'title': 'Statement Upload',
      'subtitle': 'One-time setup only',
      'icon': Icons.description_outlined,
      'comingSoon': true,
    },
    {
      'id': 'manual',
      'title': 'Manual Entry',
      'subtitle': 'Temporary fallback',
      'icon': Icons.edit_note,
      'comingSoon': true,
    },
    {
      'id': 'auto',
      'title': 'Automatic Sync',
      'subtitle': 'Real-time tracking via secure API',
      'icon': Icons.bolt,
      'comingSoon': true,
      'recommended': true,
    }
  ];

  void _handleContinue() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LinkBankScreen()));
    }
  }

  void _sendSuggestion() async {
    if (_suggestionController.text.isEmpty) return;
    setState(() => _suggestionSent = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _suggestionSent = false;
        _showSuggestion = false;
        _suggestionController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thanks! We've noted your request.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Extend Your Existing Earnings Dashboards',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connect your gig platforms to unlock financial intelligence',
                      style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
                    ),
                    const SizedBox(height: 24),
                    // Trust Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.verified_user_outlined, color: AppTheme.primary, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "We don't replace these apps.",
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primary),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "We extend their verified earnings into savings, protection, and financial access.",
                                  style: TextStyle(fontSize: 12, color: AppTheme.textGrey.withOpacity(0.8), height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Your gig platforms', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _platforms.length,
                      itemBuilder: (context, index) {
                        final p = _platforms[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.divider),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: p['bg'], shape: BoxShape.circle),
                                child: Icon(p['icon'], color: p['color'], size: 20),
                              ),
                              const SizedBox(height: 8),
                              Text(p['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(4)),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle, size: 10, color: AppTheme.textLight),
                                    SizedBox(width: 2),
                                    Text('Verified', style: TextStyle(fontSize: 8, color: AppTheme.textGrey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    if (!_showSuggestion)
                      TextButton(
                        onPressed: () => setState(() => _showSuggestion = true),
                        child: const Text("Don't see your platform? Suggest it here", style: TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w600)),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.divider)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Which app do you work with?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _suggestionController,
                                    decoration: InputDecoration(
                                      hintText: 'e.g. Dunzo, Shadowfax...',
                                      hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textLight),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.divider)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _suggestionSent ? null : _sendSuggestion,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.textDark,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => setState(() => _showSuggestion = false),
                              child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppTheme.textGrey)),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                    const Text('Choose connection method', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                    const SizedBox(height: 16),
                    ..._methods.map((m) {
                      final isSelected = _selectedMethod == m['id'];
                      final isComingSoon = m['comingSoon'] ?? false;
                      return GestureDetector(
                        onTap: isComingSoon ? null : () => setState(() => _selectedMethod = m['id']),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isComingSoon ? Colors.white.withOpacity(0.5) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.divider, width: isSelected ? 2 : 1),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: isSelected ? AppTheme.primary.withOpacity(0.1) : AppTheme.background, shape: BoxShape.circle),
                                child: Icon(m['icon'], color: isSelected ? AppTheme.primary : AppTheme.textLight, size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(m['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isSelected ? AppTheme.primary : AppTheme.textDark)),
                                        const SizedBox(width: 8),
                                        if (isComingSoon)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                            child: const Text('Coming Soon', style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
                                          )
                                        else if (m['recommended'] ?? false)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                                            child: const Text('Recommended', style: TextStyle(fontSize: 8, color: Colors.green, fontWeight: FontWeight.bold)),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(m['subtitle'], style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                                  ],
                                ),
                              ),
                              if (!isComingSoon && isSelected)
                                const Icon(Icons.check_circle, color: AppTheme.primary, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Continue to Bank Linking', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
