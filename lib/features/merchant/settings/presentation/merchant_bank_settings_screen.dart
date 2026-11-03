import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantBankSettingsScreen extends StatefulWidget {
  const MerchantBankSettingsScreen({super.key});

  @override
  State<MerchantBankSettingsScreen> createState() => _MerchantBankSettingsScreenState();
}

class _MerchantBankSettingsScreenState extends State<MerchantBankSettingsScreen> {
  String _bankName = 'Vietcombank';
  String _accountHolder = 'NGUYEN MAI ANH';
  String _accountNumber = '•••• •••• 6789';

  void _showChangeAccountSheet() {
    final bankCtrl = TextEditingController(text: _bankName);
    final holderCtrl = TextEditingController(text: _accountHolder);
    final numCtrl = TextEditingController(text: '0041000678912');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thay đổi tài khoản nhận tiền',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF183B2E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Ngân hàng', style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: bankCtrl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            Text('Số tài khoản', style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: numCtrl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            Text('Chủ tài khoản (Viết hoa)', style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: holderCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12543B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    _bankName = bankCtrl.text;
                    _accountHolder = holderCtrl.text;
                    _accountNumber = '•••• •••• ${numCtrl.text.length >= 4 ? numCtrl.text.substring(numCtrl.text.length - 4) : "6789"}';
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã cập nhật thông tin tài khoản thành công!')),
                  );
                },
                child: Text(
                  'Lưu thông tin',
                  style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE4E9E1)),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            color: const Color(0xFF183B2E),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Tài khoản nhận tiền',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESQ PARTNER',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF63834D),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Tài khoản nhận tiền',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Thông tin dùng cho kỳ đối soát.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 18),

              // Bank Card Visual (Figma M40)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF183B2E), Color(0xFF0F2B21)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF183B2E).withValues(alpha: 0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _bankName,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3DD),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Đã xác minh',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF12543B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      _accountNumber,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _accountHolder,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu Rows Details Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(Icons.account_balance_outlined, 'Ngân hàng', _bankName),
                    const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                    _buildDetailRow(Icons.person_outline_rounded, 'Chủ tài khoản', _accountHolder),
                    const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                    _buildDetailRow(Icons.credit_card_outlined, 'Số tài khoản', _accountNumber),
                    const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                    _buildDetailRow(Icons.verified_outlined, 'Trạng thái', 'Đã xác minh', isGreen: true),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Full CTA Button: Thay đổi tài khoản
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12543B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: _showChangeAccountSheet,
                  child: Text(
                    'Thay đổi tài khoản',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF183B2E)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF183B2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    fontWeight: isGreen ? FontWeight.w700 : FontWeight.w400,
                    color: isGreen ? const Color(0xFF12543B) : const Color(0xFF718076),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: Color(0xFF718076)),
        ],
      ),
    );
  }
}
