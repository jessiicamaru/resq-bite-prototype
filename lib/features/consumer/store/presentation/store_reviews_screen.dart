import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class StoreReviewsScreen extends StatefulWidget {
  final MysteryBag bag;
  const StoreReviewsScreen({super.key, required this.bag});

  @override
  State<StoreReviewsScreen> createState() => _StoreReviewsScreenState();
}

class _StoreReviewsScreenState extends State<StoreReviewsScreen> {
  int _selectedFilter = 0; // 0: Tất cả (128), 1: Có hình ảnh (32)

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
          'Khách nói gì về Mây?',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overview Rating Card (C23)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '4,8',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF183B2E),
                                    ),
                                  ),
                                  Text(
                                    ' / 5',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 14,
                                      color: const Color(0xFF718076),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(Icons.star_rounded, size: 14, color: Color(0xFFED944B)),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '128 đánh giá từ đơn đã nhận',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 10,
                                  color: const Color(0xFF718076),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              children: [
                                _buildBar('5★', 0.88),
                                _buildBar('4★', 0.10),
                                _buildBar('3★', 0.02),
                                _buildBar('2★', 0.00),
                                _buildBar('1★', 0.00),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Filter chips: [Tất cả (128)] [Có hình ảnh (32)] (C23)
                    Row(
                      children: [
                        _buildFilterChip(0, 'Tất cả (128)'),
                        const SizedBox(width: 10),
                        _buildFilterChip(1, 'Có hình ảnh (32)'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Review 1: Minh Anh (C23)
                    _buildReviewItem(
                      initials: 'MA',
                      name: 'Minh Anh',
                      time: 'Đã nhận hàng · 20/10',
                      comment: 'Bánh còn thơm, nhân viên chuẩn bị sẵn nên mình nhận rất nhanh.',
                      imageAsset: 'assets/images/hero_c01.png',
                    ),

                    const Divider(height: 24, color: Color(0xFFE4E9E1)),

                    // Review 2: Quốc Bảo (C23)
                    _buildReviewItem(
                      initials: 'QB',
                      name: 'Quốc Bảo',
                      time: 'Đã nhận hàng · 19/10',
                      comment: 'Một lựa chọn tiết kiệm cho buổi tối. Sẽ quay lại!',
                    ),

                    const Divider(height: 24, color: Color(0xFFE4E9E1)),

                    // Review 3: Ngọc Linh
                    _buildReviewItem(
                      initials: 'NL',
                      name: 'Ngọc Linh',
                      time: 'Đã nhận hàng · 17/10',
                      comment: 'Chất lượng bánh rất ổn, đóng gói cẩn thận bằng túi giấy.',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12543B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFFE4E9E1),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF183B2E),
          ),
        ),
      ),
    );
  }

  Widget _buildBar(String star, double ratio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            star,
            style: GoogleFonts.beVietnamPro(fontSize: 10, color: const Color(0xFF718076)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 5,
                backgroundColor: const Color(0xFFE4E9E1),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF63834D)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String initials,
    required String name,
    required String time,
    required String comment,
    String? imageAsset,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFFDE0C8),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF8F4C17),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 10,
                      color: const Color(0xFF718076),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(
                5,
                (i) => const Icon(Icons.star_rounded, size: 14, color: Color(0xFFED944B)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          comment,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            color: const Color(0xFF183B2E),
            height: 1.4,
          ),
        ),
        if (imageAsset != null) ...[
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageAsset,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, 0, Icons.home_outlined, 'Khám phá', true, () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
          }),
          _navItem(context, 1, Icons.map_outlined, 'Bản đồ', false, () {
            Navigator.pushNamed(context, '/map-explorer');
          }),
          _navItem(context, 2, Icons.shopping_bag_outlined, 'Đơn hàng', false, () {
            Navigator.pushNamed(context, '/orders-history');
          }),
          _navItem(context, 3, Icons.person, 'Tài khoản', false, () {
            Navigator.pushNamed(context, '/consumer-profile');
          }),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ],
      ),
    );
  }
}
