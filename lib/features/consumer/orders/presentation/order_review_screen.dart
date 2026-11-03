import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';
import '../../../../data/store/order_store.dart';

class OrderReviewScreen extends StatefulWidget {
  final MysteryBag bag;
  final String orderCode;

  const OrderReviewScreen({
    super.key,
    required this.bag,
    this.orderCode = 'RB-1024',
  });

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  int _rating = 5;
  final Set<String> _selectedChips = {'Món ngon', 'Nhận nhanh'};
  final TextEditingController _commentController = TextEditingController();

  final List<String> _chips = ['Món ngon', 'Nhận nhanh', 'Đúng tiền'];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
          'Túi hôm nay thế nào?',
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
                      'Túi hôm nay thế nào?',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Chia sẻ để những lần giải cứu sau tốt hơn.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Store Item Card (C45)
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
                              width: 58,
                              height: 58,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 58,
                                height: 58,
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
                                    fontSize: 11,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '35.000đ',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
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
                              '4 túi',
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

                    // Star Rating (C45)
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final starVal = index + 1;
                              return IconButton(
                                iconSize: 36,
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                onPressed: () => setState(() => _rating = starVal),
                                icon: Icon(
                                  starVal <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                                  color: const Color(0xFFED944B),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _rating == 5 ? 'Rất hài lòng' : (_rating >= 4 ? 'Hài lòng' : 'Bình thường'),
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Quick review chips (C45)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _chips.map((chip) {
                        final isSelected = _selectedChips.contains(chip);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedChips.remove(chip);
                                } else {
                                  _selectedChips.add(chip);
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFEBF2EB) : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF12543B) : const Color(0xFFE4E9E1),
                                ),
                              ),
                              child: Text(
                                chip,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  color: isSelected ? const Color(0xFF12543B) : const Color(0xFF183B2E),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Chia sẻ trải nghiệm
                    Text(
                      'Chia sẻ trải nghiệm',
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
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: TextField(
                        controller: _commentController,
                        maxLines: 4,
                        minLines: 3,
                        style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF183B2E)),
                        decoration: InputDecoration(
                          hintText: 'Điều gì khiến bạn thích túi hôm nay?',
                          hintStyle: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Camera Photo Box (C45)
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã chọn 1 ảnh món ăn!')),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F6EE),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFD4DDD6)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt_outlined, color: Color(0xFF12543B), size: 24),
                            const SizedBox(height: 6),
                            Text(
                              'Thêm ảnh món ăn',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                color: const Color(0xFF718076),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA: Gửi đánh giá (C45)
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
                    // Cập nhật State trong OrderStore
                    OrderStore.instance.submitReview(
                      widget.orderCode,
                      rating: _rating,
                      tags: _selectedChips.toList(),
                      comment: _commentController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cảm ơn bạn đã đánh giá! Nhận +50 Điểm Thưởng Xanh.'),
                        backgroundColor: Color(0xFF12543B),
                      ),
                    );

                    Navigator.pushReplacementNamed(context, '/orders-history');
                  },
                  child: Text(
                    'Gửi đánh giá',
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
