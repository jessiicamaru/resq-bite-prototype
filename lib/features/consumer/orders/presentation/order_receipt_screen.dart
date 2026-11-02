import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class OrderReceiptScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;
  final String orderCode;

  const OrderReceiptScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.orderCode = 'RESQ-8942-DN',
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');
    final originalTotal = bag.originalPrice * quantity;
    final rescueTotal = bag.rescuePrice * quantity;
    final savings = originalTotal - rescueTotal;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Biên Nhận Thanh Toán'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã lưu biên lai điện tử PDF về máy!')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.receipt_rounded, color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'HÓA ĐƠN ĐIỆN TỬ',
                        style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1.0),
                      ),
                      Text(
                        '${currencyFormat.format(rescueTotal)}đ',
                        style: GoogleFonts.beVietnamPro(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      Text(
                        'Thanh toán thành công qua Ví MoMo',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 32, color: AppColors.divider),

                _buildReceiptRow('Mã hóa đơn', orderCode),
                _buildReceiptRow('Thời gian', DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now())),
                _buildReceiptRow('Cửa hàng', bag.storeName),
                _buildReceiptRow('Địa chỉ', bag.storeAddress),
                _buildReceiptRow('Túi giải cứu', '${bag.title} (x$quantity)'),
                _buildReceiptRow('Khung giờ đón', bag.pickupWindow),

                const Divider(height: 32, color: AppColors.divider),

                _buildReceiptRow('Giá gốc', '${currencyFormat.format(originalTotal)}đ'),
                _buildReceiptRow('Giảm giá cứu thực phẩm', '-${currencyFormat.format(savings)}đ', isHighlight: true),
                _buildReceiptRow('Phí dịch vụ', 'Miễn phí'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thực thanh toán',
                      style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    Text(
                      '${currencyFormat.format(rescueTotal)}đ',
                      style: GoogleFonts.beVietnamPro(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.eco_rounded, color: AppColors.primary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Đơn hàng này đã giúp giảm 2.4 kg CO₂ phát thải (Mục tiêu SDG 12).',
                          style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/order-qr',
                      arguments: {'bag': bag, 'quantity': quantity},
                    );
                  },
                  child: const Text('Xem Vé Lấy Hàng QR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isHighlight ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
