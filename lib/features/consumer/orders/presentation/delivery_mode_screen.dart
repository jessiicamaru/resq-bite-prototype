import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class DeliveryModeScreen extends StatefulWidget {
  final MysteryBag bag;

  const DeliveryModeScreen({super.key, required this.bag});

  @override
  State<DeliveryModeScreen> createState() => _DeliveryModeScreenState();
}

class _DeliveryModeScreenState extends State<DeliveryModeScreen> {
  int _selectedMode = 0; // 0: Tự đến lấy, 1: Giao tận nơi

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
          'Bạn muốn nhận thế nào?',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.forestGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.forestGreen.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.eco, color: AppColors.forestGreen, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'ResQ Bites khuyến khích bạn tự đến nhận để giảm phát thải bao bì và khí thải CO₂ từ xe giao hàng.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: AppColors.forestGreen,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Mode 1: Tự đến lấy
            InkWell(
              onTap: () {
                setState(() {
                  _selectedMode = 0;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _selectedMode == 0 ? AppColors.forestGreen : Colors.grey.shade200,
                    width: _selectedMode == 0 ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedMode == 0 ? AppColors.forestGreen : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.storefront_outlined,
                        color: _selectedMode == 0 ? Colors.white : Colors.grey.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tự đến nhận (Khuyên dùng)',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.charcoal,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.forestGreen.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Miễn phí',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.forestGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Khung giờ nhận: ${widget.bag.pickupWindow}\nXuất trình mã QR tại quầy để lấy trong 10 giây.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mode 2: Giao tận nơi (v2)
            InkWell(
              onTap: () {
                setState(() {
                  _selectedMode = 1;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _selectedMode == 1 ? AppColors.forestGreen : Colors.grey.shade200,
                    width: _selectedMode == 1 ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedMode == 1 ? AppColors.forestGreen : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delivery_dining_outlined,
                        color: _selectedMode == 1 ? Colors.white : Colors.grey.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Giao tận nơi (Green Eco)',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.charcoal,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '+15.000đ',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.sdgGold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Giao bằng xe máy điện trong bán kính 3km.\nThời gian nhận dự kiến: 20:30 – 21:00.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/cart-checkout',
                  arguments: {
                    'bag': widget.bag,
                    'quantity': 1,
                    'isDelivery': _selectedMode == 1,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: AppColors.forestGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Tiếp tục đặt túi',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

