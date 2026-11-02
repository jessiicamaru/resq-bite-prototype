import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;
  final String payment;

  const PaymentSuccessScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.payment = 'Ví MoMo',
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');
    final savedAmount = (bag.originalPrice - bag.rescuePrice) * quantity;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Celebration Circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 54),
              ),

              const SizedBox(height: 24),

              Text(
                'Túi ngon đã dành cho bạn!',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),

              const SizedBox(height: 8),

              Text(
                'Thanh toán thành công qua $payment.\nCửa hàng đã sẵn sàng đóng gói túi bí mật cho bạn.',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(fontSize: 13, color: AppColors.textSecondary, height: 1.45),
              ),

              const SizedBox(height: 28),

              // Instant Green Impact Stat Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TÁC ĐỘNG TÍCH CỰC NGAY LẬP TỨC',
                            style: GoogleFonts.beVietnamPro(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.8),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tiết kiệm: ${currencyFormat.format(savedAmount)}đ · Giảm 2.4 kg CO₂',
                            style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Order details summary box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildRow('Mã đơn hàng', 'RESQ-8942-DN'),
                    const SizedBox(height: 8),
                    _buildRow('Cửa hàng', bag.storeName),
                    const SizedBox(height: 8),
                    _buildRow('Khung giờ lấy đồ', bag.pickupWindow),
                  ],
                ),
              ),

              const Spacer(),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/order-qr',
                    arguments: {
                      'bag': bag,
                      'quantity': quantity,
                    },
                  );
                },
                icon: const Icon(Icons.qr_code_rounded),
                label: const Text('Mở Vé Lấy Hàng (QR Code)'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
                child: Text(
                  'Về trang chủ',
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary)),
        Text(value, style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }
}

