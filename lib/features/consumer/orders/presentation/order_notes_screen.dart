import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class OrderNotesScreen extends StatefulWidget {
  final MysteryBag bag;
  final int initialQuantity;

  const OrderNotesScreen({
    super.key,
    required this.bag,
    this.initialQuantity = 1,
  });

  @override
  State<OrderNotesScreen> createState() => _OrderNotesScreenState();
}

class _OrderNotesScreenState extends State<OrderNotesScreen> {
  late int _quantity;
  final TextEditingController _notesController = TextEditingController();
  bool _bringOwnBag = true;
  final currencyFormat = NumberFormat('#,###', 'vi_VN');

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
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
    final totalPrice = widget.bag.rescuePrice * _quantity;

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
          'Ghi chú cho cửa hàng',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
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
                    Text(
                      'MỖI BỮA ĂN ĐỀU ĐÁNG GIÁ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF63834D),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ghi chú cho cửa hàng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cửa hàng có thể không đáp ứng được mọi yêu cầu.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Store & Bag Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/hero_c01.png',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 64,
                                height: 64,
                                color: const Color(0xFFEAF3DD),
                                child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
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
                                const SizedBox(height: 2),
                                Text(
                                  widget.bag.title,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${currencyFormat.format(widget.bag.rescuePrice)}đ',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF2EB),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${widget.bag.remainingBags} túi',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF12543B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Quantity Stepper Card
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Số lượng túi',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: _decrement,
                                    borderRadius: BorderRadius.circular(18),
                                    child: Container(
                                      width: 36,
                                      height: 36,
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
                                      width: 36,
                                      height: 36,
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
                          const SizedBox(height: 10),
                          Text(
                            'Còn ${widget.bag.remainingBags} túi · Tối đa 4 túi mỗi đơn',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: const Color(0xFF718076),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Note input section
                    Text(
                      'Ghi chú cho cửa hàng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      child: TextField(
                        controller: _notesController,
                        maxLines: 4,
                        minLines: 3,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 13,
                          color: const Color(0xFF183B2E),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ví dụ: Không cần dụng cụ ăn uống',
                          hintStyle: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            color: const Color(0xFF183B2E).withValues(alpha: 0.65),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cửa hàng có thể không đáp ứng yêu cầu đổi món hoặc loại trừ dị nguyên.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: const Color(0xFF718076),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Bring own bag checkbox
                    InkWell(
                      onTap: () => setState(() => _bringOwnBag = !_bringOwnBag),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _bringOwnBag ? const Color(0xFF12543B) : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _bringOwnBag ? const Color(0xFF12543B) : const Color(0xFFD4DDD6),
                              ),
                            ),
                            child: _bringOwnBag
                                ? const Icon(Icons.check, size: 15, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Tôi sẽ mang túi cá nhân nếu có thể',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: const Color(0xFF183B2E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Notice card: Pickup window info
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF2EB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 20, color: Color(0xFF12543B)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Nhận tại quầy ${widget.bag.pickupWindow} hôm nay tại ${widget.bag.storeAddress}',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                color: const Color(0xFF183B2E),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA: Thêm X túi • Yđ
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
                    // BƯỚC TIẾP THEO: Chọn phương thức nhận (Image 5 & 6)
                    Navigator.pushNamed(
                      context,
                      '/delivery-mode',
                      arguments: {
                        'bag': widget.bag,
                        'quantity': _quantity,
                        'notes': _notesController.text,
                        'bringOwnBag': _bringOwnBag,
                      },
                    );
                  },
                  child: Text(
                    'Thêm $_quantity túi • ${currencyFormat.format(totalPrice)}đ',
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
}
