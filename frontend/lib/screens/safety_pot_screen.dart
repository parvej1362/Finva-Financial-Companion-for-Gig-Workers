import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SafetyPotScreen extends StatefulWidget {
  const SafetyPotScreen({super.key});

  @override
  State<SafetyPotScreen> createState() => _SafetyPotScreenState();
}

class _SafetyPotScreenState extends State<SafetyPotScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFECFDF5).withOpacity(0.5),
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildStatsGrid(),
                  const SizedBox(height: 32),
                  // Rules and Streak Row/Grid
                  Column(
                    children: [
                      _buildProtectionRuleCard(),
                      const SizedBox(height: 24),
                      _buildDisciplineStreakCard(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildRecoveryStrategyCard(),
                  const SizedBox(height: 24),
                  _buildEducationalCard(),
                  const SizedBox(height: 100), // Bottom spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.chevron_left_rounded,
                      color: Color(0xFF047857), size: 28),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shield_rounded,
                          color: AppTheme.emerald600, size: 14),
                      SizedBox(width: 4),
                      Text('BEHAVIORAL LEDGER',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF059669),
                              letterSpacing: 1)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.02), blurRadius: 4)
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFECFDF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_rounded,
                        color: Color(0xFF10B981), size: 16),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DISCIPLINE SCORE',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF94A3B8),
                              letterSpacing: 0.5)),
                      Text('12/15',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                  text: 'Safety ',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: -1)),
              TextSpan(
                  text: 'Pot',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF10B981),
                      letterSpacing: -1)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "How much have you not spent today?",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'EARNED TODAY',
                '₹1,240',
                Icons.trending_up_rounded,
                const Color(0xFF3B82F6),
                'Updated just now',
                const Color(0xFFEFF6FF),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'AVAILABLE TO SPEND',
                '₹840',
                Icons.account_balance_wallet_rounded,
                const Color(0xFFF59E0B),
                'Estimated free balance',
                const Color(0xFFFFFBEB),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Icon(Icons.shield_rounded,
                    size: 120, color: Colors.white.withOpacity(0.1)),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SAFETY POT',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.white70,
                          letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('₹400',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.white70, size: 14),
                      SizedBox(width: 4),
                      Text('Mental safety boundary',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color,
      String subtitle, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF94A3B8),
                      letterSpacing: 0.5)),
              Icon(icon, color: color.withOpacity(0.2), size: 24),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.arrow_outward_rounded, color: color, size: 10),
              const SizedBox(width: 2),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 8, fontWeight: FontWeight.w900, color: color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProtectionRuleCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings_rounded,
                          color: Color(0xFF94A3B8), size: 16),
                      SizedBox(width: 8),
                      Text('Protection Rule',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A))),
                    ],
                  ),
                  Text('Boundary settings',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8))),
                ],
              ),
              GestureDetector(
                onTap: () => _showModifyRules(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit_rounded,
                          color: Color(0xFF0F172A), size: 14),
                      SizedBox(width: 4),
                      Text('Change Rule',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02), blurRadius: 4)
                    ],
                  ),
                  child: const Icon(Icons.shield_rounded,
                      color: Color(0xFF10B981), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('FIXED DAILY',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF0F172A))),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('ACTIVE',
                                style: TextStyle(
                                    fontSize: 6,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF059669))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text('Protect first ₹200 earned today',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B))),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history_rounded,
                            color: Color(0xFF10B981), size: 14),
                        SizedBox(width: 4),
                        Text('Day 12',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF10B981))),
                      ],
                    ),
                    Text('CONSISTENCY',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 1)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisciplineStreakCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.history_rounded, color: Color(0xFF94A3B8), size: 18),
              SizedBox(width: 8),
              Text('Discipline Streak',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar(1, 40),
              _buildBar(2, 60),
              _buildBar(3, 80),
              _buildBar(4, 30),
              _buildBar(5, 100),
              _buildBar(6, 70),
              _buildBar(7, 90),
            ],
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'You need 15 days of discipline to unlock a 2.5x credit multiplier.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(int day, double height) {
    bool isActive = day <= 5; // Mocking 5 days streak
    return Column(
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF10B981) : const Color(0xFFF1F5F9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        Text('D$day',
            style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: Color(0xFF94A3B8))),
      ],
    );
  }

  Widget _buildRecoveryStrategyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  color: Color(0xFFFB923C), size: 18),
              SizedBox(width: 8),
              Text('Recovery Strategy',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ],
          ),
          SizedBox(height: 20),
          Icon(Icons.check_circle_rounded, color: Color(0xFF34D399), size: 48),
          SizedBox(height: 12),
          Text('All Good',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
          Text('NO RECOVERY NEEDED',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF475569),
                  letterSpacing: 1.2)),
        ],
      ),
    );
  }

  Widget _buildEducationalCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('What is Safety Pot?',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A))),
          const SizedBox(height: 16),
          _buildInfoItem('Built-in mental boundary for your finances.'),
          _buildInfoItem('Adapts to your dynamic gig earnings.'),
          _buildInfoItem('Improves credit eligibility automatically.'),
          _buildInfoItem('Zero risk, behavior based protection.'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E8F0),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569))),
          ),
        ],
      ),
    );
  }

  void _showModifyRules(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ModifyRulesSheet(),
    );
  }
}

class _ModifyRulesSheet extends StatefulWidget {
  const _ModifyRulesSheet();
  @override
  State<_ModifyRulesSheet> createState() => _ModifyRulesSheetState();
}

class _ModifyRulesSheetState extends State<_ModifyRulesSheet> {
  String _selectedType = 'fixed'; // 'fixed', 'min_balance', 'percentage'
  double _value = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Protection Rule',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A))),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded,
                      size: 20, color: Color(0xFF0F172A)),
                ),
              ),
            ],
          ),
          const Text('Your behavioral spending boundary settings',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 32),
          const Text('CHOOSE STRATEGY',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.5)),
          const SizedBox(height: 16),
          _strategyOption(
            'fixed',
            'Fixed Daily',
            'Protect ₹X every earning day',
            Icons.calendar_today_rounded,
          ),
          const SizedBox(height: 12),
          _strategyOption(
            'min_balance',
            'Min Balance',
            'Always keep ₹Y protected',
            Icons.account_balance_wallet_rounded,
          ),
          const SizedBox(height: 12),
          _strategyOption(
            'percentage',
            'Percentage',
            'Protect Z% on good days',
            Icons.percent_rounded,
          ),
          const SizedBox(height: 32),
          Text(_selectedType == 'percentage' ? 'PERCENTAGE (%)' : 'AMOUNT (₹)',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          Row(
            children: [
              _circleBtn(
                  Icons.remove_rounded,
                  () => setState(() {
                        if (_selectedType == 'percentage') {
                          _value = (_value - 1).clamp(1, 40);
                        } else {
                          _value = (_value - 50).clamp(50, 2000);
                        }
                      })),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9))),
                  child: Center(
                      child: Text(
                          _selectedType == 'percentage'
                              ? '${_value.toInt()}%'
                              : '₹${_value.toInt()}',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A)))),
                ),
              ),
              _circleBtn(
                  Icons.add_rounded,
                  () => setState(() {
                        if (_selectedType == 'percentage') {
                          _value = (_value + 1).clamp(1, 40);
                        } else {
                          _value = (_value + 50).clamp(50, 2000);
                        }
                      })),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text('Confirm Protection Plan',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _strategyOption(
      String type, String title, String desc, IconData icon) {
    bool isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedType = type;
        if (type == 'percentage') {
          _value = 10.0;
        } else {
          _value = 200.0;
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF10B981) : const Color(0xFFF1F5F9),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF10B981)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                  size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: isSelected
                              ? const Color(0xFF059669)
                              : const Color(0xFF0F172A))),
                  Text(desc,
                      style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xFF059669).withOpacity(0.7)
                              : const Color(0xFF64748B),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF10B981), size: 24),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF1F5F9))),
            child: Icon(icon, size: 24, color: const Color(0xFF0F172A))),
      );
}
