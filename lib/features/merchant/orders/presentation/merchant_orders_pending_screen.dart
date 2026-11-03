import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantOrdersPendingScreen extends StatefulWidget {
  final int initialTab;
  const MerchantOrdersPendingScreen({super.key, this.initialTab = 0});

  @override
  State<MerchantOrdersPendingScreen> createState() => _MerchantOrdersPendingScreenState();
}

class _MerchantOrdersPendingScreenState extends State<MerchantOrdersPendingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#RB-1024',
      'customer': 'Thanh Hậu',
      'info': '1 túi · Nhận 20:00–21:30',
      'price': '35.000đ',
      'status': 'Chờ nhận',
    },
    {
      'id': '#RB-1025',
      'customer': 'Minh Anh',
      'info': '2 túi · Nhận 20:00–21:30',
      'price': '70.000đ',
      'status': 'Chờ nhận',
    },
    {
      'id': '#RB-1026',
      'customer': 'Quốc Bảo',
      'info': '1 túi · Nhận 20:00–21:30',
      'price': '35.000đ',
      'status': 'Chờ nhận',
    },
    {
      'id': '#RB-1027',
      'customer': 'Thu Hà',
      'info': '2 túi · Nhận 20:00–21:30',
      'price': '70.000đ',
      'status': 'Chờ nhận',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/merchant-home');
              }
            },
          ),
        ),
        title: Text(
          'Đơn chờ nhận',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Text(
                  'Đơn giao tận nơi',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF12543B),
                  ),
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RESQ PARTNER',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF12543B),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Đơn chờ nhận',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '4 khách sẽ đến trong khung 20:00–21:30.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3 Tabs: Chờ nhận | Đã nhận | Đã hủy
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: const Color(0xFF12543B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF718076),
                        labelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(text: 'Chờ nhận'),
                          Tab(text: 'Đã nhận'),
                          Tab(text: 'Đã hủy'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Search box: Tìm theo mã đơn…
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(Icons.search_rounded, color: Color(0xFF718076), size: 18),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm theo mã đơn…',
                                hintStyle: GoogleFonts.beVietnamPro(
                                  color: const Color(0xFF718076),
                                  fontSize: 12,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Orders list matching Figma M23
                    ..._orders.map((order) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
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
                                  order['id'] as String,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE6CF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    order['status'] as String,
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF8F4C17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              order['customer'] as String,
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              order['info'] as String,
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                color: const Color(0xFF718076),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: Color(0xFFE4E9E1), height: 1),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order['price'] as String,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, '/merchant-qr-valid'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF3DD),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Chi tiết',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF12543B),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA matching Figma M23: Quét mã nhận hàng
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE4E9E1)),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 49,
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
                    'Quét mã nhận hàng',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
