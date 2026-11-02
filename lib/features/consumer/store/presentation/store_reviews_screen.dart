import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class StoreReviewsScreen extends StatelessWidget {
  final MysteryBag bag;
  const StoreReviewsScreen({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    final mockReviews = [
      {
        'user': 'Minh Anh',
        'time': 'Hôm qua, 21:15',
        'rating': 5,
        'comment': 'Túi bí mật siêu hời luôn ạ! Nhận được 2 bánh croissant bơ thơm phức và 1 bánh mì gối nướng trong ngày. Quán bọc giấy rất bảo vệ môi trường.',
        'bag': 'Túi Bánh Cuối Ngày',
      },
      {
        'user': 'Hoàng Long',
        'time': '3 ngày trước',
        'rating': 5,
        'comment': 'Quét mã QR lấy trong 10 giây nhanh gọn. Bánh còn giòn ngon. Cực kỳ ủng hộ mô hình giảm rác thải thực phẩm như này!',
        'bag': 'Túi Bánh Cuối Ngày',
      },
      {
        'user': 'Bích Trâm',
        'time': '1 tuần trước',
        'rating': 4,
        'comment': 'Bánh ngon, giá rẻ hơn 60% so với mua ban ngày. Nhân viên nhiệt tình hướng dẫn nhận đồ.',
        'bag': 'Túi Bánh Cuối Ngày',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Đánh Giá ${bag.storeName}'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Rating Overview Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${bag.rating}',
                        style: GoogleFonts.beVietnamPro(fontSize: 38, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => const Icon(Icons.star_rounded, size: 16, color: AppColors.star),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${bag.reviewCount} đánh giá',
                        style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        _buildRatingBar('5★', 0.85),
                        _buildRatingBar('4★', 0.12),
                        _buildRatingBar('3★', 0.03),
                        _buildRatingBar('2★', 0.00),
                        _buildRatingBar('1★', 0.00),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Nhận xét từ người cứu đồ ăn',
              style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),

            const SizedBox(height: 12),

            ...mockReviews.map((r) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            (r['user'] as String)[0],
                            style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: AppColors.primary),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['user'] as String,
                                style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                              ),
                              Text(
                                r['time'] as String,
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(
                            r['rating'] as int,
                            (i) => const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      r['comment'] as String,
                      style: GoogleFonts.beVietnamPro(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Đã cứu: ${r['bag']}',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(String label, double ratio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: GoogleFonts.beVietnamPro(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 5,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

