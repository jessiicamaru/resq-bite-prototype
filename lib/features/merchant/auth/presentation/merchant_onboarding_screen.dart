import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantOnboardingScreen extends StatelessWidget {
  const MerchantOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/merchant-home');
            },
            child: Text(
              'Vào Dashboard thử',
              style: GoogleFonts.beVietnamPro(
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.forestGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'DÀNH CHO ĐỐI TÁC F&B',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forestGreen,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Cùng cứu những bữa ngon',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forestGreen,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Biến thực phẩm cuối ngày thành cơ hội mới và lan tỏa tiêu dùng có trách nhiệm.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // Feature cards
              _buildFeatureItem(
                icon: Icons.savings_outlined,
                title: 'Tối ưu chi phí thất thoát',
                desc: 'Bán các gói thực phẩm chuẩn an toàn vào cuối ngày thay vì hủy bỏ lãng phí.',
              ),
              const SizedBox(height: 14),
              _buildFeatureItem(
                icon: Icons.inventory_2_outlined,
                title: 'Mô hình Túi bí mật (Mystery Bag)',
                desc: 'Không cần đăng lẻ từng món, đóng gói ngẫu nhiên theo danh mục mà không làm giảm giá trị thương hiệu.',
              ),
              const SizedBox(height: 14),
              _buildFeatureItem(
                icon: Icons.qr_code_scanner_outlined,
                title: 'Nhận hàng tại quầy nhanh gọn',
                desc: 'Khách đến tự nhận theo khung giờ quy định, quét mã QR bàn giao chỉ trong 5 giây.',
              ),
              const SizedBox(height: 14),
              _buildFeatureItem(
                icon: Icons.eco_outlined,
                title: 'Đồng hành cùng SDG 12 & SDG 2',
                desc: 'Nhận chứng nhận Gian hàng Xanh và báo cáo giảm khí thải CO₂ định kỳ.',
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/merchant-register');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  backgroundColor: AppColors.forestGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: Text(
                  'Đăng ký đối tác ngay',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/merchant-home');
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: AppColors.forestGreen, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Đã là đối tác? Vào cửa hàng Mây',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forestGreen,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.forestGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.forestGreen, size: 22),
          ),
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
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

