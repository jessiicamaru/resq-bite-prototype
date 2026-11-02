import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class OrderQrPickupScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;

  const OrderQrPickupScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');
    final totalAmount = bag.rescuePrice * quantity;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
        ),
        title: Text(
          'Vé Lấy Hàng Điện Tử',
          style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              // Success Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.co2Reduction, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'ĐÃ THANH TOÁN THÀNH CÔNG',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Xuất trình mã QR tại quầy',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Nhân viên sẽ quét mã xác nhận trong 5–10 giây',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 24),

              // The Digital Ticket with QR Code
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Top part: Store & Bag info
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Column(
                        children: [
                          Text(
                            bag.storeName,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${bag.title} (x$quantity)',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.alarm, color: Color(0xFF92400E), size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  'Giờ đón: ${bag.pickupWindow}',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF92400E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dashed ticket separator
                    Row(
                      children: [
                        const SizedBox(
                          height: 24,
                          width: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Flex(
                                direction: Axis.horizontal,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  (constraints.constrainWidth() / 10).floor(),
                                  (_) => const SizedBox(
                                    width: 5,
                                    height: 1.5,
                                    child: DecoratedBox(decoration: BoxDecoration(color: AppColors.border)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                          width: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // QR Code Area
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border, width: 2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              children: [
                                // QR Visual Simulator
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.qr_code_2_rounded,
                                      size: 170,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            'MÃ LẤY HÀNG: RESQ-8942-DN',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              letterSpacing: 1.2,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Đã thanh toán: ${currencyFormat.format(totalAmount)}đ',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Store Address & Actions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.storefront_rounded, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bag.storeName,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            bag.storeAddress,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.directions_rounded, color: AppColors.primaryLight),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mở chỉ đường trên Bản đồ!')),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/green-impact'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primaryDark,
                ),
                child: const Text('Xem Bảng Thành Tích Xanh (SDG Impact)'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
                child: Text(
                  'Về lại trang chủ',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
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

