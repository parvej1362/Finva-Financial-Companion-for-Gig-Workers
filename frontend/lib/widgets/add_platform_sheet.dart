import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showAddPlatformSheet(BuildContext context, Function(String) onAdd) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AddPlatformSheet(onAdd: onAdd),
  );
}

class _AddPlatformSheet extends StatefulWidget {
  final Function(String) onAdd;
  const _AddPlatformSheet({required this.onAdd});

  @override
  State<_AddPlatformSheet> createState() => _AddPlatformSheetState();
}

class _AddPlatformSheetState extends State<_AddPlatformSheet> {
  int _step = 1;
  String? _selectedApp;
  String _selectedBank = 'hdfc';

  final List<Map<String, dynamic>> _apps = [
    {
      'id': 'uber',
      'name': 'Uber',
      'color': Colors.black,
      'icon': Icons.directions_car
    },
    {
      'id': 'ola',
      'name': 'Ola',
      'color': const Color(0xFFFACC15),
      'icon': Icons.directions_car
    },
    {
      'id': 'rapido',
      'name': 'Rapido',
      'color': const Color(0xFFEAB308),
      'icon': Icons.directions_bike
    },
    {
      'id': 'porter',
      'name': 'Porter',
      'color': const Color(0xFF2563EB),
      'icon': Icons.local_shipping
    },
    {
      'id': 'dunzo',
      'name': 'Dunzo',
      'color': const Color(0xFF22C55E),
      'icon': Icons.inventory_2
    },
    {
      'id': 'upwork',
      'name': 'Upwork',
      'color': const Color(0xFF16A34A),
      'icon': Icons.work
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          if (_step == 1) _buildStep1(),
          if (_step == 2) _buildStep2(),
          if (_step == 3) _buildStep3(),
          const SizedBox(height: 32),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String title = "Select Platform";
    if (_step == 2) title = "Link Bank Account";
    if (_step == 3) title = "Enable Auto-Tracking";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _step > 1
            ? GestureDetector(
                onTap: () => setState(() => _step--),
                child: const Icon(Icons.arrow_back, color: AppTheme.textGrey),
              )
            : const SizedBox(width: 24),
        Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark)),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: AppTheme.textGrey),
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _apps.length,
      itemBuilder: (context, index) {
        final app = _apps[index];
        final isSelected = _selectedApp == app['id'];
        return GestureDetector(
          onTap: () => setState(() => _selectedApp = app['id']),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primary.withOpacity(0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primary
                    : AppTheme.divider.withOpacity(0.5),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: app['color'] as Color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      (app['name'] as String)[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(app['name'] as String,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.withOpacity(0.1)),
          ),
          child: Text(
            "We'll detect earnings from $_selectedApp deposited into your bank account.",
            style:
                const TextStyle(fontSize: 12, color: Colors.blue, height: 1.4),
          ),
        ),
        const SizedBox(height: 20),
        _buildBankOption('hdfc', 'HDFC Bank', '•••• 4545', Colors.blue[900]!),
        const SizedBox(height: 12),
        _buildBankOption(
            'new', 'Add New Account', 'Link another bank', Colors.grey[100]!,
            icon: Icons.account_balance),
      ],
    );
  }

  Widget _buildBankOption(String id, String name, String sub, Color color,
      {IconData? icon}) {
    final isSelected = _selectedBank == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedBank = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary
                : AppTheme.divider.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon != null
                  ? Icon(icon, color: Colors.grey[400], size: 20)
                  : Center(
                      child: Text(name.substring(0, 4),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark)),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textGrey)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        const Icon(Icons.shield, color: AppTheme.accent, size: 64),
        const SizedBox(height: 16),
        const Text('Safe & Secure Tracking',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark)),
        const SizedBox(height: 8),
        const Text(
          'Finva only reads SMS from your platform and bank credits to track your earnings.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppTheme.textGrey, height: 1.5),
        ),
        const SizedBox(height: 24),
        _buildInfoTile(Icons.message, 'SMS Permission',
            'To detect "Credit" alerts. We never read personal messages.'),
        const SizedBox(height: 12),
        _buildInfoTile(Icons.lock, 'Bank-Grade Security',
            'Your data is encrypted and never shared with third parties.'),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.textLight, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark)),
                const SizedBox(height: 4),
                Text(sub,
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.textGrey, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _selectedApp == null
            ? null
            : () {
                if (_step < 3) {
                  setState(() => _step++);
                } else {
                  widget.onAdd(_selectedApp!);
                  Navigator.pop(context);
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(_step == 3 ? "Confirm & Connect" : "Continue",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
