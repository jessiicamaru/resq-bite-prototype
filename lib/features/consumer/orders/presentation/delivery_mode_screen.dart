import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class DeliveryModeScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;
  final String? notes;
  final bool bringOwnBag;

  const DeliveryModeScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.notes,
    this.bringOwnBag = true,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');
    final totalPrice = bag.rescuePrice * quantity;

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
          'Bạn muốn nhận thế nào?',
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
                'Bạn muốn nhận thế nào?',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Chọn trước khi thanh toán. Tùy cửa hàng và khu vực.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 18),

              // Item Preview Card with Image
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/hero_c01.png',
                        width: double.infinity,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 140,
                          color: const Color(0xFFEAF3DD),
                          child: const Icon(Icons.bakery_dining_rounded, size: 48, color: Color(0xFF12543B)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      bag.title,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${bag.storeName} · $quantity túi · ${currencyFormat.format(totalPrice)}đ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Option 1: Tự đến nhận • Miễn phí
              InkWell(
                onTap: () {
                  // BƯỚC TIẾP THEO: Kiểm tra đơn hàng (Image 7)
                  Navigator.pushNamed(
                    context,
                    '/cart-checkout',
                    arguments: {
                      'bag': bag,
                      'quantity': quantity,
                      'notes': notes,
                      'bringOwnBag': bringOwnBag,
                      'isDelivery': false,
                    },
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
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
                            'Tự đến nhận · Miễn phí',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Color(0xFF183B2E), size: 20),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nhận tại quầy ${bag.pickupWindow}',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: const Color(0xFF718076),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        bag.storeAddress,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: const Color(0xFF718076),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Option 2: Giao tận nơi • từ 18.000đ
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/cart-checkout',
                    arguments: {
                      'bag': bag,
                      'quantity': quantity,
                      'notes': notes,
                      'bringOwnBag': bringOwnBag,
                      'isDelivery': true,
                    },
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
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
                            'Giao tận nơi · từ 18.000đ',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Color(0xFF183B2E), size: 20),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Kiểm tra địa chỉ, phí và giờ giao trước khi đặt',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: const Color(0xFF718076),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Bottom note card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF2EB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Giao hàng là luồng mở rộng của thiết kế. Phí và thời gian bên dưới là dữ liệu minh họa.',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    color: const Color(0xFF5A7263),
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
