import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class StoreDetailScreen extends StatelessWidget {
  final MysteryBag bag;
  const StoreDetailScreen({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Cover
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.4),
                child: IconButton(
                  icon: const Icon(Icons.favorite_rounded, color: AppColors.danger, size: 20),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                bag.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Store Information
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_rounded, color: AppColors.primary, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'ĐỐI TÁC XÁC THỰC',
                              style: GoogleFonts.beVietnamPro(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/store-reviews', arguments: bag),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.star, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${bag.rating} (${bag.reviewCount})',
                              style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textMuted),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    bag.storeName,
                    style: GoogleFonts.beVietnamPro(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          bag.storeAddress,
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 16, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Text(
                        'Mở cửa: 07:00 – 22:00 · Khung giờ giải cứu: ${bag.pickupWindow}',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Hygiene Commitment Card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shield_outlined, color: AppColors.primary, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cam kết Vệ sinh An toàn Thực phẩm',
                                style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                              ),
                              Text(
                                'Đồ ăn cuối ngày được chế biến và bảo quản chuẩn quy trình, đảm bảo tươi ngon.',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Mystery Bags List from this store
                  Text(
                    'Túi bí mật đang mở bán hôm nay',
                    style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/bag-detail', arguments: bag),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              bag.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.badgeBg,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '-${bag.discountPercent}%',
                                        style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Còn ${bag.remainingBags} túi',
                                      style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  bag.title,
                                  style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      '${currencyFormat.format(bag.rescuePrice)}đ',
                                      style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${currencyFormat.format(bag.originalPrice)}đ',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 12,
                                        color: AppColors.textMuted,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

