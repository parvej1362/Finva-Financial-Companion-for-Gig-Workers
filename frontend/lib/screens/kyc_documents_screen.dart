import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class KycDocumentsScreen extends StatefulWidget {
  const KycDocumentsScreen({super.key});

  @override
  State<KycDocumentsScreen> createState() => _KycDocumentsScreenState();
}

class _KycDocumentsScreenState extends State<KycDocumentsScreen> {
  final List<Map<String, dynamic>> _documents = [
    {
      'id': 1,
      'name': 'Aadhaar Card',
      'status': 'Verified',
      'date': 'Jan 15, 2026',
      'type': 'Identity',
    },
    {
      'id': 2,
      'name': 'PAN Card',
      'status': 'Verified',
      'date': 'Jan 15, 2026',
      'type': 'Identity',
    },
    {
      'id': 3,
      'name': 'Driving License',
      'status': 'Pending',
      'date': 'Submitted today',
      'type': 'Address',
    },
    {
      'id': 4,
      'name': 'Bank Statement',
      'status': 'Missing',
      'date': null,
      'type': 'Financial',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Verified':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Missing':
        return AppTheme.textGrey;
      default:
        return AppTheme.textGrey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Verified':
        return Icons.check_circle;
      case 'Pending':
        return Icons.access_time;
      case 'Missing':
        return Icons.error_outline;
      default:
        return Icons.error_outline;
    }
  }

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
                  'KYC Documents',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
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
                itemCount: _documents.length + 1,
                itemBuilder: (context, index) {
                  if (index == _documents.length) {
                    return Container(
                      margin: const EdgeInsets.only(top: 24, bottom: 40),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue.withOpacity(0.1)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.blue, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Why is KYC important?',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Verified accounts get higher savings limits, faster withdrawals, and eligibility for insurance claims.',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blue,
                                      height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final doc = _documents[index];
                  final status = doc['status'];
                  final isMissing = status == 'Missing';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10)
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.description_outlined,
                              color: _getStatusColor(status)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doc['name'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.textDark)),
                              const SizedBox(height: 4),
                              Text(doc['type'],
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.textGrey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        if (isMissing)
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.upload,
                                size: 14, color: Colors.white),
                            label: const Text('Upload',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.textDark,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(_getStatusIcon(status),
                                      size: 14, color: _getStatusColor(status)),
                                  const SizedBox(width: 4),
                                  Text(
                                    status,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: _getStatusColor(status)),
                                  ),
                                ],
                              ),
                              if (doc['date'] != null)
                                Text(doc['date'],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: AppTheme.textLight)),
                            ],
                          ),
                      ],
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
