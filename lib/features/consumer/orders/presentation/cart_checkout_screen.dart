import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class CartCheckoutScreen extends StatefulWidget {
  final MysteryBag bag;
  final int quantity;
  final String selectedPayment;

  const CartCheckoutScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.selectedPayment = 'Ví MoMo',
  });

  @override
  State<CartCheckoutScreen> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  final currencyFormat = NumberFormat('#,###', 'vi_VN');
  final _noteController = TextEditingController();
  late String _currentPayment;

  @override
  void initState() {
    super.initState();
    _currentPayment = widget.selectedPayment;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onConfirmPayment() {
    Navigator.pushReplacementNamed(
      context,
      '/payment-success',
      arguments: {
        'bag': widget.bag,
        'quantity': widget.quantity,
        'payment': _currentPayment,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final originalTotal = widget.bag.originalPrice * widget.quantity;
    final rescueTotal = widget.bag.rescuePrice * widget.quantity;
    final savings = originalTotal - rescueTotal;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Xác Nhận Đặt Túi'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store & Pickup Window banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.storefront_rounded, color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          widget.bag.storeName,
                          style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.bag.storeAddress,
                      style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF92400E)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Khung giờ đến nhận: ${widget.bag.pickupWindow}',
                              style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF92400E)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bag item row
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.bag.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 70,
                          height: 70,
                          color: AppColors.primaryLight,
                          child: const Icon(Icons.fastfood, color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bag.title,
                            style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Số lượng: x${widget.quantity} túi',
                            style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${currencyFormat.format(rescueTotal)}đ',
                            style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Allergy & Merchant Note
              Text(
                'Lưu ý dị ứng / Ghi chú cho cửa hàng',
                style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Ví dụ: Dị ứng đậu phộng, ăn chay không trứng...',
                  prefixIcon: const Icon(Icons.edit_note_rounded, size: 22, color: AppColors.textMuted),
                ),
              ),

              const SizedBox(height: 20),

              // Payment Method Picker
              Text(
                'Phương thức thanh toán',
                style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(context, '/payment-methods');
                  if (result is String) {
                    setState(() => _currentPayment = result);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined, color: AppColors.primary, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _currentPayment,
                          style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Price Breakdown
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildPriceRow('Giá gốc ban ngày', '${currencyFormat.format(originalTotal)}đ'),
                    const SizedBox(height: 8),
                    _buildPriceRow('Giảm giá cứu thực phẩm', '-${currencyFormat.format(savings)}đ', isDiscount: true),
                    const SizedBox(height: 8),
                    _buildPriceRow('Phí dịch vụ & đóng gói', 'Miễn phí'),
                    const Divider(height: 24, color: AppColors.divider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng thanh toán',
                          style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        Text(
                          '${currencyFormat.format(rescueTotal)}đ',
                          style: GoogleFonts.beVietnamPro(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onConfirmPayment,
                  child: Text('Xác nhận & Thanh toán (${currencyFormat.format(rescueTotal)}đ)'),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary)),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDiscount ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

