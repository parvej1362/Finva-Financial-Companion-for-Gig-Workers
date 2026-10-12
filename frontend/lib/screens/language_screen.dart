import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLang = 'en';

  final List<Map<String, String>> _languages = [
    {'id': 'en', 'name': 'English', 'native': 'English'},
    {'id': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
    {'id': 'mr', 'name': 'Marathi', 'native': 'मराठी'},
    {'id': 'kn', 'name': 'Kannada', 'native': 'kannada'},
    {'id': 'ta', 'name': 'Tamil', 'native': 'தமிழ்'},
    {'id': 'te', 'name': 'Telugu', 'native': 'తెలుగు'},
    {'id': 'bn', 'name': 'Bengali', 'native': 'বাংলা'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Dark Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 100),
            decoration: const BoxDecoration(
              color: Color(0xFF1A0B2E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Select Language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ),
          ),
          // Scrollable Content
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -60),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _languages.length + 1,
                itemBuilder: (context, index) {
                  if (index == _languages.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Confirm Selection', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    );
                  }

                  final lang = _languages[index];
                  final isSelected = _selectedLang == lang['id'];

                  return GestureDetector(
                    onTap: () => setState(() => _selectedLang = lang['id']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.divider),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withOpacity(0.2) : AppTheme.background,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                lang['id']!.toUpperCase(),
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : AppTheme.textGrey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang['native']!,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppTheme.textDark),
                                ),
                                Text(
                                  lang['name']!,
                                  style: TextStyle(fontSize: 10, color: isSelected ? Colors.white.withOpacity(0.7) : AppTheme.textGrey),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.check, size: 14, color: AppTheme.primary),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
