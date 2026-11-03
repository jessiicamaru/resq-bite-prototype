import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final MysteryBag? bag;
  final int quantity;
  final String currentMethod;

  const PaymentMethodsScreen({
    super.key,
    this.bag,
    this.quantity = 1,
    this.currentMethod = 'MoMo',
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentMethod;
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
          'Thanh toán bằng',
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
                    // Stepper: (1) Kiểm tra  ---- (2) Thanh toán ---- (3) Hoàn tất
                    _buildStepper(),

                    const SizedBox(height: 20),

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
                      'Thanh toán bằng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Chọn phương thức phù hợp với bạn.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Method 1: MoMo
                    _buildMethodCard(
                      id: 'MoMo',
                      title: 'MoMo',
                      subtitle: 'Ví đã liên kết · 090 ••• 1234',
                      icon: Icons.credit_card_outlined,
                      isSelected: _selected == 'MoMo',
                      onTap: () => setState(() => _selected = 'MoMo'),
                    ),

                    const SizedBox(height: 12),

                    // Method 2: Thẻ Visa •••• 1234
                    _buildMethodCard(
                      id: 'Visa',
                      title: 'Thẻ Visa •••• 1234',
                      subtitle: 'Thẻ đã lưu, không lưu CVV',
                      icon: Icons.credit_card_outlined,
                      isSelected: _selected == 'Visa',
                      onTap: () => setState(() => _selected = 'Visa'),
                    ),

                    const SizedBox(height: 12),

                    // Method 3: ZaloPay
                    _buildMethodCard(
                      id: 'ZaloPay',
                      title: 'ZaloPay',
                      subtitle: 'Chuyển đến ví để xác nhận',
                      icon: Icons.credit_card_outlined,
                      isSelected: _selected == 'ZaloPay',
                      onTap: () => setState(() => _selected = 'ZaloPay'),
                    ),

                    const SizedBox(height: 12),

                    // Method 4: Thêm thẻ mới
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tính năng liên kết thẻ ngân hàng mới đang cập nhật.')),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE4E9E1)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.add, color: Color(0xFF183B2E), size: 24),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thêm thẻ mới',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF183B2E),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Thẻ ghi nợ hoặc tín dụng',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      color: const Color(0xFF718076),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Color(0xFF183B2E), size: 20),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Notice Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF2EB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.spa_outlined, color: Color(0xFF12543B), size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Thanh toán trước, nhận tại quầy. Không cần trả thêm khi nhận.',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: const Color(0xFF183B2E),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA: Xác nhận phương thức
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
                    // BƯỚC TIẾP THEO: Xác nhận đặt túi (Image 9)
                    Navigator.pushNamed(
                      context,
                      '/confirm-order',
                      arguments: {
                        'bag': widget.bag,
                        'quantity': widget.quantity,
                        'payment': _selected,
                      },
                    );
                  },
                  child: Text(
                    'Xác nhận phương thức',
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
        _buildStepItem(number: '1', label: 'Kiểm tra', isActive: false),
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFD4DDD6),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),
        ),
        _buildStepItem(number: '2', label: 'Thanh toán', isActive: true),
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

  Widget _buildMethodCard({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFFE4E9E1),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF12543B) : const Color(0xFFD4DDD6),
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Icon(icon, color: const Color(0xFF183B2E), size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
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
      ),
    );
  }
}
