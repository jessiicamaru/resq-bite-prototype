import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantVerificationScreen extends StatelessWidget {
  const MerchantVerificationScreen({super.key});

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
          'Hồ sơ đang được xem xét',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hồ sơ đang được xem xét',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Chúng mình sẽ thông báo khi có kết quả.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 24),

              // Checklist matching Figma M04
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  children: [
                    _buildCheckRow('Thông tin cửa hàng', 'Đã nhận', true),
                    const Divider(color: Color(0xFFE4E9E1), height: 20),
                    _buildCheckRow('Giấy tờ kinh doanh', 'Đang kiểm tra', false),
                    const Divider(color: Color(0xFFE4E9E1), height: 20),
                    _buildCheckRow('Thông báo kết quả', 'Qua email đã đăng ký', false),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Status progress boxes matching Figma M04
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3DD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF12543B), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Đã tiếp nhận',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26, top: 2),
                      child: Text(
                        'Thông tin đã được ghi nhận',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, color: const Color(0xFF718076)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.pending_rounded, color: Color(0xFFDDA63A), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Đang xử lý',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26, top: 2),
                      child: Text(
                        'Kết quả sẽ được hiển thị khi hoàn tất',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, color: const Color(0xFF718076)),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

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
                  onPressed: () => Navigator.pushReplacementNamed(context, '/merchant-home'),
                  child: Text(
                    'Đến trang quản lý',
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

  Widget _buildCheckRow(String title, String status, bool isDone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF183B2E),
          ),
        ),
        Row(
          children: [
            Text(
              status,
              style: GoogleFonts.beVietnamPro(
                fontSize: 11,
                fontWeight: isDone ? FontWeight.w700 : FontWeight.w500,
                color: isDone ? const Color(0xFF12543B) : const Color(0xFF718076),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              isDone ? Icons.check_circle_rounded : Icons.access_time_rounded,
              size: 15,
              color: isDone ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ],
        ),
      ],
    );
  }
}
