import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantClosingShiftScreen extends StatelessWidget {
  const MerchantClosingShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: MerchantStore.instance,
      builder: (context, _) {
        final store = MerchantStore.instance;

        // Calculate dynamic unsold bags and pending orders from store
        final unsoldBags = store.bags.fold<int>(0, (sum, b) => sum + (b.isSelling ? b.remainingQuantity : 0));
        final pendingOrdersCount = store.orders.where((o) => o.status == 'Chờ nhận').length;

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
              'Kết thúc ngày bán',
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    'Kết thúc ngày bán',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kiểm tra các đơn còn chờ trước khi đóng ca.',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      color: const Color(0xFF718076),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 2 Top Stats Cards
                  Row(
                    children: [
                      // Card 1: Đã trao - 18 túi
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF12543B),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đã trao',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '18 túi',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Card 2: Chờ nhận
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/merchant-orders-pending'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE4E9E1)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chờ nhận',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$pendingOrdersCount đơn',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Checklist Box: Kiểm tra trước khi đóng ca
                  Container(
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
                          'Kiểm tra trước khi đóng ca',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Checkbox 1
                        _buildCheckItem(
                          title: 'Đã bàn giao toàn bộ đơn thanh toán',
                          value: store.checklistHandedOver,
                          onChanged: () => store.toggleChecklistHandedOver(),
                        ),
                        const SizedBox(height: 10),

                        // Checkbox 2
                        _buildCheckItem(
                          title: 'Đã cập nhật thực phẩm chưa bán',
                          value: store.checklistInventoryUpdated,
                          onChanged: () => store.toggleChecklistInventoryUpdated(),
                        ),
                        const SizedBox(height: 10),

                        // Checkbox 3
                        _buildCheckItem(
                          title: 'Đã vệ sinh và bảo quản đúng hướng dẫn',
                          value: store.checklistSanitized,
                          onChanged: () => store.toggleChecklistSanitized(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Summary Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE4E9E1)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Doanh thu hôm nay',
                              style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                            ),
                            Text(
                              '630.000đ',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Túi chưa bán',
                              style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                            ),
                            Text(
                              '$unsoldBags túi',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Warning Banner matching Figma M12
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF4E8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF7DEBE)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Color(0xFF8F4C17), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Không tự động chuyển túi thực phẩm còn lại sang ngày mới. Cần kiểm tra chất lượng và hạn sử dụng.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              height: 1.4,
                              color: const Color(0xFF8F4C17),
                            ),
                          ),
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

  Widget _buildCheckItem({
    required String title,
    required bool value,
    required VoidCallback onChanged,
  }) {
    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value ? const Color(0xFF12543B) : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: value ? const Color(0xFF12543B) : const Color(0xFF718076),
                  width: 1.5,
                ),
              ),
              child: value
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF183B2E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

