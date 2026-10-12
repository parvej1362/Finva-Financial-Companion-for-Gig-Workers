import 'package:flutter/material.dart';
import 'kyc_onboarding_screen.dart';

class BankingOnboardingScreen extends StatefulWidget {
  const BankingOnboardingScreen({super.key});

  @override
  State<BankingOnboardingScreen> createState() =>
      _BankingOnboardingScreenState();
}

class _BankingOnboardingScreenState extends State<BankingOnboardingScreen> {
  final _upiController = TextEditingController();
  final _accountController = TextEditingController();
  final _ifscController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _upiController.dispose();
    _accountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_upiController.text.isEmpty) return;

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KycOnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Progress Bar
              Row(
                children: [
                  Expanded(
                      child: Container(
                          height: 4,
                          decoration: const BoxDecoration(
                              color: Color(0xFF0F4C5C),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  bottomLeft: Radius.circular(2))))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Container(
                          height: 4,
                          decoration:
                              const BoxDecoration(color: Color(0xFF0F4C5C)))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Container(
                          height: 4,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2))))),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Link Bank Account',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 8),
              const Text(
                'We need this to deposit your savings from Safety Pot.',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 32),
              // Quote Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0E7FF)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.format_quote,
                        color: Color(0xFF6366F1), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '"Small daily savings can grow into a huge safety net. Link your UPI to start auto-saving ₹50/day!"',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3730A3),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildLabel('UPI ID *'),
              _buildTextField(
                controller: _upiController,
                hintText: 'phonenumber@upi',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 4),
              const Text(
                'GooglePay, PhonePe, Paytm, etc.',
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              // Divider with label
              Row(
                children: [
                  Expanded(
                      child:
                          Container(height: 1, color: const Color(0xFFE2E8F0))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'FOR LARGE SETTLEMENTS',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1),
                    ),
                  ),
                  Expanded(
                      child:
                          Container(height: 1, color: const Color(0xFFE2E8F0))),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabel('Account Number (Optional)'),
              _buildTextField(
                controller: _accountController,
                hintText: 'XXXXXXXXXXXX',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              _buildLabel('IFSC Code (Optional)'),
              _buildTextField(
                controller: _ifscController,
                hintText: 'HDFC0001234',
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_upiController.text.isEmpty || _isLoading)
                      ? null
                      : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F4C5C),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFCBD5E1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 20),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF334155)),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFF94A3B8), fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0F4C5C)),
        ),
      ),
    );
  }
}
