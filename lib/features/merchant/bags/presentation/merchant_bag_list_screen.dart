import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantBagListScreen extends StatefulWidget {
  const MerchantBagListScreen({super.key});

  @override
  State<MerchantBagListScreen> createState() => _MerchantBagListScreenState();
}

class _MerchantBagListScreenState extends State<MerchantBagListScreen> {
  int _selectedTab = 0; // 0: Đang bán, 1: Bản nháp, 2: Tạm dừng

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return AnimatedBuilder(
      animation: MerchantStore.instance,
      builder: (context, _) {
        final store = MerchantStore.instance;

        // Filter bags by tab
        final sellingBags = store.bags.where((b) => b.isSelling && !b.isDraft).toList();
        final draftBags = store.bags.where((b) => b.isDraft).toList();
        final pausedBags = store.bags.where((b) => !b.isSelling && !b.isDraft).toList();

        final currentList = _selectedTab == 0
            ? sellingBags
            : (_selectedTab == 1 ? draftBags : pausedBags);

        final totalRemaining = sellingBags.fold<int>(0, (sum, b) => sum + b.remainingQuantity);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: canPop
                ? Container(
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
                  )
                : null,
            title: Text(
              'Túi đang mở bán',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF183B2E),
              ),
            ),
            centerTitle: false,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.notifications_none_rounded, size: 20, color: Color(0xFF183B2E)),
                  onPressed: () {},
                ),
              ),
            ],
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
                      color: const Color(0xFF63834D),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
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
                    '${sellingBags.length} loại túi • $totalRemaining túi còn sẵn sàng',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: const Color(0xFF718076),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filter Tabs: Đang bán | Bản nháp | Tạm dừng (Figma M13)
                  Container(
                    height: 41,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF0E3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _buildTabItem('Đang bán', 0),
                        _buildTabItem('Bản nháp', 1),
                        _buildTabItem('Tạm dừng', 2),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (currentList.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            _selectedTab == 0
                                ? 'Không có túi nào đang mở bán'
                                : (_selectedTab == 1 ? 'Chưa có bản nháp nào' : 'Không có túi nào tạm dừng'),
                            style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
                          ),
                        ],
                      ),
                    ),

                  // Bags list matching Figma M13
                  ...List.generate(currentList.length, (index) {
                    final bag = currentList[index];

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
                                  bag.image,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 60,
                                    height: 60,
                                    color: const Color(0xFFEAF3DD),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B), size: 24),
                                  ),
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
                                            bag.title,
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
                                            color: bag.isSelling ? const Color(0xFFEAF3DD) : const Color(0xFFF3EFEA),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            bag.isSelling ? 'Đang bán' : 'Tạm dừng',
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: bag.isSelling ? const Color(0xFF12543B) : const Color(0xFF8F4C17),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${currencyFormat.format(bag.rescuePrice)}đ · Giá gốc ${currencyFormat.format(bag.originalPrice)}đ',
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

                          // Linear stock bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (bag.remainingQuantity / 10).clamp(0.0, 1.0),
                              backgroundColor: const Color(0xFFE4E9E1),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF63834D)),
                              minHeight: 4,
                            ),
                          ),
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
                                    '${bag.remainingQuantity} túi',
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
                                      _showEditQuantityDialog(context, bag);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFFE4E9E1)),
                                      ),
                                      child: Text(
                                        'Sửa số lượng',
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF12543B),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      store.toggleBagSelling(bag.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            bag.isSelling
                                                ? 'Đã mở bán lại: ${bag.title}'
                                                : 'Đã tạm dừng: ${bag.title}',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFFE4E9E1)),
                                      ),
                                      child: Text(
                                        bag.isSelling ? 'Tạm dừng' : 'Mở bán',
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: bag.isSelling ? const Color(0xFF8F4C17) : const Color(0xFF12543B),
                                        ),
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
      },
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditQuantityDialog(BuildContext context, MerchantBag bag) {
    int current = bag.remainingQuantity;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(
            'Sửa số lượng túi tồn kho',
            style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                bag.title,
                style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF12543B), size: 30),
                    onPressed: () {
                      if (current > 0) {
                        setDialogState(() => current--);
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '$current',
                    style: GoogleFonts.beVietnamPro(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Color(0xFF12543B), size: 30),
                    onPressed: () {
                      setDialogState(() => current++);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Hủy', style: GoogleFonts.beVietnamPro(color: const Color(0xFF718076))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12543B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                MerchantStore.instance.updateBagQuantity(bag.id, current);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã cập nhật số lượng tồn kho thành công ($current túi)!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text('Lưu', style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
