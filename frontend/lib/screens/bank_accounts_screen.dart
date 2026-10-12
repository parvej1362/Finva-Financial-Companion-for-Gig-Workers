import 'package:flutter/material.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> _banks = [
    {
      'name': 'State Bank of India',
      'logo': 'SBI',
      'color': const Color(0xFF280071),
      'linked': true,
      'isPopular': true
    },
    {
      'name': 'HDFC Bank',
      'logo': 'HDFC',
      'color': const Color(0xFF004C8F),
      'linked': false,
      'isPopular': true
    },
    {
      'name': 'ICICI Bank',
      'logo': 'ICICI',
      'color': const Color(0xFFF37E20),
      'linked': false,
      'isPopular': true
    },
    {
      'name': 'Axis Bank',
      'logo': 'AXIS',
      'color': const Color(0xFF97144D),
      'linked': false,
      'isPopular': true
    },
    {
      'name': 'Kotak Mahindra',
      'logo': 'KOTAK',
      'color': const Color(0xFFED1C24),
      'linked': false,
      'isPopular': true
    },
    {
      'name': 'Bank of Baroda',
      'logo': 'BOB',
      'color': const Color(0xFFF26522),
      'linked': false,
      'isPopular': false
    },
    {
      'name': 'Canara Bank',
      'logo': 'CAN',
      'color': const Color(0xFF0090DA),
      'linked': false,
      'isPopular': false
    },
    {
      'name': 'Federal Bank',
      'logo': 'FED',
      'color': const Color(0xFFE31E24),
      'linked': false,
      'isPopular': false
    },
    {
      'name': 'IDFC First Bank',
      'logo': 'IDFC',
      'color': const Color(0xFF9D1D27),
      'linked': false,
      'isPopular': false
    },
    {
      'name': 'IndusInd Bank',
      'logo': 'IND',
      'color': const Color(0xFF8E2522),
      'linked': false,
      'isPopular': false
    },
    {
      'name': 'Punjab National Bank',
      'logo': 'PNB',
      'color': const Color(0xFFA20A3E),
      'linked': false,
      'isPopular': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filtered = _banks
        .where((b) => b['name'].toString().toLowerCase().contains(query))
        .toList();
    final popularBanks = filtered.where((b) => b['isPopular']).toList();
    final otherBanks = filtered.where((b) => !b['isPopular']).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('LINKED ACCOUNTS'),
                  const SizedBox(height: 12),
                  _buildLinkedAccountCard(
                    name: 'State Bank of India',
                    accountNo: '•••• 4582',
                    logo: 'SBI',
                    color: const Color(0xFF280071),
                    isPrimary: true,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('LINK NEW BANK'),
                  const SizedBox(height: 12),
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  if (popularBanks.isNotEmpty) ...[
                    _buildListTitle('Popular Banks'),
                    _buildBankList(popularBanks),
                    const SizedBox(height: 24),
                  ],
                  if (otherBanks.isNotEmpty) ...[
                    _buildListTitle('Other Banks'),
                    _buildBankList(otherBanks),
                  ],
                  _buildSecurityFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A0B2E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  shape: BoxShape.circle),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Bank Accounts',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text(
                    'Manage your linked accounts for instant payouts and savings.',
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFFC7D2FE), height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF64748B),
            letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildListTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFF1F5F9).withOpacity(0.5),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.8),
      ),
    );
  }

  Widget _buildLinkedAccountCard({
    required String name,
    required String accountNo,
    required String logo,
    required Color color,
    bool isPrimary = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF0F172A).withOpacity(0.2)
                : Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(logo,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 11)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isPrimary ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  accountNo,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPrimary
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                ),
                if (isPrimary) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF10B981).withOpacity(0.2)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_user,
                            color: Color(0xFF10B981), size: 10),
                        SizedBox(width: 4),
                        Text('PRIMARY ACCOUNT',
                            style: TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 9,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isPrimary
                      ? Colors.white.withOpacity(0.1)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.refresh,
                    color: isPrimary ? Colors.white : const Color(0xFF0F4C5C),
                    size: 18),
              ),
              const SizedBox(height: 4),
              Text(
                'Balance',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isPrimary
                      ? const Color(0xFF64748B)
                      : const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A)),
        decoration: const InputDecoration(
          hintText: 'Search bank name (SBI, HDFC, ICICI...)',
          hintStyle: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
              fontWeight: FontWeight.w500),
          prefixIcon:
              Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildBankList(List<Map<String, dynamic>> banks) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: banks.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, indent: 64, color: Color(0xFFF1F5F9)),
        itemBuilder: (context, index) {
          final bank = banks[index];
          return ListTile(
            onTap: bank['linked'] ? null : () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(color: bank['color'], shape: BoxShape.circle),
              child: Center(
                child: Text(bank['logo'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 10)),
              ),
            ),
            title: Text(bank['name'],
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A))),
            trailing: bank['linked']
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('Linked',
                        style: TextStyle(
                            color: Color(0xFF059669),
                            fontSize: 10,
                            fontWeight: FontWeight.w800)),
                  )
                : const Icon(Icons.chevron_right,
                    color: Color(0xFFCBD5E1), size: 20),
          );
        },
      ),
    );
  }

  Widget _buildSecurityFooter() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 14, color: Color(0xFF10B981)),
          SizedBox(width: 8),
          Text(
            '100% Secure & Encrypted Banking',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}
