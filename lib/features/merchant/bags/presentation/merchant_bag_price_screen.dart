import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantBagPriceScreen extends StatefulWidget {
  const MerchantBagPriceScreen({super.key});

  @override
  State<MerchantBagPriceScreen> createState() => _MerchantBagPriceScreenState();
}

class _MerchantBagPriceScreenState extends State<MerchantBagPriceScreen> {
  late TextEditingController _originalPriceController;
  late TextEditingController _rescuePriceController;
  int _discountPercent = 65;

  @override
  void initState() {
    super.initState();
    final draft = MerchantStore.instance.draftBag;
    _originalPriceController = TextEditingController(text: '${draft.originalPrice}');
    _rescuePriceController = TextEditingController(text: '${draft.rescuePrice}');
    _recalculate();
  }

  void _recalculate() {
    final orig = int.tryParse(_originalPriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 100000;
    final rescue = int.tryParse(_rescuePriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 35000;
    if (orig > 0) {
      setState(() {
        _discountPercent = (((orig - rescue) / orig) * 100).round();
      });
    }
  }

  @override
  void dispose() {
    _originalPriceController.dispose();
    _rescuePriceController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final orig = int.tryParse(_originalPriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 100000;
    final rescue = int.tryParse(_rescuePriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 35000;
    final store = MerchantStore.instance;
    store.updateDraftBag(store.draftBag.copyWith(
      originalPrice: orig,
      rescuePrice: rescue,
    ));
    Navigator.pushNamed(context, '/merchant-pickup-window');
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');
    final rescueVal = int.tryParse(_rescuePriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 35000;

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
          'Giá thật, giá giải cứu',
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
                    // Stepper: 1 (done) - 2 Thanh toán (active) - 3 Hoàn tất
                    Row(
                      children: [
                        _buildStep('1', 'Kiểm tra', true, isCompleted: true),
                        Expanded(child: Container(height: 2, color: const Color(0xFF12543B))),
                        _buildStep('2', 'Thanh toán', true),
                        Expanded(child: Container(height: 2, color: const Color(0xFFE4E9E1))),
                        _buildStep('3', 'Hoàn tất', false),
                      ],
                    ),
                    const SizedBox(height: 20),

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
                      'Giá thật, giá giải cứu',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Giá trị gốc là giá trị tối thiểu thực phẩm trong túi.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input 1: Giá trị gốc
                    _buildLabel('Giá trị gốc'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _originalPriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _recalculate(),
                      style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        suffixText: 'đ',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input 2: Giá giải cứu
                    _buildLabel('Giá giải cứu'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _rescuePriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _recalculate(),
                      style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        suffixText: 'đ',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 3: Mức giảm
                    _buildLabel('Mức giảm'),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Text(
                        '$_discountPercent%',
                        style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 4: Doanh thu dự kiến mỗi túi
                    _buildLabel('Doanh thu dự kiến mỗi túi'),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Text(
                        '${currencyFormat.format(rescueVal)}đ trước phí',
                        style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tip banner matching Figma M15
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF3DD),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFD3E7BE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giảm $_discountPercent% so với giá gốc',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF12543B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Giá trị gốc phải là giá trị tối thiểu thực phẩm trong túi.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: const Color(0xFF12543B),
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
                  onPressed: _onContinue,
                  child: Text(
                    'Chọn giờ nhận',
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.beVietnamPro(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF183B2E),
      ),
    );
  }

  Widget _buildStep(String num, String label, bool isActive, {bool isCompleted = false}) {
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
          child: isCompleted
              ? const Icon(Icons.check, size: 12, color: Colors.white)
              : Text(
                  num,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : const Color(0xFF718076),
                  ),
                ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFF12543B) : const Color(0xFF718076),
          ),
        ),
      ],
    );
  }
}
