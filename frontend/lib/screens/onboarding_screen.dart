import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_screen.dart';
import 'link_bank_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0; // 0=work profile, 1=verify identity, 2=link bank
  String? _selectedWork;
  final Set<String> _selectedApps = {};

  final Map<String, List<Map<String, dynamic>>> _appsByWork = {
    'Delivery': [
      {'name': 'Swiggy', 'icon': Icons.directions_bike, 'color': const Color(0xFFFF6B35)},
      {'name': 'Zomato', 'icon': Icons.local_pizza, 'color': const Color(0xFFE53935)},
      {'name': 'Zepto', 'icon': Icons.flash_on, 'color': const Color(0xFF7C3AED)},
      {'name': 'Blinkit', 'icon': Icons.electric_bolt, 'color': const Color(0xFFFFB300)},
      {'name': 'Dunzo', 'icon': Icons.pedal_bike, 'color': const Color(0xFF00C896)},
    ],
    'Ride Sharing': [
      {'name': 'Uber', 'icon': Icons.directions_car, 'color': const Color(0xFF000000)},
      {'name': 'Ola', 'icon': Icons.local_taxi, 'color': const Color(0xFF000000)},
      {'name': 'Rapido', 'icon': Icons.electric_moped, 'color': const Color(0xFFFFB300)},
      {'name': 'inDrive', 'icon': Icons.car_rental, 'color': const Color(0xFF1DB954)},
    ],
    'Freelance': [
      {'name': 'Upwork', 'icon': Icons.work_outline, 'color': const Color(0xFF6FDA44)},
      {'name': 'Fiverr', 'icon': Icons.attach_money, 'color': const Color(0xFF1DBF73)},
      {'name': 'Urban Company', 'icon': Icons.home_repair_service, 'color': const Color(0xFF7C3AED)},
      {'name': 'Porter', 'icon': Icons.local_shipping, 'color': const Color(0xFFFF6B35)},
    ],
    'Logistics': [
      {'name': 'Porter', 'icon': Icons.local_shipping, 'color': const Color(0xFFFF6B35)},
      {'name': 'Delhivery', 'icon': Icons.inventory_2, 'color': const Color(0xFFD4003B)},
      {'name': 'Shadowfax', 'icon': Icons.delivery_dining, 'color': const Color(0xFF004C8F)},
    ],
  };

  final Map<String, IconData> _workIcons = {
    'Delivery': Icons.directions_bike,
    'Ride Sharing': Icons.directions_car,
    'Freelance': Icons.phone_android,
    'Logistics': Icons.local_shipping,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: _currentStep == 0
            ? _buildWorkProfileStep()
            : _currentStep == 1
                ? _buildVerifyIdentityStep()
                : _buildWorkProfileStep(),
      ),
    );
  }

  Widget _progressBar(int activeBars) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: List.generate(3, (i) => Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
            decoration: BoxDecoration(
              color: i < activeBars ? AppTheme.primary : AppTheme.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildWorkProfileStep() {
    final apps = _selectedWork != null ? _appsByWork[_selectedWork!] ?? [] : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressBar(1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text('My Work Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                const Text('Tell us what you do so we can personalize your experience.', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
                const SizedBox(height: 28),
                const Text('I work in...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: _workIcons.keys.map((w) {
                    final selected = _selectedWork == w;
                    return GestureDetector(
                      onTap: () => setState(() { _selectedWork = w; _selectedApps.clear(); }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected ? AppTheme.primary.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: selected ? AppTheme.primary : AppTheme.divider, width: selected ? 2 : 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_workIcons[w]!, color: selected ? AppTheme.primary : AppTheme.textGrey, size: 28),
                            const SizedBox(height: 8),
                            Text(w, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: selected ? AppTheme.primary : AppTheme.textGrey)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedWork != null) ...[
                  const SizedBox(height: 28),
                  const Text('My Primary App is...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: apps.map((app) {
                      final sel = _selectedApps.contains(app['name']);
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (sel) {
                            _selectedApps.remove(app['name']);
                          } else {
                            _selectedApps.add(app['name'] as String);
                          }
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: sel ? AppTheme.primary : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: sel ? AppTheme.primary : AppTheme.divider),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(app['icon'] as IconData, size: 16, color: sel ? Colors.white : app['color'] as Color),
                              const SizedBox(width: 6),
                              Text(app['name'] as String, style: TextStyle(color: sel ? Colors.white : AppTheme.textGrey, fontWeight: FontWeight.w500, fontSize: 14)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: SizedBox(
            width: double.infinity, height: 54,
            child: ElevatedButton(
              onPressed: _selectedWork != null ? () => setState(() => _currentStep = 1) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                disabledBackgroundColor: AppTheme.divider,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyIdentityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressBar(2),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: AppTheme.greenLight, shape: BoxShape.circle),
                    child: const Icon(Icons.shield_outlined, color: AppTheme.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text('VERIFY IDENTITY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.primary, letterSpacing: 1)),
                ]),
                const SizedBox(height: 16),
                const Text('Verify Identity', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                const Text("To enable large withdrawals and insurance claims, we need to verify it's you.", style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.divider)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppTheme.greenLight, shape: BoxShape.circle),
                        child: const Icon(Icons.check_circle_outline, color: AppTheme.accent, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Finva Promise', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.textDark)),
                            SizedBox(height: 4),
                            Text('Your data is encrypted with 256-bit SSL security. We never share it without permission.', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _label('PAN Card Number'),
                _inputField('ABCDE1234F'),
                const SizedBox(height: 16),
                _label('Aadhaar Number'),
                _inputField('1234 5678 9012', type: TextInputType.number),
                const SizedBox(height: 16),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.divider, style: BorderStyle.solid),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_outlined, color: AppTheme.textLight, size: 32),
                        SizedBox(height: 6),
                        Text('Upload Photos (Optional)', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
          child: SizedBox(
            width: double.infinity, height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LinkBankScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Complete Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainScreen()), (r) => false),
            child: const Text('Skip for now', style: TextStyle(color: AppTheme.textGrey, fontSize: 14)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
  );

  Widget _inputField(String hint, {TextInputType? type}) => TextField(
    keyboardType: type,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppTheme.textLight),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.divider)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.divider)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.primary)),
    ),
  );
}
