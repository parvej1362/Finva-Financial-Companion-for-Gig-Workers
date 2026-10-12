import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/quick_help_sheet.dart';
import 'earnings_screen.dart';
import 'safety_pot_screen.dart';
import 'protection_screen.dart';
import 'insights_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'bank_accounts_screen.dart';
import 'instant_support_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.slate50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  _buildTotalBalance(context),
                  const SizedBox(height: 16),
                  _buildStabilityInsights(context),
                  const SizedBox(height: 16),
                  _buildSafetyPotBanner(context),
                  const SizedBox(height: 16),
                  _buildEarningsPattern(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A0B2E), // Deep purple from frontend
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          // Background Decorations (Top Right)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Background Decorations (Bottom Left)
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Zap Icon decoration
          Positioned(
            top: 100,
            right: 40,
            child: Icon(
              Icons.bolt,
              color: Colors.yellow.withOpacity(0.8),
              size: 24,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileScreen())),
                        child: Transform.rotate(
                          angle: 0.05, // 3 degrees approx
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xFFFFF1A6), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'RK',
                                style: TextStyle(
                                    color: Color(0xFF78350F),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _headerIcon(
                              Icons.help_outline, () => showQuickHelp(context)),
                          const SizedBox(width: 12),
                          _headerIcon(Icons.notifications_none, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const NotificationsScreen()));
                          }, hasBadge: true),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Save up to ₹500\non your insurance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Don't risk it, grab a safety plan and ride worry-free. Use code FINVA500",
                              style: TextStyle(
                                  color: Color(0xFFC7D2FE),
                                  fontSize: 12,
                                  height: 1.4),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ProtectionScreen())),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF1A0B2E),
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.3),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Get Insured',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                  SizedBox(width: 4),
                                  Icon(Icons.chevron_right, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Illustration replacement matching DashboardHeader.jsx
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            Transform.rotate(
                              angle: 0.05,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFC084FC),
                                      Color(0xFF6366F1)
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    )
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(Icons.shield,
                                      color: Colors.white, size: 48),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A0B2E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.purple, width: 3),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A0B2E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.indigo, width: 3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon, VoidCallback onTap,
      {bool hasBadge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            if (hasBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF1A0B2E), width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('QUICK ACTIONS',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.slate400,
                  letterSpacing: 1.5)),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 8,
            children: [
              _quickActionBtn(
                  context,
                  Icons.account_balance_outlined,
                  'Link Bank',
                  const Color(0xFF3B82F6),
                  const Color(0xFFEFF6FF), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BankAccountsScreen()));
              }),
              _quickActionBtn(
                  context,
                  Icons.account_balance_wallet_outlined,
                  'Earnings',
                  const Color(0xFF10B981),
                  const Color(0xFFECFDF5), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EarningsScreen()));
              }),
              _quickActionBtn(context, Icons.savings_outlined, 'Safety Pot',
                  const Color(0xFFF59E0B), const Color(0xFFFFFBEB), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SafetyPotScreen()));
              }),
              _quickActionBtn(context, Icons.shield_outlined, 'Insure',
                  const Color(0xFF6366F1), const Color(0xFFEEF2FF), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProtectionScreen()));
              }),
              _quickActionBtn(context, Icons.flash_on_outlined, 'Support',
                  const Color(0xFFEF4444), const Color(0xFFFEF2F2), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const InstantSupportScreen()));
              }),
              _quickActionBtn(context, Icons.track_changes_outlined, 'Set Goal',
                  const Color(0xFF06B6D4), const Color(0xFFECFEFF), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SafetyPotScreen()));
              }),
              _quickActionBtn(
                  context,
                  Icons.help_outline,
                  'Help',
                  const Color(0xFF6366F1),
                  const Color(0xFFEEF2FF),
                  () => showQuickHelp(context)),
              _quickActionBtn(context, Icons.lightbulb_outline, 'Insights',
                  const Color(0xFFFACC15), const Color(0xFFFEFCE8), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const InsightsScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickActionBtn(BuildContext context, IconData icon, String label,
      Color color, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.1), blurRadius: 10)
                ]),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.slate700,
                  fontWeight: FontWeight.w700,
                  height: 1.1)),
        ],
      ),
    );
  }

  Widget _buildTotalBalance(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const EarningsScreen())),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL BALANCE',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.slate400,
                        letterSpacing: 1.5)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppTheme.emerald50,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up,
                          color: AppTheme.emerald600, size: 12),
                      SizedBox(width: 4),
                      Text('+12%',
                          style: TextStyle(
                              color: AppTheme.emerald600,
                              fontSize: 10,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('₹4,850',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.slate900)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    _appDot(const Color(0xFFF97316), 0),
                    Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: _appDot(const Color(0xFFEF4444), 0)),
                    Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: _appDot(const Color(0xFF0F172A), 0)),
                    Padding(
                        padding: const EdgeInsets.only(left: 42),
                        child: _appDot(const Color(0xFFFACC15), 0)),
                  ],
                ),
                const Text('4 Apps Linked',
                    style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.slate400,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appDot(Color color, double offset) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
        ],
      ),
    );
  }

  Widget _buildStabilityInsights(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bolt_outlined,
                        color: AppTheme.slate300, size: 16),
                    SizedBox(width: 8),
                    Text('BEHAVIORAL STABILITY',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.slate400,
                            letterSpacing: 1.5)),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const InstantSupportScreen()),
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.slate900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('85%',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.slate900,
                        letterSpacing: -0.5)),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.emerald600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('STABLE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _StabilityInsightItem(
              label: 'Consistency',
              score: 32,
              max: 40,
              color: Color(0xFF3B82F6),
              description:
                  'Measures income fluctuation. Keeping your daily earnings close to your average over 14 days proves reliability.',
            ),
            const SizedBox(height: 12),
            const _StabilityInsightItem(
              label: 'Active Days',
              score: 22,
              max: 25,
              color: AppTheme.finvaTeal,
              description:
                  'Captures your work habit. The more days you earn in a fortnightly cycle, the higher your behavioral trust.',
            ),
            const SizedBox(height: 12),
            const _StabilityInsightItem(
              label: 'Resilience',
              score: 18,
              max: 20,
              color: Color(0xFF6366F1),
              description:
                  'Reduces dependency risk. Spreading earnings across platforms ensures you aren\'t reliant on one app.',
            ),
            const SizedBox(height: 12),
            const _StabilityInsightItem(
              label: 'Discipline',
              score: 12,
              max: 15,
              color: Color(0xFFF59E0B),
              description:
                  'Direct signal of protectiveness. Sticking to your Safety Pot rules without breaches shows long-term intent.',
            ),
          ],
        ),
      ),
    );
  } // End of _buildStabilityInsights
} // End of HomeScreen class

class _StabilityInsightItem extends StatefulWidget {
  final String label;
  final int score;
  final int max;
  final Color color;
  final String description;

  const _StabilityInsightItem({
    required this.label,
    required this.score,
    required this.max,
    required this.color,
    required this.description,
  });

  @override
  State<_StabilityInsightItem> createState() => _StabilityInsightItemState();
}

class _StabilityInsightItemState extends State<_StabilityInsightItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(widget.label.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.slate400,
                          letterSpacing: 1)),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.5 : 0,
                    child: const Icon(Icons.expand_more,
                        size: 14, color: AppTheme.slate300),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '${widget.score}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.slate900)),
                    TextSpan(
                        text: ' /${widget.max}',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.slate400)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 4,
              width: double.infinity,
              color: AppTheme.slate100,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: widget.score / widget.max,
                child: Container(color: widget.color),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.slate900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('HOW IT WORKS',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.slate400,
                          letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(widget.description,
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.4)),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

extension on HomeScreen {
  Widget _buildSafetyPotBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const SafetyPotScreen())),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00A896),
                Color(0xFF059669)
              ]), // Finva Teal to Emerald
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
                color: AppTheme.finvaTeal.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8))
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Safety Pot',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFBBF24),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text('ACTIVE',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF78350F))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('You saved ₹50 today automatically.',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SafetyPotScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.finvaTeal,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('View Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.shield, color: Colors.white, size: 36),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsPattern() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)
        ],
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
                  Text('Earnings Pattern',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A))),
                  Text('Last 7 days activity',
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFF1F5F9))),
                child: Row(
                  children: [
                    _periodTab('7D', true),
                    _periodTab('30D', false),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 140,
            child: CustomPaint(
              painter: _AreaChartPainter(),
              child: Container(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Text(d,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w600)))
                .toList(),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: Color(0xFF64748B)),
                SizedBox(width: 8),
                Text('Tip: Weekends are your peak time.',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodTab(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: active
            ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
            : null,
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color:
                  active ? const Color(0xFF0F4C5C) : const Color(0xFF94A3B8))),
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0F4C5C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF0F4C5C).withOpacity(0.15),
          const Color(0xFF0F4C5C).withOpacity(0)
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.16, size.height * 0.6),
      Offset(size.width * 0.33, size.height * 0.75),
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.66, size.height * 0.55),
      Offset(size.width * 0.83, size.height * 0.1),
      Offset(size.width, size.height * 0.25),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      final xc = (points[i - 1].dx + points[i].dx) / 2;
      final yc = (points[i - 1].dy + points[i].dy) / 2;
      path.quadraticBezierTo(points[i - 1].dx, points[i - 1].dy, xc, yc);
    }
    path.lineTo(points.last.dx, points.last.dy);

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Dots
    final dotPaint = Paint()..color = Colors.white;
    final dotStroke = Paint()
      ..color = const Color(0xFF0F4C5C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4, dotPaint);
      canvas.drawCircle(points[i], 4, dotStroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
