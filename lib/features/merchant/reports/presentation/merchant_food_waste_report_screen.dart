import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantFoodWasteReportScreen extends StatelessWidget {
  const MerchantFoodWasteReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dailyBars = [
      {'day': 'T2', 'height': 0.6},
      {'day': 'T3', 'height': 0.72},
      {'day': 'T4', 'height': 0.55},
      {'day': 'T5', 'height': 0.8},
      {'day': 'T6', 'height': 0.88},
      {'day': 'T7', 'height': 1.0},
      {'day': 'CN', 'height': 0.48},
    ];

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
          'Tác động từ cửa hàng',
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
                'Tác động từ cửa hàng',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Mỗi túi được trao là một cơ hội giảm lãng phí.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 18),

              // Green Card: THÁNG 10 CỦA MÂY
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF12543B),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF12543B).withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THÁNG 10 CỦA MÂY',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '540',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'túi',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'đã tìm được người thưởng thức',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Stat Grid (2 Columns)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trong tuần',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '126',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'túi được cứu',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF60834E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cửa hàng đồng hành',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '4,8★',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'đánh giá trung bình',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF60834E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Section Title: Đều đặn tạo nên thay đổi
              Text(
                'Đều đặn tạo nên thay đổi',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 10),

              // Chart Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: dailyBars.map((d) {
                          final double h = (d['height'] as double) * 80;
                          final isPeak = d['day'] == 'T7';
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 28,
                                height: h,
                                decoration: BoxDecoration(
                                  color: isPeak ? const Color(0xFF12543B) : const Color(0xFFA4C777),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                d['day'] as String,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF718076),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Số túi mỗi ngày · Dữ liệu minh họa',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Notice green pill
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3DD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF12543B)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Chưa quy đổi túi thành kg thực phẩm hoặc CO₂ khi chưa có dữ liệu đo và hệ số kiểm chứng.',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 11,
                          color: const Color(0xFF12543B),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Image Card
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/story_may.png',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: const Color(0xFFEAF3DD),
                    alignment: Alignment.center,
                    child: const Icon(Icons.eco_rounded, size: 48, color: Color(0xFF12543B)),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Heading slogan
              Text(
                'Tốt cho bạn.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              Text(
                'Tốt cho hành tinh.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Giảm thực phẩm bị bỏ đi bắt đầu từ những lựa chọn nhỏ trong ngày.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // CTA Button: Xem đánh giá cửa hàng
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
                  onPressed: () => Navigator.pushNamed(context, '/store-reviews'),
                  child: Text(
                    'Xem đánh giá cửa hàng',
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
}
