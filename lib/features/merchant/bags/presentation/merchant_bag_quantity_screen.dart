import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantBagQuantityScreen extends StatefulWidget {
  const MerchantBagQuantityScreen({super.key});

  @override
  State<MerchantBagQuantityScreen> createState() => _MerchantBagQuantityScreenState();
}

class _MerchantBagQuantityScreenState extends State<MerchantBagQuantityScreen> {
  late int _quantity;
  final int _minOrdered = 2; // Locked minimum because 2 bags already paid in mock

  @override
  void initState() {
    super.initState();
    _quantity = MerchantStore.instance.draftBag.remainingQuantity;
    if (_quantity < _minOrdered) _quantity = 4;
  }

  void _onSave() {
    final store = MerchantStore.instance;
    store.updateDraftBag(store.draftBag.copyWith(
      remainingQuantity: _quantity,
      orderedCount: _minOrdered,
    ));
    Navigator.pushNamed(context, '/merchant-bag-ingredients');
  }

  @override
  Widget build(BuildContext context) {
    final draft = MerchantStore.instance.draftBag;
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

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
          'Số túi sẵn sàng',
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
        child: Column(
          children: [
            Expanded(
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
                      'Số túi sẵn sàng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Chỉ mở bán lượng túi bạn có thể chuẩn bị.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bag Preview Card matching Figma M17
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              draft.image,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 56,
                                height: 56,
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
                                  'Tiệm Bánh Mây',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  draft.title,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${currencyFormat.format(draft.rescuePrice)}đ',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF2EB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$_quantity túi',
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

                    const SizedBox(height: 20),

                    // Quantity Counter Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SỐ TÚI SẴN SÀNG HÔM NAY',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF718076),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // (-) Button
                              InkWell(
                                onTap: () {
                                  if (_quantity > _minOrdered) {
                                    setState(() => _quantity--);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Không thể giảm dưới số lượng đã được đặt!'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE4E9E1)),
                                    color: _quantity > _minOrdered ? Colors.white : Colors.grey.shade100,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: _quantity > _minOrdered ? const Color(0xFF183B2E) : Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),
                              Text(
                                '$_quantity',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              const SizedBox(width: 32),
                              // (+) Button
                              InkWell(
                                onTap: () => setState(() => _quantity++),
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE4E9E1)),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Color(0xFF183B2E),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF3DD),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Đã đặt: $_minOrdered túi',
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

                    const SizedBox(height: 18),

                    // Warning Alert Banner matching Figma M17
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
                              'Không thể giảm số lượng xuống dưới $_minOrdered túi vì đã có đơn thanh toán. Chỉ mở bán số túi thực tế có thể chuẩn bị.',
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

            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12543B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: _onSave,
                  child: Text(
                    'Lưu số lượng',
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

