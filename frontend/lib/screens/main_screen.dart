import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'earnings_screen.dart';
import 'safety_pot_screen.dart';
import 'protection_screen.dart';
import 'insights_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    EarningsScreen(),
    SafetyPotScreen(),
    ProtectionScreen(),
    InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
                _buildNavItem(1, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Earnings'),
                _buildNavItem(2, Icons.savings_outlined, Icons.savings, 'Safety Pot'),
                _buildNavItem(3, Icons.shield_outlined, Icons.shield, 'Protection'),
                _buildNavItem(4, Icons.lightbulb_outline, Icons.lightbulb, 'Insights'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    // Safety Pot uses piggy bank icon
    final displayIcon = index == 2
        ? (isSelected ? Icons.savings : Icons.savings_outlined)
        : (isSelected ? activeIcon : icon);
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(displayIcon, color: isSelected ? AppTheme.primary : AppTheme.textGrey, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, color: isSelected ? AppTheme.primary : AppTheme.textGrey)),
          ],
        ),
      ),
    );
  }
}
