import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_screen.dart';

class LinkBankScreen extends StatelessWidget {
  const LinkBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar - step 3 of 3
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: List.generate(3, (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Link Bank Account',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'We need this to deposit your savings from Safety Pot.',
                      style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
                    ),
                    const SizedBox(height: 24),
                    // Quote box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('"', style: TextStyle(fontSize: 40, color: AppTheme.purple.withOpacity(0.6), height: 0.8, fontWeight: FontWeight.w900)),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              '"Small daily savings can grow into a huge safety net. Link your UPI to start auto-saving ₹50/day!"',
                              style: TextStyle(fontSize: 13, color: AppTheme.textDark, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // UPI ID
                    RichText(
                      text: const TextSpan(
                        text: 'UPI ID ',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                        children: [TextSpan(text: '*', style: TextStyle(color: AppTheme.red))],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _inputField('phonenumber@upi'),
                    const SizedBox(height: 6),
                    const Text('GooglePay, PhonePe, Paytm, etc.', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    const SizedBox(height: 20),
                    const Divider(color: AppTheme.divider),
                    const SizedBox(height: 6),
                    const Text('FOR LARGE SETTLEMENTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textGrey, letterSpacing: 1.2), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    const Text('Account Number (Optional)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    _inputField('XXXXXXXXXXX'),
                    const SizedBox(height: 16),
                    const Text('IFSC Code (Optional)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    _inputField('HDFC0001234'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity, height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
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
        ),
      ),
    );
  }

  Widget _inputField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppTheme.textLight),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.divider)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.divider)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
