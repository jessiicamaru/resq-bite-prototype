import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantDashboardScreen extends StatefulWidget {
  const MerchantDashboardScreen({super.key});

  @override
  State<MerchantDashboardScreen> createState() => _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
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
                          setState(() => _isOpen = !_isOpen);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isOpen ? 'Cửa hàng đang mở bán!' : 'Cửa hàng đã tạm dừng mở bán!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _isOpen ? const Color(0xFFEAF3DD) : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _isOpen ? '● ĐANG MỞ BÁN' : '○ TẠM DỪNG',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: _isOpen ? const Color(0xFF12543B) : const Color(0xFF718076),
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
                      onTap: () => Navigator.pushNamed(context, '/merchant-revenue-report'),
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

              // Section 1: Cần xử lý tối nay | Xem tất cả
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cần xử lý tối nay',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/merchant-orders-pending'),
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
                onTap: () => Navigator.pushNamed(context, '/merchant-orders-pending'),
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
                          color: const Color(0xFFFFE6CF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications_active_outlined, color: Color(0xFF8F4C17), size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4 khách sắp đến nhận',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Chuẩn bị túi trước 20:00 để bàn giao nhanh.',
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
                ),
              ),

              const SizedBox(height: 24),

              // Section 2: Nhịp bán hôm nay | Xem tất cả
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
                    onTap: () => Navigator.pushNamed(context, '/merchant-food-waste-report'),
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

              // Section 3: Túi đang mở bán | Xem tất cả
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
                    onTap: () => Navigator.pushNamed(context, '/merchant-bag-list'),
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
              ...[
                {
                  'store': 'Tiệm Bánh Mây',
                  'bag': 'Túi bánh cuối ngày',
                  'price': '35.000đ',
                  'bags': '4 túi',
                  'image': 'assets/images/hero_c01.png',
                },
                {
                  'store': 'Bếp Nhà',
                  'bag': 'Bữa cơm nhà ấm bụng',
                  'price': '39.000đ',
                  'bags': '3 túi',
                  'image': 'assets/images/hero_c02.png',
                },
              ].map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                            item['image']!,
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['store']!,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              Text(
                                item['bag']!,
                                style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item['price']!,
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
                                item['bags']!,
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
                );
              }),

              const SizedBox(height: 24),

              // Section 4: Hoạt động mới | Xem tất cả
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hoạt động mới',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  Text(
                    'Xem tất cả',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12543B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
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

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String subtitle,
    bool isLink = false,
  }) {
    return Container(
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
            value,
            style: GoogleFonts.beVietnamPro(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF183B2E),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 10,
                    color: const Color(0xFF718076),
                  ),
                ),
              ),
              if (isLink)
                const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Color(0xFF718076)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar(String day, double fraction, bool isActive) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 60 * fraction,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF12543B) : const Color(0xFFD0DCC6),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: GoogleFonts.beVietnamPro(
            fontSize: 9,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? const Color(0xFF12543B) : const Color(0xFF718076),
          ),
        ),
      ],
    );
  }
}
