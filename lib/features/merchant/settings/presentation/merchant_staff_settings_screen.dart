import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantStaffSettingsScreen extends StatelessWidget {
  const MerchantStaffSettingsScreen({super.key});

  void _showHelpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trợ giúp phân quyền nhân sự',
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
            _buildRoleExplanation(
              'Chủ cửa hàng (Toàn quyền)',
              'Quản lý túi, xem đối soát doanh thu, thiết lập tài khoản ngân hàng và nhân sự.',
            ),
            const SizedBox(height: 14),
            _buildRoleExplanation(
              'Quản lý (Túi & đơn hàng)',
              'Tạo túi mới, điều chỉnh số lượng tồn, quản lý khung giờ nhận và theo dõi đơn hàng.',
            ),
            const SizedBox(height: 14),
            _buildRoleExplanation(
              'Nhân viên (Quét QR)',
              'Chỉ có quyền mở camera quét mã QR và xác nhận trao túi cho khách hàng tại quầy.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _buildRoleExplanation(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          desc,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            color: const Color(0xFF718076),
            height: 1.35,
          ),
        ),
      ],
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
          'Nhân sự cửa hàng',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
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
                'Nhân sự cửa hàng',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Phân quyền theo công việc của từng người.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 20),

              // Staff List Card (Figma M44)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  children: [
                    _buildStaffRow('Mai Anh', 'Chủ cửa hàng • Toàn quyền'),
                    const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                    _buildStaffRow('Minh', 'Nhân viên • Quét QR'),
                    const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                    _buildStaffRow('Linh', 'Quản lý • Túi & đơn hàng'),
                  ],
                ),
              ),

              const Spacer(),

              // Full CTA Button: Xem trợ giúp phân quyền
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
                  onPressed: () => _showHelpModal(context),
                  child: Text(
                    'Xem trợ giúp phân quyền',
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

  Widget _buildStaffRow(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFEAF3DD),
            child: Text(
              name.substring(0, 1),
              style: GoogleFonts.beVietnamPro(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF12543B),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF183B2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    color: const Color(0xFF718076),
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
