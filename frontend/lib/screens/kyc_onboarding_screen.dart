import 'package:flutter/material.dart';
import 'main_screen.dart';

class KycOnboardingScreen extends StatefulWidget {
  const KycOnboardingScreen({super.key});

  @override
  State<KycOnboardingScreen> createState() => _KycOnboardingScreenState();
}

class _KycOnboardingScreenState extends State<KycOnboardingScreen> {
  final _panController = TextEditingController();
  final _aadhaarController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _panController.dispose();
    _aadhaarController.dispose();
    super.dispose();
  }

  void _handleComplete({bool skip = false}) {
    if (!skip &&
        (_panController.text.isEmpty || _aadhaarController.text.isEmpty)) {
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
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
                              color: Color(0xFF0F4C5C),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2))))),
                ],
              ),
              const SizedBox(height: 32),
              const Row(
                children: [
                  Icon(Icons.verified_user_outlined,
                      color: Color(0xFF0F4C5C), size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Verify Identity',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'To enable large withdrawals and insurance claims, we need to verify it\'s you.',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 32),
              // Promise Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.02), blurRadius: 10)
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Color(0xFFECFDF5), shape: BoxShape.circle),
                      child: const Icon(Icons.check_circle_outline,
                          color: Color(0xFF059669), size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Finva Promise',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color(0xFF0F172A))),
                          SizedBox(height: 4),
                          Text(
                            'Your data is encrypted with 256-bit SSL security. We never share it without permission.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildLabel('PAN Card Number'),
              _buildTextField(
                controller: _panController,
                hintText: 'ABCDE1234F',
                textCapitalization: TextCapitalization.characters,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _buildLabel('Aadhaar Number'),
              _buildTextField(
                controller: _aadhaarController,
                hintText: '1234 5678 9012',
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              // Upload Placeholder
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.image_outlined,
                        color: Color(0xFF94A3B8), size: 24),
                    SizedBox(height: 8),
                    Text('Upload Photos (Optional)',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: ((_panController.text.isEmpty ||
                              _aadhaarController.text.isEmpty) ||
                          _isLoading)
                      ? null
                      : () => _handleComplete(),
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
                            Text('Complete Verification',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 20),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => _handleComplete(skip: true),
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF94A3B8)),
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
