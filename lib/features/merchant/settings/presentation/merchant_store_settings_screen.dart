import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantStoreSettingsScreen extends StatelessWidget {
  const MerchantStoreSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Hồ sơ & Vận hành',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.forestGreen,
                    child: Text(
                      'Mây',
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tiệm Bánh Mây',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppColors.charcoal,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.verified, color: AppColors.forestGreen, size: 18),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '142 Nguyễn Thị Minh Khai, Hải Châu, ĐN',
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Đối tác đã xác minh ATVSTP',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF16A34A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings Group 1: Vận hành
            Text(
              'Cài đặt vận hành quán',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context,
                    icon: Icons.storefront_outlined,
                    title: 'Hồ sơ cửa hàng & Ảnh bìa',
                    subtitle: 'Tên, mô tả và hotline quản lý',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildSettingTile(
                    context,
                    icon: Icons.schedule_outlined,
                    title: 'Giờ hoạt động quán (M38)',
                    subtitle: '07:00 – 22:00 hàng ngày',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildSettingTile(
                    context,
                    icon: Icons.place_outlined,
                    title: 'Điểm nhận tại cửa hàng (M39)',
                    subtitle: 'Quầy thu ngân chính tầng 1',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Group 2: Tài chính & Thanh toán
            Text(
              'Tài chính & Thanh toán',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context,
                    icon: Icons.account_balance_outlined,
                    title: 'Tài khoản nhận tiền (M40)',
                    subtitle: 'Vietcombank •••• 6789 (NGUYEN MAI ANH)',
                    onTap: () {
                      Navigator.pushNamed(context, '/merchant-bank-settings');
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildSettingTile(
                    context,
                    icon: Icons.receipt_long_outlined,
                    title: 'Báo cáo doanh thu & Đối soát',
                    subtitle: 'Xem chu kỳ quyết toán hàng tuần',
                    onTap: () {
                      Navigator.pushNamed(context, '/merchant-revenue');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Group 3: Nhân sự & Hỗ trợ
            Text(
              'Nhân sự & Hỗ trợ',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context,
                    icon: Icons.group_outlined,
                    title: 'Nhân sự cửa hàng (M44)',
                    subtitle: '3 nhân viên có quyền quét mã QR',
                    onTap: () {
                      Navigator.pushNamed(context, '/merchant-staff');
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildSettingTile(
                    context,
                    icon: Icons.headset_mic_outlined,
                    title: 'Hỗ trợ đối tác 24/7 (M45)',
                    subtitle: 'Hotline riêng cho Merchant: 1900 8943',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Switch back to Consumer
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.swap_horiz, color: AppColors.forestGreen),
              label: Text(
                'Chuyển về Chế độ Người Dùng (Consumer Mode)',
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.w700,
                  color: AppColors.forestGreen,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                side: const BorderSide(color: AppColors.forestGreen, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.forestGreen.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.forestGreen, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.charcoal),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
    );
  }
}
