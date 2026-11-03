import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';

class HomeDiscoverScreen extends StatefulWidget {
  const HomeDiscoverScreen({super.key});

  @override
  State<HomeDiscoverScreen> createState() => _HomeDiscoverScreenState();
}

class _HomeDiscoverScreenState extends State<HomeDiscoverScreen> {
  final currencyFormat = NumberFormat('#,###', 'vi_VN');

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Bánh',
      'icon': Icons.bakery_dining_rounded,
      'color': Color(0xFFFFF7ED),
      'borderColor': Color(0xFFFED7AA),
      'iconColor': Color(0xFFC2410C),
    },
    {
      'name': 'Cơm',
      'icon': Icons.rice_bowl_rounded,
      'color': Color(0xFFFEFCE8),
      'borderColor': Color(0xFFFEF08A),
      'iconColor': Color(0xFFA16207),
    },
    {
      'name': 'Chay',
      'icon': Icons.spa_rounded,
      'color': Color(0xFFF0FDF4),
      'borderColor': Color(0xFFBBF7D0),
      'iconColor': Color(0xFF15803D),
    },
    {
      'name': 'Đồ uống',
      'icon': Icons.local_cafe_rounded,
      'color': Color(0xFFF0FDFA),
      'borderColor': Color(0xFF99F6E4),
      'iconColor': Color(0xFF0F766E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Topbar: KHÁM PHÁ QUANH & Location & Role Switch
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF12543B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'KHÁM PHÁ QUANH',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF718076),
                              letterSpacing: 0.8,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Hải Châu, Đà Nẵng',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF183B2E)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/merchant-home'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.storefront, color: Color(0xFF92400E), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Chủ quán',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF92400E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pushNamed(context, '/notifications'),
                        icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF183B2E), size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Eyeline & Page Title & Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      'CHÀO HẬU, BUỔI TỐI VUI VẺ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF12543B),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Hôm nay, cứu món gì?',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Search Bar matching Figma C09
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Icon(Icons.search_rounded, color: Color(0xFF718076)),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm món ngon, cửa hàng…',
                                hintStyle: GoogleFonts.beVietnamPro(
                                  color: const Color(0xFF718076),
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/category-detail'),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF12543B)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Hero Banner matching Figma C09: MỘT TÚI · NHIỀU ĐIỀU TỐT
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12543B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'MỘT TÚI · NHIỀU ĐIỀU TỐT',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFDCF59A),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Ngon hôm nay.\nXanh ngày mai.',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bữa ngon cuối ngày, giá chỉ từ 25.000đ.',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/category-detail'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Giải cứu ngay',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF12543B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4 Circular Categories matching Figma C09
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _categories.map((cat) {
                    return GestureDetector(
                      onTap: () {
                        if (cat['name'] == 'Bánh') {
                          Navigator.pushNamed(context, '/category-detail');
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: cat['color'] as Color,
                              shape: BoxShape.circle,
                              border: Border.all(color: cat['borderColor'] as Color, width: 1.5),
                            ),
                            child: Icon(
                              cat['icon'] as IconData,
                              color: cat['iconColor'] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat['name'] as String,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Section 1: Sắp hết giờ nhận | Xem tất cả
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sắp hết giờ nhận',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/category-detail'),
                      child: Text(
                        'Xem tất cả',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF12543B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Horizontal food cards matching Figma C09
            SliverToBoxAdapter(
              child: SizedBox(
                height: 310,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final items = [
                      {
                        'store': 'Tiệm Bánh Mây',
                        'bag': 'Túi bánh cuối ngày',
                        'meta': 'Bánh · 0,8 km',
                        'badge': 'Còn 4 túi',
                        'badgeColor': const Color(0xFFDCF59A),
                        'badgeTextColor': const Color(0xFF12543B),
                        'rating': '★ 4,8',
                        'price': '35.000đ',
                        'oldPrice': '100.000đ',
                        'time': '20:00–21:30',
                        'image': 'assets/images/hero_c01.png',
                      },
                      {
                        'store': 'Bếp Nhà',
                        'bag': 'Bữa cơm nhà ấm bụng',
                        'meta': 'Cơm · 1,2 km',
                        'badge': 'Chỉ còn 3 túi',
                        'badgeColor': const Color(0xFFFFE6CF),
                        'badgeTextColor': const Color(0xFF8F4C17),
                        'rating': '★ 4,9',
                        'price': '39.000đ',
                        'oldPrice': '95.000đ',
                        'time': '19:30–20:30',
                        'image': 'assets/images/hero_c02.png',
                      },
                      {
                        'store': 'Fresh Corner',
                        'bag': 'Một ngụm tươi mới',
                        'meta': 'Đồ uống · 0,6 km',
                        'badge': 'Còn 5 túi',
                        'badgeColor': const Color(0xFFDCF59A),
                        'badgeTextColor': const Color(0xFF12543B),
                        'rating': '★ 4,8',
                        'price': '25.000đ',
                        'oldPrice': '65.000đ',
                        'time': '20:00–21:00',
                        'image': 'assets/images/hero_c04.png',
                      },
                    ];
                    final item = items[index];

                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/bag-detail'),
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE4E9E1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image & badge & heart
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    item['image']! as String,
                                    height: 135,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: item['badgeColor'] as Color,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item['badge'] as String,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: item['badgeTextColor'] as Color,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.favorite_border_rounded, size: 16, color: Color(0xFF718076)),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['meta'] as String,
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 11,
                                          color: const Color(0xFF718076),
                                        ),
                                      ),
                                      Text(
                                        item['rating'] as String,
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF183B2E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['store'] as String,
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF183B2E),
                                    ),
                                  ),
                                  Text(
                                    item['bag'] as String,
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      color: const Color(0xFF718076),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['price'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF183B2E),
                                            ),
                                          ),
                                          Text(
                                            item['oldPrice'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 11,
                                              color: const Color(0xFF718076),
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF718076)),
                                          const SizedBox(width: 4),
                                          Text(
                                            item['time'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF718076),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Section 2: Quanh bạn tối nay | Bản đồ
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quanh bạn tối nay',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/map'),
                      child: Text(
                        'Bản đồ',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF12543B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Vertical food items matching Figma C09
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final items = [
                    {
                      'store': 'Green Bowl',
                      'bag': 'Túi xanh đủ chất',
                      'meta': 'Chay · 1,6 km',
                      'badge': 'Chỉ còn 2 túi',
                      'badgeColor': const Color(0xFFFFE6CF),
                      'badgeTextColor': const Color(0xFF8F4C17),
                      'rating': '★ 4,7',
                      'price': '32.000đ',
                      'oldPrice': '80.000đ',
                      'time': '20:00–22:00',
                      'image': 'assets/images/hero_c03.png',
                    },
                    {
                      'store': 'Fresh Corner',
                      'bag': 'Một ngụm tươi mới',
                      'meta': 'Đồ uống · 0,6 km',
                      'badge': 'Còn 5 túi',
                      'badgeColor': const Color(0xFFDCF59A),
                      'badgeTextColor': const Color(0xFF12543B),
                      'rating': '★ 4,8',
                      'price': '25.000đ',
                      'oldPrice': '65.000đ',
                      'time': '20:00–21:00',
                      'image': 'assets/images/hero_c04.png',
                    },
                  ];
                  final item = items[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/bag-detail'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE4E9E1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    item['image']! as String,
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: item['badgeColor'] as Color,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item['badge'] as String,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: item['badgeTextColor'] as Color,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.favorite_border_rounded, size: 16, color: Color(0xFF718076)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['meta'] as String,
                                        style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                                      ),
                                      Text(
                                        item['rating'] as String,
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF183B2E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['store'] as String,
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF183B2E),
                                    ),
                                  ),
                                  Text(
                                    item['bag'] as String,
                                    style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['price'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF183B2E),
                                            ),
                                          ),
                                          Text(
                                            item['oldPrice'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 11,
                                              color: const Color(0xFF718076),
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF718076)),
                                          const SizedBox(width: 4),
                                          Text(
                                            item['time'] as String,
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF718076),
                                            ),
                                          ),
                                        ],
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
                  );
                },
                childCount: 2,
              ),
            ),

            // Impact Banner matching Figma C09: 12 túi. Một thói quen xanh.
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/green-impact'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EFDA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CẢM ƠN BẠN ĐÃ CÙNG GIẢI CỨU',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '12 túi. Một thói quen xanh.',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Bạn đã tiết kiệm 780.000đ và cho thực phẩm thêm một cơ hội.',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: const Color(0xFF718076),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              'Xem hành trình của bạn →',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF12543B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Community Stories section: Những người làm nên bữa ngon
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Những người làm nên bữa ngon',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/store-detail'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE4E9E1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                'assets/images/story_may.png',
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 160,
                                  color: const Color(0xFFEAF3DD),
                                  child: const Icon(Icons.storefront_rounded, size: 48, color: Color(0xFF12543B)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Text(
                                'Một góc nhỏ ở Mây, một câu chuyện lớn',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
