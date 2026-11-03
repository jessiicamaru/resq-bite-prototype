import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class CartCheckoutScreen extends StatefulWidget {
  final MysteryBag bag;
  final int quantity;
  final String? notes;
  final bool bringOwnBag;
  final bool isDelivery;

  const CartCheckoutScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.notes,
    this.bringOwnBag = true,
    this.isDelivery = false,
  });

  @override
  State<CartCheckoutScreen> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  late int _quantity;
  final currencyFormat = NumberFormat('#,###', 'vi_VN');

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _increment() {
    if (_quantity < widget.bag.remainingBags && _quantity < 4) {
      setState(() => _quantity++);
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalTotal = widget.bag.originalPrice * _quantity;
    final rescueTotal = widget.bag.rescuePrice * _quantity;

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
          'Túi của bạn',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Đổi phương thức nhận',
              style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF183B2E),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stepper: (1) Kiểm tra  ---- (2) Thanh toán ---- (3) Hoàn tất
                    _buildStepper(),

                    const SizedBox(height: 20),

                    // Store & Item Card
                    Container(
                      width: double.infinity,
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
                            widget.bag.storeName,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/hero_c01.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 60,
                                    height: 60,
                                    color: const Color(0xFFEAF3DD),
                                    child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.bag.title,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$_quantity túi · ${currencyFormat.format(widget.bag.rescuePrice)}đ/túi',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Số lượng',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: _decrement,
                                    borderRadius: BorderRadius.circular(18),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xFFD4DDD6)),
                                      ),
                                      child: const Icon(Icons.remove, size: 16, color: Color(0xFF183B2E)),
                                    ),
                                  ),
                                  Container(
                                    width: 36,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$_quantity',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _increment,
                                    borderRadius: BorderRadius.circular(18),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xFFD4DDD6)),
                                      ),
                                      child: const Icon(Icons.add, size: 16, color: Color(0xFF183B2E)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Thời gian & điểm nhận Card
                    Container(
                      width: double.infinity,
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
                            children: [
                              const Icon(Icons.access_time_rounded, size: 20, color: Color(0xFF183B2E)),
                              const SizedBox(width: 8),
                              Text(
                                'Thời gian & điểm nhận',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Hôm nay · ${widget.bag.pickupWindow}',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.bag.storeAddress,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Quầy bên phải cửa chính',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Vào cửa chính Tiệm Bánh Mây, xuất trình mã QR tại quầy thu ngân.')),
                              );
                            },
                            child: Text(
                              'Xem hướng dẫn nhận →',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF12543B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Chi tiết thanh toán Card
                    Container(
                      width: double.infinity,
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
                            'Chi tiết thanh toán',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildPriceRow('Giá trị ban đầu', '${currencyFormat.format(originalTotal)}đ', isMuted: true),
                          const SizedBox(height: 8),
                          _buildPriceRow('Giá giải cứu × $_quantity', '${currencyFormat.format(rescueTotal)}đ', isBold: true),
                          const SizedBox(height: 8),
                          _buildPriceRow('Phí nền tảng', '0đ', isMuted: true),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: Color(0xFFE4E9E1), height: 1),
                          ),
                          _buildPriceRow('Tổng thanh toán', '${currencyFormat.format(rescueTotal)}đ', isLarge: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA: Chọn thanh toán
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
              ),
              child: SizedBox(
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
                    // BƯỚC TIẾP THEO: Chọn phương thức thanh toán (Image 8)
                    Navigator.pushNamed(
                      context,
                      '/payment-methods',
                      arguments: {
                        'bag': widget.bag,
                        'quantity': _quantity,
                        'notes': widget.notes,
                        'bringOwnBag': widget.bringOwnBag,
                      },
                    );
                  },
                  child: Text(
                    'Chọn thanh toán',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _buildStepItem(number: '1', label: 'Kiểm tra', isActive: true),
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFD4DDD6),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),
        ),
        _buildStepItem(number: '2', label: 'Thanh toán', isActive: false),
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFD4DDD6),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),
        ),
        _buildStepItem(number: '3', label: 'Hoàn tất', isActive: false),
      ],
    );
  }

  Widget _buildStepItem({required String number, required String label, required bool isActive}) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF12543B) : const Color(0xFFE4E9E1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.beVietnamPro(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : const Color(0xFF718076),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFF12543B) : const Color(0xFF718076),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false, bool isMuted = false, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: isLarge ? 14 : 12,
            fontWeight: isLarge || isBold ? FontWeight.w700 : FontWeight.w400,
            color: isMuted ? const Color(0xFF718076) : const Color(0xFF183B2E),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: isLarge ? 15 : 12,
            fontWeight: isLarge || isBold ? FontWeight.w700 : FontWeight.w400,
            color: const Color(0xFF183B2E),
          ),
        ),
      ],
    );
  }
}
