import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantVerificationScreen extends StatelessWidget {
  const MerchantVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.sdgGold.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.hourglass_top_rounded,
                  color: AppColors.sdgGold,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Hồ sơ đang được xem xét',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forestGreen,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chúng mình đang xác thực chứng nhận ATVSTP của Tiệm Bánh Mây. Kết quả sẽ được gửi qua email trong vòng 24 giờ.',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // Checklist
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildStepRow(
                      icon: Icons.check_circle,
                      iconColor: AppColors.forestGreen,
                      title: 'Thông tin cửa hàng',
                      subtitle: 'Đã nhận hồ sơ Tiệm Bánh Mây',
                      isDone: true,
                    ),
                    const Divider(height: 28),
                    _buildStepRow(
                      icon: Icons.sync,
                      iconColor: AppColors.sdgGold,
                      title: 'Giấy tờ kinh doanh & ATTP',
                      subtitle: 'Đang kiểm tra tính hợp lệ',
                      isDone: false,
                    ),
                    const Divider(height: 28),
                    _buildStepRow(
                      icon: Icons.radio_button_unchecked,
                      iconColor: Colors.grey.shade400,
                      title: 'Kích hoạt mở bán túi',
                      subtitle: 'Sẵn sàng bán túi cứu trợ',
                      isDone: false,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Quick action for prototype
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.forestGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.forestGreen, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Chế độ Prototype: Bạn có thể vào thẳng Dashboard vận hành của Tiệm Bánh Mây bên dưới.',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: AppColors.forestGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/merchant-home');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  backgroundColor: AppColors.forestGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Vào Dashboard quản lý gian hàng',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Về ứng dụng người mua',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
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

  Widget _buildStepRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDone,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

