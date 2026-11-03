import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantDashboardScreen extends StatefulWidget {
  const MerchantDashboardScreen({super.key});

  @override
  State<MerchantDashboardScreen> createState() => _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return AnimatedBuilder(
      animation: MerchantStore.instance,
      builder: (context, _) {
        final store = MerchantStore.instance;
        final sellingBags = store.bags.where((b) => b.isSelling).toList();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topbar matching Figma M07: CỬA HÀNG CỦA BẠN & Tiệm Bánh Mây⌄ & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CỬA HÀNG CỦA BẠN',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF718076),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                'Tiệm Bánh Mây',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF183B2E), size: 18),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Role switch pill
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFE4E9E1)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.swap_horiz, color: Color(0xFF12543B), size: 15),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Người mua',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF12543B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Store status pill matching Figma: ● CỬA HÀNG ĐANG MỞ BÁN
                          InkWell(
                            onTap: () {
                              store.toggleStoreOpen();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(store.isOpen ? 'Cửa hàng đang mở bán!' : 'Cửa hàng đã tạm dừng mở bán!'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: store.isOpen ? const Color(0xFFEAF3DD) : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                store.isOpen ? '● ĐANG MỞ BÁN' : '○ TẠM DỪNG',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: store.isOpen ? const Color(0xFF12543B) : const Color(0xFF718076),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Greeting & Subtitle matching Figma M07
                  Text(
                    'Chào buổi tối, Mây.',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Thứ Năm, 22/10 · Một ngày bán hàng ý nghĩa.',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: const Color(0xFF718076),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 4 Stat Cards Grid (2x2) matching Figma M07 exactly
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          value: '18 túi',
                          subtitle: '+4 túi so với hôm qua',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/merchant-revenue'),
                          child: _buildMetricCard(
                            value: '630k',
                            subtitle: 'Doanh thu hôm nay',
                            isLink: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/merchant-orders-pending'),
                          child: _buildMetricCard(
                            value: '4 đơn',
                            subtitle: 'Đang chờ nhận',
                            isLink: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/store-reviews'),
                          child: _buildMetricCard(
                            value: '4,8/5',
                            subtitle: '128 đánh giá',
                            isLink: true,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 2 Primary Action Buttons matching Figma M07: Quét QR & Tạo túi
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF12543B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/merchant-scanner'),
                            icon: const Icon(Icons.qr_code_scanner_rounded, size: 18),
                            label: Text(
                              'Quét QR',
                              style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF12543B),
                              side: const BorderSide(color: Color(0xFF12543B), width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/merchant-create-bag'),
                            icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                            label: Text(
                              'Tạo túi',
                              style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // MỤC 1: VIỆC CẦN LÀM TỐI NAY (M10)
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Việc cần làm tối nay',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-tasks'),
                        child: Text(
                          'Xem tất cả',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/merchant-tasks'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE6CF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.notifications_active_outlined, color: Color(0xFF8F4C17), size: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '4 đơn sắp đến giờ nhận',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Chuẩn bị túi trước 20:00 để bàn giao.',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 11,
                                        color: const Color(0xFF718076),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right_rounded, color: Color(0xFF718076), size: 20),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: Color(0xFFE4E9E1), height: 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.inventory_2_outlined, size: 16, color: Color(0xFF12543B)),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Túi bánh còn 4',
                                    style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF183B2E)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star_outline_rounded, size: 16, color: Color(0xFFDDA63A)),
                                  const SizedBox(width: 6),
                                  Text(
                                    '1 đánh giá mới',
                                    style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF183B2E)),
                                  ),
                                ],
                              ),
                              Text(
                                '3 việc cần làm >',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF12543B)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // MỤC 2: HOẠT ĐỘNG GẦN ĐÂY (M11)
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hoạt động gần đây',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-activities'),
                        child: Text(
                          'Xem tất cả',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/merchant-activities'),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Color(0xFF12543B), size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'RB-1024 đã thanh toán',
                                  style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                                ),
                              ),
                              Text(
                                '20:12 · 1 túi bánh',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: Color(0xFFE4E9E1), height: 1),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFDDA63A), size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Minh Anh đánh giá 5 sao',
                                  style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                                ),
                              ),
                              Text(
                                '19:48 · Nhận hàng nhanh',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // MỤC 3: KẾT THÚC NGÀY BÁN & ĐÓNG CA (M12)
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kết thúc ngày bán',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-closing-shift'),
                        child: Text(
                          'Vào đóng ca',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/merchant-closing-shift'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF12543B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.assignment_turned_in_outlined, color: Colors.white, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kiểm tra trước khi đóng ca',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: (store.checklistHandedOver && store.checklistInventoryUpdated && store.checklistSanitized)
                                            ? const Color(0xFFEAF3DD)
                                            : const Color(0xFFFEF4E8),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${(store.checklistHandedOver ? 1 : 0) + (store.checklistInventoryUpdated ? 1 : 0) + (store.checklistSanitized ? 1 : 0)}/3 mục',
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: (store.checklistHandedOver && store.checklistInventoryUpdated && store.checklistSanitized)
                                              ? const Color(0xFF12543B)
                                              : const Color(0xFF8F4C17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Đã trao: 18 túi · Chờ nhận: 0 đơn · Doanh thu 630k',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right_rounded, color: Color(0xFF718076), size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // TÚI ĐANG MỞ BÁN (DYNAMIC FROM MerchantStore)
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Túi đang mở bán',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-bags'),
                        child: Text(
                          'Xem tất cả',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...sellingBags.take(3).map((bag) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-bags'),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE4E9E1)),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  bag.image,
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 54,
                                    height: 54,
                                    color: const Color(0xFFEAF3DD),
                                    child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tiệm Bánh Mây',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    Text(
                                      bag.title,
                                      style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${currencyFormat.format(bag.rescuePrice)}đ',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF183B2E),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF3DD),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${bag.remainingQuantity} túi',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF12543B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // ==========================================
                  // NHỊP BÁN HÔM NAY (Báo cáo lãng phí thực phẩm)
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nhịp bán hôm nay',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/merchant-food-waste'),
                        child: Text(
                          'Xem tất cả',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE4E9E1)),
                    ),
                    child: Column(
                      children: [
                        // Days bars: T2, T3, T4, T5 (active), T6, T7, CN
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildDayBar('T2', 0.45, false),
                            _buildDayBar('T3', 0.60, false),
                            _buildDayBar('T4', 0.50, false),
                            _buildDayBar('T5', 0.90, true),
                            _buildDayBar('T6', 0.70, false),
                            _buildDayBar('T7', 0.85, false),
                            _buildDayBar('CN', 0.40, false),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Divider(color: Color(0xFFE4E9E1), height: 1),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Khung giờ bán tốt nhất',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: const Color(0xFF718076),
                              ),
                            ),
                            Text(
                              '19:00–20:00',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String subtitle,
    bool isLink = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E9E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              if (isLink)
                const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF12543B)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.beVietnamPro(
              fontSize: 11,
              color: const Color(0xFF718076),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar(String day, double heightFraction, bool isActive) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 60 * heightFraction,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF12543B) : const Color(0xFFE4E9E1),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: GoogleFonts.beVietnamPro(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFF12543B) : const Color(0xFF718076),
          ),
        ),
      ],
    );
  }
}
