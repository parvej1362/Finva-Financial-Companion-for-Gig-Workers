import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'bank_accounts_screen.dart';
import 'personal_info_screen.dart';
import 'kyc_documents_screen.dart';
import 'language_screen.dart';
import 'help_screen.dart';
import 'privacy_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsOn = true;
  bool _biometricOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Dark purple header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A0A4A), Color(0xFF3B1FA8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 8),
                    const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                    const Spacer(),
                    const Icon(Icons.settings_outlined, color: Colors.white70, size: 24),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Card overlapping header
                  Transform.translate(
                    offset: const Offset(0, -60),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4))],
                          border: const Border(top: BorderSide(color: AppTheme.orange, width: 3)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 80, height: 80,
                                  decoration: const BoxDecoration(color: AppTheme.divider, shape: BoxShape.circle),
                                  child: const Icon(Icons.person_outline, size: 48, color: AppTheme.textLight),
                                ),
                                Positioned(
                                  right: 0, bottom: 0,
                                  child: Container(
                                    width: 26, height: 26,
                                    decoration: BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text('PARVEJ MULANI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                            const SizedBox(height: 4),
                            const Text('Delivery  •  Member Since Feb 2026', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.greenLight,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, color: AppTheme.accent, size: 14),
                                  SizedBox(width: 4),
                                  Text('Verified Account', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.accent)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Total Savings', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                                      SizedBox(height: 4),
                                      Text('₹0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Account section — offset to compensate
                  Transform.translate(
                    offset: const Offset(0, -44),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                          const SizedBox(height: 12),
                          _settingsCard([
                            _menuItem(Icons.person_outlined, 'Personal Information', 'Name, Phone, Email', AppTheme.accent, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen()));
                            }),
                            _divider(),
                            _menuItem(Icons.account_balance_outlined, 'Linked Bank Accounts', 'HDFC, SBI', AppTheme.purple, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const BankAccountsScreen()));
                            }),
                            _divider(),
                            _menuItem(Icons.description_outlined, 'KYC Documents', 'Aadhar, PAN (Verified)', AppTheme.orange, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const KycDocumentsScreen()));
                            }),
                          ]),
                          const SizedBox(height: 20),
                          const Text('App Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                          const SizedBox(height: 12),
                          _settingsCard([
                            _switchItem(Icons.notifications_outlined, 'Notifications', AppTheme.yellow, _notificationsOn, (v) => setState(() => _notificationsOn = v)),
                            _divider(),
                            _switchItem(Icons.lock_outlined, 'Biometric Login', AppTheme.purple, _biometricOn, (v) => setState(() => _biometricOn = v)),
                            _divider(),
                            _menuItem(Icons.language_outlined, 'Language', 'English (US)', AppTheme.accent, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
                            }),
                          ]),
                          const SizedBox(height: 20),
                          const Text('Support', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                          const SizedBox(height: 12),
                          _settingsCard([
                            _menuItem(Icons.help_outline, 'Help & Support', null, Colors.blueGrey, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
                            }),
                            _divider(),
                            _menuItem(Icons.shield_outlined, 'Privacy & Terms', null, Colors.blueGrey, () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen()));
                            }),
                          ]),
                          const SizedBox(height: 20),
                          // Log Out
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.redLight,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: TextButton.icon(
                              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                              icon: const Icon(Icons.logout, color: AppTheme.red),
                              label: const Text('Log Out', style: TextStyle(color: AppTheme.red, fontWeight: FontWeight.w700, fontSize: 16)),
                              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              'Version 1.0.2  •  Made with ❤ for Gig Workers',
                              style: TextStyle(fontSize: 11, color: AppTheme.textGrey),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Column(children: children),
    );
  }

  Widget _menuItem(IconData icon, String title, String? subtitle, Color iconColor, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)) : null,
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textLight, size: 20),
    );
  }

  Widget _switchItem(IconData icon, String title, Color iconColor, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
      trailing: Switch(value: value, onChanged: onChanged, activeThumbColor: AppTheme.primary),
    );
  }

  Widget _divider() => const Divider(height: 1, indent: 16, endIndent: 16, color: AppTheme.divider);
}
