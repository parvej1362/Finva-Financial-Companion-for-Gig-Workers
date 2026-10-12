import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Safety Pot',
        'body': 'You earned ₹50 in Safety Pot today!',
        'time': '2h ago',
        'icon': Icons.savings_outlined,
        'iconColor': AppTheme.yellow,
        'iconBg': const Color(0xFFFFFBE6),
      },
      {
        'title': 'Insurance Update',
        'body': 'New bike insurance plan recommended for you.',
        'time': '5h ago',
        'icon': Icons.shield_outlined,
        'iconColor': AppTheme.purple,
        'iconBg': AppTheme.purpleLight,
      },
      {
        'title': 'Daily Report',
        'body': 'Your weekly earnings report is ready.',
        'time': '1d ago',
        'icon': Icons.trending_up,
        'iconColor': AppTheme.accent,
        'iconBg': AppTheme.greenLight,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                      Text('Recent updates', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppTheme.textGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppTheme.divider),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const Divider(color: AppTheme.divider, indent: 72),
                itemBuilder: (context, i) {
                  final n = notifications[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(color: n['iconBg'] as Color, shape: BoxShape.circle),
                      child: Icon(n['icon'] as IconData, color: n['iconColor'] as Color, size: 22),
                    ),
                    title: Text(n['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(n['body'] as String, style: const TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.4)),
                        const SizedBox(height: 4),
                        Text(n['time'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(color: AppTheme.divider),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Mark all as read', style: TextStyle(color: AppTheme.textGrey, fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
