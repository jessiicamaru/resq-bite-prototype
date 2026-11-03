import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/merchant_order.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantQrValidScreen extends StatelessWidget {
  final MerchantOrder? order;
  final bool isError;
  final String errorType; // 'used', 'expired'

  const MerchantQrValidScreen({
    super.key,
    this.order,
    this.isError = false,
    this.errorType = 'used',
  });

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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Mã hợp lệ',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Status Hero
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF3DD),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF12543B),
                          size: 48,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Mã hợp lệ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kiểm tra đúng túi trước khi xác nhận bàn giao.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Details Card (Figma M26)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  children: [
                    _buildRowItem(
                      icon: Icons.person_outline_rounded,
                      text: 'RB-1024 • Thanh Hậu',
                      isBold: true,
                    ),
                    const Divider(color: Color(0xFFE4E9E1), height: 24),
                    _buildRowItem(
                      icon: Icons.shopping_bag_outlined,
                      text: '1 túi bánh cuối ngày',
                    ),
                    const Divider(color: Color(0xFFE4E9E1), height: 24),
                    _buildRowItem(
                      icon: Icons.check_circle_outline_rounded,
                      text: 'Đã thanh toán 35.000đ',
                      textColor: const Color(0xFF12543B),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // CTA Button (Figma M26)
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
                  onPressed: () {
                    final targetCode = order?.orderCode ?? 'RB-1024';
                    MerchantStore.instance.completeOrder(targetCode);
                    _showSuccessDialog(context);
                  },
                  child: Text(
                    'Xác nhận đã trao túi',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowItem({
    required IconData icon,
    required String text,
    bool isBold = false,
    Color textColor = const Color(0xFF183B2E),
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF718076)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFEAF3DD),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.celebration_rounded, color: Color(0xFF12543B), size: 44),
            ),
            const SizedBox(height: 16),
            Text(
              'Đã trao túi thành công!',
              style: GoogleFonts.beVietnamPro(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF183B2E),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Đơn hàng ${order?.orderCode ?? 'RB-1024'} của khách ${order?.customerName ?? 'Thanh Hậu'} đã được hoàn tất. +1 Bữa ngon được cứu!',
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                color: const Color(0xFF718076),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12543B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: Text(
                  'Hoàn tất',
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
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
