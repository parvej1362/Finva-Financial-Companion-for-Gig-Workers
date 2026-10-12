import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showPlatformDetails(BuildContext context, String platform) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => _PlatformDetailSheet(platform: platform),
  );
}

class _PlatformDetailSheet extends StatelessWidget {
  final String platform;
  const _PlatformDetailSheet({required this.platform});

  @override
  Widget build(BuildContext context) {
    final data = _platformData[platform] ?? _platformData['Swiggy']!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: (data['color'] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(data['icon'] as IconData,
                        color: data['color'] as Color, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(platform,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark)),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: AppTheme.accent, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          const Text('CONNECTED • VERIFIED',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.accent,
                                  letterSpacing: 0.5)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppTheme.background, shape: BoxShape.circle),
                  child: const Icon(Icons.close,
                      size: 18, color: AppTheme.textGrey),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: AppTheme.divider.withOpacity(0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('TOTAL EARNED',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textGrey,
                              letterSpacing: 0.8)),
                      const SizedBox(height: 8),
                      Text(data['totalEarned'] as String,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark)),
                    ],
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
                      border:
                          Border.all(color: AppTheme.divider.withOpacity(0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(platform == 'Uber' ? 'RIDES DONE' : 'ORDERS DONE',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textGrey,
                              letterSpacing: 0.8)),
                      const SizedBox(height: 8),
                      Text(data['orders'] as String,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Payouts',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                const SizedBox(height: 14),
                ...(data['payouts'] as List<Map<String, String>>)
                    .map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                    color: AppTheme.greenLight,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.north_east,
                                    color: AppTheme.accent, size: 16),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p['date']!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textDark)),
                                    Text(p['type']!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.textGrey)),
                                  ],
                                ),
                              ),
                              Text(p['amount']!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.accent)),
                            ],
                          ),
                        )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.divider),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View History',
                      style: TextStyle(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Done',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _platformData = {
  'Swiggy': {
    'icon': Icons.directions_bike,
    'color': Color(0xFFFF6B35),
    'totalEarned': '₹540',
    'orders': '13',
    'payouts': [
      {'date': 'Today', 'type': 'Direct Deposit', 'amount': '+₹270'},
      {'date': 'Yesterday', 'type': 'Direct Deposit', 'amount': '+₹180'},
      {'date': 'Jan 24', 'type': 'Direct Deposit', 'amount': '+₹135'},
    ],
  },
  'Zomato': {
    'icon': Icons.local_pizza,
    'color': Color(0xFFE53935),
    'totalEarned': '₹420',
    'orders': '10',
    'payouts': [
      {'date': 'Today', 'type': 'Direct Deposit', 'amount': '+₹200'},
      {'date': 'Yesterday', 'type': 'Direct Deposit', 'amount': '+₹145'},
      {'date': 'Jan 24', 'type': 'Direct Deposit', 'amount': '+₹110'},
    ],
  },
  'Uber': {
    'icon': Icons.directions_car,
    'color': Color(0xFF000000),
    'totalEarned': '₹280',
    'orders': '8',
    'payouts': [
      {'date': 'Today', 'type': 'Direct Deposit', 'amount': '+₹140'},
      {'date': 'Yesterday', 'type': 'Direct Deposit', 'amount': '+₹95'},
      {'date': 'Jan 24', 'type': 'Direct Deposit', 'amount': '+₹80'},
    ],
  },
  'Blinkit': {
    'icon': Icons.electric_bolt,
    'color': Color(0xFFFFB300),
    'totalEarned': '₹850',
    'orders': '22',
    'payouts': [
      {'date': 'Today', 'type': 'Direct Deposit', 'amount': '+₹350'},
      {'date': 'Yesterday', 'type': 'Direct Deposit', 'amount': '+₹280'},
      {'date': 'Jan 24', 'type': 'Direct Deposit', 'amount': '+₹220'},
    ],
  },
};
