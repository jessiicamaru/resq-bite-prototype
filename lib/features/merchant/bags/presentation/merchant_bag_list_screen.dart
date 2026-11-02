import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/food_bag.dart';

class MerchantBagListScreen extends StatefulWidget {
  const MerchantBagListScreen({super.key});

  @override
  State<MerchantBagListScreen> createState() => _MerchantBagListScreenState();
}

class _MerchantBagListScreenState extends State<MerchantBagListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _bags = [
    {
      'bag': mockMysteryBags[0], // Túi Bánh Cuối Ngày
      'isActive': true,
      'remaining': 4,
      'sold': 18,
    },
    {
      'bag': MysteryBag(
        id: 'bag_pastry_mini',
        title: 'Túi Bánh Ngọt Mini & Trà',
        storeName: 'Tiệm Bánh Mây',
        storeAddress: '142 Nguyễn Thị Minh Khai, Hải Châu, Đà Nẵng',
        category: 'Bánh',
        distanceKm: 0.8,
        rating: 4.8,
        reviewCount: 38,
        rescuePrice: 25000,
        originalPrice: 65000,
        pickupWindow: '20:30 – 21:30',
        pickupCountdown: 'Còn 1 giờ',
        remainingBags: 2,
        imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=700&auto=format&fit=crop&q=80',
        description: 'Túi bánh su kem, tart trứng hoặc brownie socola thơm nức.',
        possibleItems: ['Tart trứng nướng', 'Bánh su kem vani'],
        allergyNotice: ['Chứa sữa', 'Chứa trứng'],
        merchantStory: 'Tiệm Bánh Mây cùng chung tay bảo vệ môi trường.',
      ),
      'isActive': true,
      'remaining': 2,
      'sold': 10,
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
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Túi đang mở bán',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.forestGreen),
            onPressed: () {
              Navigator.pushNamed(context, '/merchant-create-bag');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.forestGreen,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: AppColors.forestGreen,
          labelStyle: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, fontSize: 14),
          tabs: const [
            Tab(text: 'Đang bán (2)'),
            Tab(text: 'Bản nháp (1)'),
            Tab(text: 'Tạm dừng (0)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveList(),
          _buildDraftList(),
          _buildPausedList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/merchant-create-bag');
        },
        backgroundColor: AppColors.forestGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Tạo một túi mới',
          style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildActiveList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _bags.length,
      itemBuilder: (context, index) {
        final item = _bags[index];
        final MysteryBag bag = item['bag'] as MysteryBag;
        final bool isActive = item['isActive'] as bool;
        final int remaining = item['remaining'] as int;
        final int sold = item['sold'] as int;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
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
                            Expanded(
                              child: Text(
                                bag.title,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.charcoal,
                                ),
                              ),
                            ),
                            Switch.adaptive(
                              value: isActive,
                              activeTrackColor: AppColors.forestGreen,
                              onChanged: (val) {
                                setState(() {
                                  item['isActive'] = val;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(val ? 'Đã kích hoạt ${bag.title}' : 'Đã tạm dừng ${bag.title}'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${bag.rescuePrice}đ',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.forestGreen,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${bag.originalPrice}đ',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.sdgGold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '-65%',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.forestGreenDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.forestGreen),
                            const SizedBox(width: 4),
                            Text(
                              'Nhận hàng: ${bag.pickupWindow}',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Còn $remaining túi',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF16A34A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Đã bán: $sold túi',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/merchant-pickup-window', arguments: bag);
                        },
                        icon: const Icon(Icons.tune, size: 16, color: AppColors.forestGreen),
                        label: Text(
                          'Chỉnh sửa',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forestGreen,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined, size: 18, color: Colors.grey),
                        tooltip: 'Xem trước trang người mua',
                        onPressed: () {
                          Navigator.pushNamed(context, '/bag-detail', arguments: bag);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraftList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_note_outlined, size: 54, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              '1 Túi bản nháp chưa công bố',
              style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.charcoal),
            ),
            const SizedBox(height: 6),
            Text(
              'Túi Bánh Mì Artisan & Mứt Trái Cây (Đã lưu lúc 14:20)',
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/merchant-create-bag');
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.forestGreen),
              child: const Text('Tiếp tục chỉnh sửa'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPausedList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pause_circle_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'Không có túi nào đang tạm dừng',
            style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
