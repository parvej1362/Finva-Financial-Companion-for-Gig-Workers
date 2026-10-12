import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'worker_profile_screen.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _consentEarnings = false;
  bool _consentBank = false;

  bool get _canContinue => _consentEarnings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Data, Your Control',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textDark)),
                            SizedBox(height: 4),
                            Text('Understand how we use your information',
                                style: TextStyle(
                                    fontSize: 13, color: AppTheme.textGrey)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppTheme.accent.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.shield_outlined,
                              color: AppTheme.accent, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8)
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your earnings, used only with your permission',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark)),
                          SizedBox(height: 8),
                          Text(
                              "We're committed to transparency and giving you complete control over your data",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textGrey,
                                  height: 1.4)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('What we do:',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 12),
                    _doItem(
                      icon: Icons.visibility_outlined,
                      iconColor: AppTheme.accent,
                      iconBg: AppTheme.greenLight,
                      title: 'Analyze earnings you provide',
                      subtitle:
                          'We analyze earnings data you sync or provide to give you financial insights',
                      isPositive: true,
                    ),
                    const SizedBox(height: 10),
                    _doItem(
                      icon: Icons.check_circle_outline,
                      iconColor: AppTheme.yellow,
                      iconBg: const Color(0xFFFFFBE6),
                      title: 'Extend verified earnings',
                      subtitle:
                          'We build on top of earnings already verified by your gig platforms',
                      isPositive: true,
                    ),
                    const SizedBox(height: 24),
                    const Text("What we don't do:",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 12),
                    _doItem(
                      icon: Icons.block,
                      iconColor: AppTheme.red,
                      iconBg: AppTheme.redLight,
                      title: 'Replace Swiggy, Zomato, Uber, etc.',
                      subtitle:
                          "We're not a gig platform. We extend your existing platforms' functionality",
                      isPositive: false,
                    ),
                    const SizedBox(height: 10),
                    _doItem(
                      icon: Icons.block,
                      iconColor: AppTheme.red,
                      iconBg: AppTheme.redLight,
                      title: 'Lend money ourselves',
                      subtitle:
                          "We don't provide loans. We help you save and access financial products",
                      isPositive: false,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your Consent',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark)),
                          const SizedBox(height: 16),
                          _consentRow(
                            title: 'I consent to earnings data analysis *',
                            subtitle:
                                'Required to provide financial intelligence and savings features',
                            value: _consentEarnings,
                            onChanged: (v) =>
                                setState(() => _consentEarnings = v!),
                          ),
                          const SizedBox(height: 14),
                          _consentRow(
                            title:
                                'I consent to bank linking for savings (Optional)',
                            subtitle:
                                'Link your bank for automatic Safety Pot savings and better insights',
                            value: _consentBank,
                            onChanged: (v) => setState(() => _consentBank = v!),
                          ),
                          const SizedBox(height: 14),
                          const Row(
                            children: [
                              Icon(Icons.refresh,
                                  size: 14, color: AppTheme.textGrey),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                    'You can revoke consent anytime from your profile settings',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppTheme.textGrey)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _canContinue
                      ? () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WorkerProfileScreen()))
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _canContinue ? AppTheme.primary : AppTheme.divider,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Agree & Continue Securely',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doItem(
      {required IconData icon,
      required Color iconColor,
      required Color iconBg,
      required String title,
      required String subtitle,
      required bool isPositive}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textGrey, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _consentRow(
      {required String title,
      required String subtitle,
      required bool value,
      required ValueChanged<bool?> onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.textGrey, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}
