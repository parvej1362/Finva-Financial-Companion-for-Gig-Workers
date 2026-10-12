import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'banking_onboarding_screen.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  String? _selectedWorkType;
  String? _selectedPlatform;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _workTypes = [
    {'id': 'delivery', 'label': 'Delivery', 'icon': Icons.directions_bike},
    {
      'id': 'ride-sharing',
      'label': 'Ride Sharing',
      'icon': Icons.directions_car
    },
    {'id': 'freelance', 'label': 'Freelance', 'icon': Icons.smartphone},
    {'id': 'logistics', 'label': 'Logistics', 'icon': Icons.local_shipping},
  ];

  final Map<String, List<String>> _platforms = {
    'delivery': ['Swiggy', 'Zomato', 'Zepto', 'Blinkit', 'Dunzo'],
    'ride-sharing': ['Uber', 'Ola', 'Rapido', 'InDrive'],
    'freelance': ['Upwork', 'Fiverr', 'UrbanCompany', 'Porter'],
    'logistics': ['Porter', 'Delhivery', 'Shadowfax']
  };

  void _handleSubmit() {
    if (_selectedWorkType == null || _selectedPlatform == null) return;

    setState(() => _isLoading = true);
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BankingOnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                  color: AppTheme.accent,
                                  borderRadius: BorderRadius.circular(3)))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                  color: AppTheme.divider,
                                  borderRadius: BorderRadius.circular(3)))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                  color: AppTheme.divider,
                                  borderRadius: BorderRadius.circular(3)))),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'My Work Profile',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tell us what you do so we can personalize your experience.',
                    style: TextStyle(
                        fontSize: 14, color: AppTheme.textGrey, height: 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'I WORK IN...',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textGrey,
                          letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: _workTypes.length,
                      itemBuilder: (context, index) {
                        final type = _workTypes[index];
                        final isSelected = _selectedWorkType == type['id'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedWorkType = type['id'];
                              _selectedPlatform = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primary.withOpacity(0.05)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primary
                                    : AppTheme.divider,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                          color:
                                              AppTheme.primary.withOpacity(0.1),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4))
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(type['icon'],
                                    color: isSelected
                                        ? AppTheme.primary
                                        : AppTheme.textGrey,
                                    size: 28),
                                const SizedBox(height: 10),
                                Text(
                                  type['label'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                    color: isSelected
                                        ? AppTheme.primary
                                        : AppTheme.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (_selectedWorkType != null) ...[
                      const SizedBox(height: 40),
                      const Text(
                        'MY PRIMARY APP IS...',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textGrey,
                            letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _platforms[_selectedWorkType!]!.map((p) {
                          final isSelected = _selectedPlatform == p;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedPlatform = p),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: isSelected
                                        ? AppTheme.primary
                                        : AppTheme.divider),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                            color: AppTheme.primary
                                                .withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2))
                                      ]
                                    : [],
                              ),
                              child: Text(
                                p,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textDark,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_selectedWorkType == null ||
                          _selectedPlatform == null ||
                          _isLoading)
                      ? null
                      : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppTheme.divider,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Confirm & Continue',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
