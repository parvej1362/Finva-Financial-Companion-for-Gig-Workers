import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showEarningsCalendar(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const _CalendarSheet(),
  );
}

class _CalendarSheet extends StatelessWidget {
  const _CalendarSheet();

  @override
  Widget build(BuildContext context) {
    final weeks = [
      [1, 2, 3, 4, 5, 6, 7],
      [8, 9, 10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19, 20, 21],
      [22, 23, 24, 25, 26, 27, 28],
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Earnings Calendar',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark)),
                      Text('February 2026',
                          style: TextStyle(
                              fontSize: 14, color: AppTheme.textGrey)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppTheme.textGrey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Streak info Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 48),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.local_fire_department,
                                color: Color(0xFFFF6B35), size: 36),
                            const SizedBox(height: 4),
                            const Text('4',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark)),
                            Text('CURRENT STREAK',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textGrey.withOpacity(0.6),
                                    letterSpacing: 1)),
                          ],
                        ),
                        const SizedBox(width: 48),
                        Container(
                            width: 1,
                            height: 48,
                            color: const Color(0xFFFFEDD5)),
                        const SizedBox(width: 48),
                        Column(
                          children: [
                            const Icon(Icons.star,
                                color: Color(0xFFEAB308), size: 36),
                            const SizedBox(height: 4),
                            const Text('9',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark)),
                            Text('BEST STREAK',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textGrey.withOpacity(0.6),
                                    letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Day headers
              Row(
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                    .map((d) => Expanded(
                          child: Center(
                              child: Text(d,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color:
                                          AppTheme.textGrey.withOpacity(0.4)))),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              // Calendar grid
              ...weeks.map((week) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: week.map((day) {
                        final isCompleted = [
                          1,
                          2,
                          3,
                          4,
                          5,
                          9,
                          10,
                          11,
                          12,
                          16,
                          17,
                          18,
                          19,
                          20
                        ].contains(day);
                        final isFreeze = [
                          13,
                          29,
                          30
                        ].contains(day); // Alignment with React MyEarnings.jsx
                        final isFuture = day > 20;

                        Color bgColor = Colors.transparent;
                        Color textColor = AppTheme.textDark;
                        Color borderColor = Colors.transparent;

                        if (isCompleted) {
                          bgColor = const Color(0xFFFF6B35);
                          textColor = Colors.white;
                        } else if (isFreeze) {
                          bgColor = const Color(0xFFECFEFF);
                          textColor = const Color(0xFF0891B2);
                          borderColor = const Color(0xFFCFFAFE);
                        } else if (isFuture) {
                          textColor = AppTheme.textGrey.withOpacity(0.3);
                        } else {
                          borderColor = AppTheme.divider;
                          textColor = AppTheme.textGrey;
                        }

                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: borderColor, width: 2),
                                  boxShadow: isCompleted
                                      ? [
                                          BoxShadow(
                                              color: const Color(0xFFFF6B35)
                                                  .withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4))
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    day.toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                              if (isCompleted) ...[
                                const SizedBox(height: 4),
                                Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFFFAD80),
                                        shape: BoxShape.circle)),
                              ] else
                                const SizedBox(height: 8),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )),
              const SizedBox(height: 16),
              // Legend
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _legendItem(const Color(0xFFFF6B35), 'Earned'),
                  _legendItem(const Color(0xFFECFEFF), 'Freeze'),
                  _legendItem(AppTheme.divider, 'Missed'),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 32),
              // Stats
              Row(
                children: [
                  Expanded(
                      child: _statBox(
                          'Active Days', '14', const Color(0xFFFF6B35))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _statBox(
                          'Best Streak', '9 days', const Color(0xFF0D4A47))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _statBox(
                          'This Month', '₹34,200', const Color(0xFF10B981))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textGrey),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
