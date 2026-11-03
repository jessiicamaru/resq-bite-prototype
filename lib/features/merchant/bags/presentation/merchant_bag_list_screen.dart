import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantBagListScreen extends StatefulWidget {
  const MerchantBagListScreen({super.key});

  @override
  State<MerchantBagListScreen> createState() => _MerchantBagListScreenState();
}

class _MerchantBagListScreenState extends State<MerchantBagListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _bags = [
    {
      'title': 'Túi bánh cuối ngày',
      'price': '35.000đ · Giá gốc 100.000đ',
      'remaining': 4,
      'isSelling': true,
      'image': 'assets/screens/hero_c01.png',
    },
    {
      'title': 'Bữa cơm nhà ấm bụng',
      'price': '39.000đ · Giá gốc 95.000đ',
      'remaining': 3,
      'isSelling': true,
      'image': 'assets/screens/hero_c02.png',
    },
    {
      'title': 'Túi xanh đủ chất',
      'price': '32.000đ · Giá gốc 80.000đ',
      'remaining': 2,
      'isSelling': true,
      'image': 'assets/screens/hero_c03.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          'Túi đang mở bán',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
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
                'Túi đang mở bán',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '2 loại túi • 6 túi còn sẵn sàng',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Tabs: Đang bán | Bản nháp | Tạm dừng
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
                    Tab(text: 'Đang bán'),
                    Tab(text: 'Bản nháp'),
                    Tab(text: 'Tạm dừng'),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Bags list matching Figma M13
              ...List.generate(_bags.length, (index) {
                final bag = _bags[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              bag['image'] as String,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        bag['title'] as String,
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF183B2E),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAF3DD),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Đang bán',
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF12543B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  bag['price'] as String,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(color: Color(0xFFE4E9E1), height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tồn kho hôm nay: ',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                              ),
                              Text(
                                '${bag['remaining']} túi',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Chỉnh sửa số lượng túi: ${bag['title']}')),
                                  );
                                },
                                child: Text(
                                  'Sửa số lượng',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF12543B),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bag['isSelling'] = !bag['isSelling'];
                                  });
                                },
                                child: Text(
                                  'Tạm dừng',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF8F4C17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 10),

              // Button: ＋ Tạo túi mới
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
                  onPressed: () => Navigator.pushNamed(context, '/merchant-create-bag'),
                  child: Text(
                    '＋ Tạo túi mới',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
