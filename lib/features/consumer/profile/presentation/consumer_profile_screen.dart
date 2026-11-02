import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class ConsumerProfileScreen extends StatelessWidget {
  const ConsumerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hồ Sơ Cá Nhân'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: AppColors.primary, size: 34),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thanh Hậu',
                          style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        Text(
                          'hau@example.com · Hải Châu, Đà Nẵng',
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '12 bữa ăn đã cứu · Hạng Bạc',
                            style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Green Impact Banner Shortcut
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/green-impact'),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF183B2E), Color(0xFF12543B)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.eco_rounded, color: Colors.white, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dấu chân xanh của bạn',
                            style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          Text(
                            'Đã tiết kiệm 780.000đ & giảm 28.5 kg CO₂',
                            style: GoogleFonts.beVietnamPro(fontSize: 11, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'HOẠT ĐỘNG TIÊU DÙNG',
              style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.8),
            ),
            const SizedBox(height: 8),

            _buildMenuItem(
              icon: Icons.receipt_long_rounded,
              title: 'Lịch sử đơn hàng',
              subtitle: '1 đơn đang chờ lấy · 1 đơn hoàn tất',
              onTap: () => Navigator.pushNamed(context, '/orders-history'),
            ),
            _buildMenuItem(
              icon: Icons.map_rounded,
              title: 'Bản đồ khu vực giải cứu',
              subtitle: 'Bán kính 1km – 5km quanh Hải Châu',
              onTap: () => Navigator.pushNamed(context, '/map-explorer'),
            ),
            _buildMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Phương thức thanh toán đã lưu',
              subtitle: 'Ví MoMo, ZaloPay, Thẻ Napas',
              onTap: () => Navigator.pushNamed(context, '/payment-methods'),
            ),

            const SizedBox(height: 20),

            Text(
              'THÔNG TIN & ĐIỀU KHOẢN',
              style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.8),
            ),
            const SizedBox(height: 8),

            _buildMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'Về dự án ResQ Bites & SDGs',
              subtitle: 'Mục tiêu SDG 2 (Zero Hunger) & SDG 12',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'ResQ Bites',
                  applicationVersion: '2.0 (Prototype)',
                  children: [
                    const Text('Nền tảng kết nối và điều phối thực phẩm dư thừa cuối ngày hướng tới tiêu dùng bền vững.'),
                  ],
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.logout_rounded,
              title: 'Đăng xuất tài khoản',
              subtitle: 'Quay lại màn hình đăng nhập',
              color: AppColors.danger,
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color ?? AppColors.primary, size: 22),
        title: Text(
          title,
          style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: color ?? AppColors.textPrimary),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
      ),
    );
  }
}

