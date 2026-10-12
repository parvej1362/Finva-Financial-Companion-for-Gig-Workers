import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  bool _showWhy = false;

  final List<Map<String, dynamic>> _insightCards = [
    {
      'title': "Best time to work",
      'insight': "You earn 22% more per hour between 6–9 PM.",
      'action': "Shift 1 hour to evening to earn more.",
      'icon': Icons.schedule,
      'color': const Color(0xFFEEF2FF),
      'iconColor': Colors.indigo,
      'border': const Color(0xFFE0E7FF),
    },
    {
      'title': "Platform to prioritize",
      'insight':
          "Blinkit gives higher earnings per hour than Zomato this week.",
      'action': "Consider allocating more time to Blinkit today.",
      'icon': Icons.flash_on,
      'color': const Color(0xFFFFFBEB),
      'iconColor': Colors.amber,
      'border': const Color(0xFFFEF3C7),
    },
    {
      'title': "Work smart, not longer",
      'insight': "Earnings drop after 7.5 hours of work.",
      'action': "Taking a break may keep income stable.",
      'icon': Icons.battery_charging_full,
      'color': const Color(0xFFFFF1F2),
      'iconColor': const Color(0xFFE11D48),
      'border': const Color(0xFFFFE4E6),
    },
    {
      'title': "Smart saving moment",
      'insight': "On high-income days, saving ₹50 improves week stability.",
      'action': "Auto-save today?",
      'icon': Icons.savings,
      'color': const Color(0xFFECFDF5),
      'iconColor': const Color(0xFF059669),
      'border': const Color(0xFFD1FAE5),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(Icons.arrow_back,
                          color: AppTheme.textDark),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4)
                              ]),
                          child: const Icon(Icons.lightbulb,
                              color: AppTheme.yellow, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Text('DAILY ADVISOR',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textGrey,
                                letterSpacing: 1)),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  'Your work insights\nfor today',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                      height: 1.2),
                ),
              ),

              // Top Suggestion Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppTheme.primary, Color(0xFF06B6D4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.primary.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10))
                    ],
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE0F7FA),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text('Top Suggestion',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0097A7))),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _showWhy = !_showWhy),
                              child: Row(
                                children: [
                                  const Icon(Icons.help_outline,
                                      color: AppTheme.textLight, size: 14),
                                  const SizedBox(width: 4),
                                  Text('Why?',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: _showWhy
                                              ? AppTheme.primary
                                              : AppTheme.textLight)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: AppTheme.textDark,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(text: 'Working '),
                              TextSpan(
                                  text: '1 hour on Blinkit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.primary)),
                              TextSpan(
                                  text:
                                      ' between 6–9 PM could increase today\'s earnings by '),
                              TextSpan(
                                  text: '₹180',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF059669))),
                              TextSpan(text: ' .'),
                            ],
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: _showWhy
                              ? Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: AppTheme.background,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: AppTheme.divider)),
                                      child: const Text(
                                          'Based on platform surge data: Blinkit has a 1.4x surge predicted for this evening in your zone.',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textGrey,
                                              height: 1.5)),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Insight Cards Section (Snap scroll)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _insightCards.length,
                  itemBuilder: (context, index) {
                    final card = _insightCards[index];
                    return Container(
                      width: 260,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: card['border']),
                        boxShadow: [
                          BoxShadow(
                              color: card['iconColor'].withOpacity(0.05),
                              blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: card['color'],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(card['icon'],
                                    color: card['iconColor'], size: 18),
                              ),
                              const SizedBox(width: 10),
                              Text(card['title'].toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: card['iconColor'],
                                      letterSpacing: 0.5)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(card['insight'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textDark,
                                    height: 1.3)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppTheme.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.divider)),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                      color: AppTheme.textDark,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.north_east,
                                      color: Colors.white, size: 8),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(card['action'],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppTheme.textGrey))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 24),

              // Platform Performance
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Platform Performance',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 15)
                        ],
                      ),
                      child: Column(
                        children: [
                          _platformPerfRow(
                            Icons.directions_bike,
                            'Blinkit',
                            '₹850 today',
                            '₹140/hr',
                            Colors.amber,
                            0.85,
                          ),
                          const SizedBox(height: 20),
                          _platformPerfRow(
                            Icons.local_pizza,
                            'Zomato',
                            '₹620 today',
                            '₹110/hr',
                            Colors.red,
                            0.65,
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppTheme.background,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      color: AppTheme.primary, size: 18),
                                  SizedBox(width: 8),
                                  Text('Add Platform',
                                      style: TextStyle(
                                          color: AppTheme.primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13)),
                                  Spacer(),
                                  Icon(Icons.lock_outline,
                                      color: AppTheme.textLight, size: 14),
                                  SizedBox(width: 4),
                                  Text('Use same bank?',
                                      style: TextStyle(
                                          color: AppTheme.textLight,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Prediction Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2), blurRadius: 20)
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.auto_awesome,
                                  color: Color(0xFF10B981), size: 16),
                              SizedBox(width: 8),
                              Text('PREDICTION',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFD1FAE5),
                                      letterSpacing: 1.5)),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Based on 14d & weekday patterns",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Tomorrow's expected range",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 13)),
                      SizedBox(height: 8),
                      Text(
                        '₹900 – ₹1,100',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shield_outlined,
                        color: AppTheme.textLight, size: 12),
                    SizedBox(width: 4),
                    Text('Insights personalized using bank & platform data',
                        style:
                            TextStyle(fontSize: 10, color: AppTheme.textLight)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _platformPerfRow(IconData icon, String name, String todayAmt,
      String rate, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                Text(todayAmt,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(rate,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark)),
                const Text('Avg. rate',
                    style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.divider,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
