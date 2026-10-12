import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/platform_detail_sheet.dart';
import '../widgets/earnings_calendar_sheet.dart';
import 'safety_pot_screen.dart';
import 'instant_support_screen.dart';
import '../widgets/add_platform_sheet.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String _selectedPeriod = 'Today';

  late List<Map<String, dynamic>> _platforms;

  @override
  void initState() {
    super.initState();
    _platforms = [
      {
        'name': 'Swiggy',
        'amount': '₹540',
        'color': AppTheme.orange,
        'icon': Icons.directions_bike,
        'progress': 0.54,
        'bg': AppTheme.orange.withOpacity(0.1)
      },
      {
        'name': 'Zomato',
        'amount': '₹420',
        'color': AppTheme.red,
        'icon': Icons.local_pizza,
        'progress': 0.42,
        'bg': AppTheme.red.withOpacity(0.1)
      },
      {
        'name': 'Uber',
        'amount': '₹280',
        'color': const Color(0xFF0F172A),
        'icon': Icons.directions_car,
        'progress': 0.28,
        'bg': const Color(0xFFF1F5F9)
      },
      {
        'name': 'Zepto',
        'amount': '₹150',
        'color': AppTheme.purple,
        'icon': Icons.shopping_bag_outlined,
        'progress': 0.15,
        'bg': AppTheme.purple.withOpacity(0.1)
      },
    ];
  }

  void _addPlatform(String appId) {
    // Map appId to actual display data
    final Map<String, dynamic> appMap = {
      'uber': {
        'name': 'Uber',
        'color': const Color(0xFF0F172A),
        'icon': Icons.directions_car,
        'bg': const Color(0xFFF1F5F9)
      },
      'ola': {
        'name': 'Ola',
        'color': const Color(0xFFFACC15),
        'icon': Icons.directions_car,
        'bg': const Color(0xFFFEF9C3)
      },
      'rapido': {
        'name': 'Rapido',
        'color': const Color(0xFFEAB308),
        'icon': Icons.directions_bike,
        'bg': const Color(0xFFFEF3C7)
      },
      'porter': {
        'name': 'Porter',
        'color': const Color(0xFF2563EB),
        'icon': Icons.local_shipping,
        'bg': const Color(0xFFDBEAFE)
      },
      'dunzo': {
        'name': 'Dunzo',
        'color': const Color(0xFF22C55E),
        'icon': Icons.inventory_2,
        'bg': const Color(0xFFDCFCE7)
      },
      'upwork': {
        'name': 'Upwork',
        'color': const Color(0xFF16A34A),
        'icon': Icons.work,
        'bg': const Color(0xFFDCFCE7)
      },
    };

    final base = appMap[appId.toLowerCase()] ?? appMap['uber']!;

    setState(() {
      _platforms.add({
        'name': base['name'],
        'amount': '₹0',
        'color': base['color'],
        'icon': base['icon'],
        'progress': 0.0,
        'bg': base['bg'],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildEarningsCard(),
              const SizedBox(height: 16),
              _buildPlatformCards(context),
              const SizedBox(height: 16),
              _buildSafetyAndMilestone(context),
              const SizedBox(height: 16),
              _buildEarningsTrend(),
              const SizedBox(height: 16),
              _buildPlatformPerformance(context),
              const SizedBox(height: 16),
              _buildStreak(context),
              const SizedBox(height: 16),
              _buildSmartInsights(),
              const SizedBox(height: 20),
              _buildActionButtons(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(Icons.arrow_back,
                      color: AppTheme.textDark, size: 20),
                ),
                const SizedBox(width: 8),
                const Text('My',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark)),
              ]),
              const Text('Earnings',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark)),
              const Text('Daily income tracker',
                  style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08), blurRadius: 8)
                ]),
            child: Row(
              children: ['Today', 'Week', 'Month'].map((p) {
                final sel = _selectedPeriod == p;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPeriod = p),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                        color: sel ? AppTheme.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(p,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: sel ? Colors.white : AppTheme.textGrey)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF0D4A47), Color(0xFF1A6B67)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Earned Today',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
                const Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white60, size: 14),
                    SizedBox(width: 4),
                    Text('Updated now',
                        style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
                _selectedPeriod == 'Today'
                    ? '₹1,240'
                    : _selectedPeriod == 'Week'
                        ? '₹8,450'
                        : '₹34,200',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1)),
            Text(
                _selectedPeriod == 'Today'
                    ? 'Across 3 platforms'
                    : _selectedPeriod == 'Week'
                        ? 'Avg. ₹1,207/day'
                        : '+12% vs last month',
                style: const TextStyle(color: Colors.white60, fontSize: 13)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 44,
                    height: 22,
                    child: Stack(
                      children: [
                        _platformDot(const Color(0xFFFF6B35)),
                        Positioned(
                            left: 14,
                            child: _platformDot(const Color(0xFFE53935))),
                        Positioned(
                            left: 28,
                            child: _platformDot(const Color(0xFF475569))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Top Source',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 11)),
                        Text('Swiggy (45%)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _platformDot(Color color) => Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2)),
      );

  Widget _buildPlatformCards(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ..._platforms.map((p) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => showPlatformDetails(context, p['name'] as String),
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppTheme.divider.withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: p['bg'] as Color,
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 24),
                      ),
                      const SizedBox(height: 16),
                      Text((p['name'] as String).toUpperCase(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textGrey,
                              letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text(p['amount'] as String,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark)),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: p['progress'] as double,
                          backgroundColor: AppTheme.divider,
                          valueColor:
                              AlwaysStoppedAnimation(p['color'] as Color),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Add Platform Button
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => showAddPlatformSheet(context, _addPlatform),
              child: Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                  color: AppTheme.background.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppTheme.divider,
                      style: BorderStyle
                          .solid), // Dash effect not built-in, using border for now
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ]),
                      child: const Icon(Icons.add,
                          color: AppTheme.textGrey, size: 24),
                    ),
                    const SizedBox(height: 12),
                    const Text('Add Platform',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textGrey)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyAndMilestone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SafetyPotScreen())),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppTheme.greenLight,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                    color: AppTheme.accent,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.check,
                                    color: Colors.white, size: 14)),
                            const Icon(Icons.arrow_forward_ios,
                                color: AppTheme.primary, size: 14),
                          ]),
                      const SizedBox(height: 10),
                      const Text('SAFETY POT',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                              letterSpacing: 1)),
                      const Text('₹124',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark)),
                      const Text('Saved today',
                          style:
                              TextStyle(fontSize: 12, color: AppTheme.primary)),
                    ]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04), blurRadius: 8)
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        alignment: Alignment.topRight,
                        child: Text('Goal',
                            style: TextStyle(
                                fontSize: 11, color: AppTheme.textGrey))),
                    const Row(children: [
                      Icon(Icons.north_east, color: AppTheme.purple, size: 16),
                      SizedBox(width: 4),
                      Text('NEXT MILESTONE',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textGrey,
                              letterSpacing: 0.5)),
                    ]),
                    const SizedBox(height: 6),
                    const Text('₹50,000',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                            value: 0.65,
                            backgroundColor: AppTheme.divider,
                            valueColor: AlwaysStoppedAnimation(AppTheme.purple),
                            minHeight: 6)),
                    const SizedBox(height: 4),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text('65%',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.purple))),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsTrend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10))
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
                    Text('Earnings Trend',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark)),
                    Text('Last 7 days performance',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textGrey)),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppTheme.greenLight,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, color: AppTheme.accent, size: 14),
                      SizedBox(width: 4),
                      Text('+15%',
                          style: TextStyle(
                              color: AppTheme.accent,
                              fontWeight: FontWeight.w800,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: CustomPaint(
                painter: _BarChartPainter(period: _selectedPeriod),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mon',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Tue',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Wed',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Thu',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Fri',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Sat',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
                Text('Sun',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformPerformance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('Platform Performance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(width: 10),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: AppTheme.greenLight,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('Weekly',
                    style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 16),
          ..._platforms.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: GestureDetector(
                  onTap: () =>
                      showPlatformDetails(context, p['name'] as String),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color:
                                      (p['color'] as Color).withOpacity(0.12),
                                  shape: BoxShape.circle),
                              child: Icon(p['icon'] as IconData,
                                  color: p['color'] as Color, size: 16)),
                          const SizedBox(width: 10),
                          Text(p['name'] as String,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textDark)),
                          const Spacer(),
                          Text(p['amount'] as String,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark)),
                        ]),
                        const SizedBox(height: 8),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                                value: p['progress'] as double,
                                backgroundColor: AppTheme.divider,
                                valueColor:
                                    AlwaysStoppedAnimation(p['color'] as Color),
                                minHeight: 6)),
                      ]),
                ),
              )),
        ]),
      ),
    );
  }

  Widget _buildStreak(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.orange.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
                color: AppTheme.orange.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.orange.withOpacity(0.05),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.local_fire_department,
                        color: AppTheme.orange, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('4-Day Streak!',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark)),
                        Text('Earn tomorrow to reach 5',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textGrey)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showEarningsCalendar(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppTheme.orange.withOpacity(0.3))),
                      child: const Text('View Calendar',
                          style: TextStyle(
                              color: AppTheme.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _streakDay('Mon', true),
                  _streakDay('Tue', true),
                  _streakDay('Wed', true),
                  _streakDay('Thu', true),
                  _streakDay('Fri', false),
                  _streakDay('Sat', false),
                  _streakDay('Sun', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _streakDay(String label, bool active) => Column(
        children: [
          Text(label.substring(0, 1),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: active ? AppTheme.orange : AppTheme.textLight)),
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: active ? AppTheme.orange : AppTheme.background,
              shape: BoxShape.circle,
              border: active ? null : Border.all(color: AppTheme.divider),
              boxShadow: active
                  ? [
                      BoxShadow(
                          color: AppTheme.orange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ]
                  : null,
            ),
            child: active
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        ],
      );

  Widget _buildSmartInsights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.auto_awesome, color: AppTheme.primary, size: 18),
          SizedBox(width: 8),
          Text('Smart Insights',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
              child: _insightCard(
                  Icons.flash_on,
                  'Weekend Warrior',
                  'You earn 20% more on Sat/Sun usually.',
                  AppTheme.purpleLight,
                  AppTheme.purple)),
          const SizedBox(width: 12),
          Expanded(
              child: _insightCard(
                  Icons.savings_outlined,
                  'Savings Potential',
                  'Save ₹50 more/day = ₹1,500/mo',
                  const Color(0xFFE0F7FA),
                  const Color(0xFF0097A7))),
        ]),
      ]),
    );
  }

  Widget _insightCard(IconData icon, String title, String subtitle, Color bg,
          Color iconColor) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: iconColor)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: 12, color: AppTheme.textGrey, height: 1.4)),
        ]),
      );

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SafetyPotScreen())),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
            child: const Text('Increase Daily Saving',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.divider),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Monthly Summary',
                  style: TextStyle(
                      color: AppTheme.textDark, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const InstantSupportScreen())),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.divider),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Get Instant Support',
                  style: TextStyle(
                      color: AppTheme.textDark, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final String period;
  _BarChartPainter({required this.period});

  @override
  void paint(Canvas canvas, Size size) {
    final Map<String, List<double>> periodData = {
      'Today': [1240, 950, 1450, 1100, 1800, 2100, 1950],
      'Week': [8450, 7200, 9100, 8800, 10200, 11500, 10800],
      'Month': [34200, 31000, 36500, 33000, 38000, 42000, 39000],
    };

    final data = periodData[period] ?? periodData['Today']!;
    final maxVal = data.reduce((a, b) => a > b ? a : b) * 1.2;
    final w = size.width;
    final h = size.height;
    final barWidth = (w / data.length) * 0.6;
    final xGap = (w / data.length);

    final gridPaint = Paint()
      ..color = AppTheme.divider.withOpacity(0.5)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = h - (i * h / 4);
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    final barPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxVal) * h;
      final x = (i * xGap) + (xGap - barWidth) / 2;
      final y = h - barHeight;

      barPaint.color =
          data[i] > 1500 ? const Color(0xFF0F4C5C) : const Color(0xFFCBD5E1);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(6),
        ),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
