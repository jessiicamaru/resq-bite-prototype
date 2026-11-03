import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class AllergyCheckScreen extends StatefulWidget {
  final MysteryBag bag;
  const AllergyCheckScreen({super.key, required this.bag});

  @override
  State<AllergyCheckScreen> createState() => _AllergyCheckScreenState();
}

class _AllergyCheckScreenState extends State<AllergyCheckScreen> {
  bool _isChecked = false;

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
          'Kiểm tra dị ứng',
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
                      'Kiểm tra dị ứng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Túi ngẫu nhiên không đảm bảo loại trừ dị nguyên.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Peach Warning Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFFE0C2)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Color(0xFF8F4C17), size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Túi bí mật không đảm bảo loại trừ dị nguyên. Không tiếp tục đặt nếu chưa chắc món phù hợp với bạn.',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: const Color(0xFF8F4C17),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // White Card: Có thể chứa trong túi này
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Có thể chứa trong túi này',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildAllergenItem('Lúa mì'),
                          const SizedBox(height: 16),
                          _buildAllergenItem('sữa'),
                          const SizedBox(height: 16),
                          _buildAllergenItem('trứng và hạt'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'Ghi chú không thay thế xác nhận của cửa hàng. Ngay cả khi món không có một thành phần, tiếp xúc chéo vẫn có thể xảy ra.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: const Color(0xFF718076),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Outline Button: Xem thông tin cửa hàng
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFE4E9E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/store-detail', arguments: widget.bag);
                        },
                        child: Text(
                          'Xem thông tin cửa hàng',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Checkbox Row
                    InkWell(
                      onTap: () => setState(() => _isChecked = !_isChecked),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _isChecked,
                            activeColor: const Color(0xFF12543B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (val) => setState(() => _isChecked = val ?? false),
                          ),
                          Expanded(
                            child: Text(
                              'Tôi đã đọc thông tin dị ứng và tự kiểm tra sự phù hợp của túi này.',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
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

            // Sticky Bottom CTA: Tiếp tục chọn túi (disabled if not checked)
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
                    backgroundColor: _isChecked ? const Color(0xFF12543B) : const Color(0xFF94A89E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: _isChecked
                      ? () {
                          // BƯỚC TIẾP THEO: Ghi chú cho cửa hàng (Image 4)
                          Navigator.pushNamed(
                            context,
                            '/order-notes',
                            arguments: {'bag': widget.bag},
                          );
                        }
                      : null,
                  child: Text(
                    'Tiếp tục chọn túi',
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

  Widget _buildAllergenItem(String label) {
    return Row(
      children: [
        const Icon(Icons.warning_amber_rounded, size: 20, color: Color(0xFF63834D)),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            color: const Color(0xFF183B2E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
