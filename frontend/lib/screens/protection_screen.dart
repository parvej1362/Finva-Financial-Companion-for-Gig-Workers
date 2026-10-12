import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/insurance_detail_sheet.dart';

class ProtectionScreen extends StatefulWidget {
  const ProtectionScreen({super.key});

  @override
  State<ProtectionScreen> createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> {
  double _workHours = 8;
  double _incomeVolatility = 0.4;
  bool _isAnalyzing = false;
  bool _showSuccess = false;

  @override
  Widget build(BuildContext context) {
    final plans = _getDynamicPlans();
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Row(children: [
                        GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: const Icon(Icons.arrow_back,
                                color: AppTheme.textDark)),
                        const SizedBox(width: 12),
                        const Row(children: [
                          Icon(Icons.shield_outlined,
                              color: AppTheme.primary, size: 18),
                          SizedBox(width: 6),
                          Text('SMART PROTECTION',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                  letterSpacing: 1)),
                        ]),
                      ]),
                    ),
                    if (_showSuccess)
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            color: AppTheme.greenLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppTheme.primary.withOpacity(0.2))),
                        child: const Row(children: [
                          Icon(Icons.check_circle,
                              color: AppTheme.primary, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                              child: Text(
                                  'Recommendations updated based on your profile!',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark))),
                        ]),
                      ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
                      child: Text('Safeguard your\nFuture',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark,
                              height: 1.2)),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                          'Personalized coverage based on your real-time work patterns.',
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.textGrey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8)
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(children: [
                                Icon(Icons.trending_up,
                                    color: AppTheme.textGrey, size: 18),
                                SizedBox(width: 8),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Your Work Profile',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.textDark)),
                                      Text('Adjust to see impact on premiums',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textGrey)),
                                    ]),
                              ]),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Daily Work Hours',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textDark)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.divider),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text('${_workHours.round()}h',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ]),
                              const SizedBox(height: 8),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: AppTheme.primary,
                                    inactiveTrackColor: AppTheme.divider,
                                    thumbColor: AppTheme.primary,
                                    overlayColor:
                                        AppTheme.primary.withOpacity(0.1),
                                    trackHeight: 4),
                                child: Slider(
                                    value: _workHours,
                                    min: 2,
                                    max: 14,
                                    divisions: 12,
                                    onChanged: (v) =>
                                        setState(() => _workHours = v)),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Part-time',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: AppTheme.textGrey)),
                                      Text('Full-time',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: AppTheme.textGrey)),
                                      Text('Overtime',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: AppTheme.textGrey)),
                                    ]),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Income Volatility',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textDark)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _incomeVolatility > 0.6
                                                  ? AppTheme.red
                                                  : AppTheme.accent),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                          _incomeVolatility > 0.6
                                              ? 'High'
                                              : _incomeVolatility > 0.3
                                                  ? 'Medium'
                                                  : 'Stable',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: _incomeVolatility > 0.6
                                                  ? AppTheme.red
                                                  : AppTheme.accent)),
                                    ),
                                  ]),
                              const SizedBox(height: 8),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: _incomeVolatility > 0.6
                                        ? AppTheme.red
                                        : AppTheme.accent,
                                    inactiveTrackColor: AppTheme.divider,
                                    thumbColor: _incomeVolatility > 0.6
                                        ? AppTheme.red
                                        : AppTheme.accent,
                                    trackHeight: 4),
                                child: Slider(
                                    value: _incomeVolatility,
                                    min: 0,
                                    max: 1,
                                    onChanged: (v) =>
                                        setState(() => _incomeVolatility = v)),
                              ),
                              const Text(
                                  'Higher volatility suggests a stronger need for Income Protection plans.',
                                  style: TextStyle(
                                      fontSize: 11, color: AppTheme.textGrey)),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _runAnalysis,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  child: const Text('Refresh Recommendations',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Recommended Plans',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textDark)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppTheme.greenLight,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('${plans.length} plans found',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: plans
                            .asMap()
                            .entries
                            .map((e) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          e.key < plans.length - 1 ? 14 : 0),
                                  child: _insuranceCard(context, e.value),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ]),
            ),
            if (_isAnalyzing)
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: AppTheme.primary),
                        SizedBox(height: 20),
                        Text('Analyzing Risk Profile...',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textDark)),
                        SizedBox(height: 8),
                        Text('Tailoring coverage for your patterns',
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.textGrey)),
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

  void _runAnalysis() async {
    setState(() {
      _isAnalyzing = true;
      _showSuccess = false;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isAnalyzing = false;
        _showSuccess = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showSuccess = false);
      });
    }
  }

  List<Map<String, dynamic>> _getDynamicPlans() {
    final bool isHighRisk = _workHours > 10;
    final bool isHighVolatility = _incomeVolatility > 0.6;

    return insurancePlans.map((plan) {
      final p = Map<String, dynamic>.from(plan);
      if (p['title'] == 'Health Insurance') {
        p['coverage'] = isHighRisk ? '₹7,00,000' : '₹5,00,000';
        p['premium'] = isHighRisk ? '₹550/mo' : '₹450/mo';
        p['badge'] = isHighRisk ? 'High Load Alert' : 'Suggested';
        p['badgeColor'] = isHighRisk ? AppTheme.red : AppTheme.accent;
      } else if (p['title'] == 'Accident Cover') {
        p['coverage'] = isHighRisk ? '₹15,00,000' : '₹10,00,000';
        p['premium'] = isHighRisk ? '₹200/mo' : '₹150/mo';
        if (isHighRisk) {
          p['badge'] = 'Essential';
          p['badgeColor'] = AppTheme.orange;
        }
      } else if (p['title'] == 'Income Protection') {
        p['coverage'] = isHighVolatility ? '₹20,000/week' : '₹15,000/week';
        p['premium'] = isHighVolatility ? '₹450/mo' : '₹300/mo';
        if (isHighVolatility) {
          p['badge'] = 'Critical';
          p['badgeColor'] = AppTheme.red;
        }
      } else if (p['title'] == 'Term Life Insurance') {
        p['premium'] = isHighRisk ? '₹650/mo' : '₹499/mo';
      }
      return p;
    }).toList();
  }

  Widget _insuranceCard(BuildContext context, Map<String, dynamic> plan) {
    final badge = plan['badge'] as String?;
    final badgeColor = plan['badgeColor'] as Color;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
          ]),
      child: Column(children: [
        if (badge != null)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(10))),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.check_circle_outline, color: badgeColor, size: 12),
                const SizedBox(width: 4),
                Text(badge,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: badgeColor)),
              ]),
            ),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, badge != null ? 8 : 16, 16, 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: plan['iconBg'] as Color, shape: BoxShape.circle),
                child: Icon(plan['icon'] as IconData,
                    color: plan['iconColor'] as Color, size: 24)),
            const SizedBox(height: 12),
            Text(plan['title'] as String,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textDark)),
            const SizedBox(height: 4),
            Text(plan['subtitle'] as String,
                style: const TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('COVERAGE',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textGrey,
                            letterSpacing: 0.8)),
                    const SizedBox(height: 4),
                    Text(plan['coverage'] as String,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark)),
                  ])),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('EST. PREMIUM',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textGrey,
                            letterSpacing: 0.8)),
                    const SizedBox(height: 4),
                    Text(plan['premium'] as String,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark)),
                  ])),
            ]),
            const SizedBox(height: 12),
            ...(plan['features'] as List<String>).map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(children: [
                    const Icon(Icons.check_circle,
                        color: AppTheme.accent, size: 16),
                    const SizedBox(width: 8),
                    Text(f,
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textDark)),
                  ]),
                )),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => showInsuranceDetail(context, plan),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.divider),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Learn More',
                          style: TextStyle(
                              color: AppTheme.textDark,
                              fontWeight: FontWeight.w600)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios,
                          color: AppTheme.textGrey, size: 12),
                    ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
