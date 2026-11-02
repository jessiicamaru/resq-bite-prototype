import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class MysteryBagDetailScreen extends StatefulWidget {
  final MysteryBag bag;
  const MysteryBagDetailScreen({super.key, required this.bag});

  @override
  State<MysteryBagDetailScreen> createState() => _MysteryBagDetailScreenState();
}

class _MysteryBagDetailScreenState extends State<MysteryBagDetailScreen> {
  final currencyFormat = NumberFormat('#,###', 'vi_VN');
  int _quantity = 1;

  void _onOrderNow() {
    Navigator.pushNamed(
      context,
      '/order-qr',
      arguments: {
        'bag': widget.bag,
        'quantity': _quantity,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bag = widget.bag;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Collapsible Image Header
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primaryDark,
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
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.4),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 20),
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

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          bag.category.toUpperCase(),
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'CÒN ${bag.remainingBags} TÚI',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 18, color: AppColors.star),
                          const SizedBox(width: 4),
                          Text(
                            bag.rating.toString(),
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            ' (${bag.reviewCount} đánh giá)',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Store & Bag title
                  Text(
                    bag.storeName,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bag.title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${bag.storeAddress} (${bag.distanceKm} km)',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Pick-up Window (Golden Hour Card)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7).withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.warning,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.timer_outlined, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'KHUNG GIỜ ĐÓN HÀNG TRỰC TIẾP',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF92400E),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${bag.pickupWindow} · ${bag.pickupCountdown}',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF78350F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Price card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giá giải cứu',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  '${currencyFormat.format(bag.rescuePrice)}đ',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${currencyFormat.format(bag.originalPrice)}đ',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    color: AppColors.textMuted,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'TIẾT KIỆM ${bag.discountPercent}%',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Mystery Bag Mechanism Notice
                  Text(
                    'Cơ chế Túi Đồ Ăn Bí Mật là gì?',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bag.description,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Possible Items
                  Text(
                    'Món ăn có thể có trong túi:',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...bag.possibleItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.beVietnamPro(fontSize: 13, color: AppColors.textPrimary),
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 20),

                  // Allergy Note
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.warning),
                            const SizedBox(width: 6),
                            Text(
                              'LƯU Ý DỊ ỨNG & THÀNH PHẦN',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.warning,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          bag.allergyNotice.join(' · '),
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Story
                  Text(
                    'Chuyện của quán',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bag.merchantStory,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity Counter
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                    ),
                    Text(
                      '$_quantity',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: _quantity < bag.remainingBags
                          ? () => setState(() => _quantity++)
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // CTA Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _onOrderNow,
                  child: Text(
                    'Cứu túi ngay · ${currencyFormat.format(bag.rescuePrice * _quantity)}đ',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

