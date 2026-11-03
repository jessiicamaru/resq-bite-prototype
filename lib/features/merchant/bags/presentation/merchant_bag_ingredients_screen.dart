import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantBagIngredientsScreen extends StatefulWidget {
  const MerchantBagIngredientsScreen({super.key});

  @override
  State<MerchantBagIngredientsScreen> createState() => _MerchantBagIngredientsScreenState();
}

class _MerchantBagIngredientsScreenState extends State<MerchantBagIngredientsScreen> {
  late TextEditingController _allergiesController;
  late TextEditingController _storageController;
  late TextEditingController _pickupGuideController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final draft = MerchantStore.instance.draftBag;
    _allergiesController = TextEditingController(text: draft.allergies);
    _storageController = TextEditingController(text: draft.storageGuide);
    _pickupGuideController = TextEditingController(text: draft.pickupGuide);
    _notesController = TextEditingController(text: draft.notes);
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _storageController.dispose();
    _pickupGuideController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onFinish() {
    final store = MerchantStore.instance;
    store.updateDraftBag(store.draftBag.copyWith(
      allergies: _allergiesController.text.trim(),
      storageGuide: _storageController.text.trim(),
      pickupGuide: _pickupGuideController.text.trim(),
      notes: _notesController.text.trim(),
    ));

    // Save newly created bag into MerchantStore
    store.saveDraftBag();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã tạo và mở bán túi thành công!'),
        backgroundColor: Color(0xFF12543B),
        duration: Duration(seconds: 2),
      ),
    );

    // Pop back to Bag List Screen (M13)
    Navigator.popUntil(context, (route) => route.settings.name == '/merchant-bags' || route.isFirst);
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
          'Thành phần & lưu ý',
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
                    // Stepper: 1 - 2 - 3 Hoàn tất (active)
                    Row(
                      children: [
                        _buildStep('1', 'Kiểm tra', true, isCompleted: true),
                        Expanded(child: Container(height: 2, color: const Color(0xFF12543B))),
                        _buildStep('2', 'Thanh toán', true, isCompleted: true),
                        Expanded(child: Container(height: 2, color: const Color(0xFF12543B))),
                        _buildStep('3', 'Hoàn tất', true),
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
                      'Thành phần & lưu ý',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Thông tin rõ ràng giúp khách quyết định an toàn.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Field 1: Dị nguyên
                    _buildLabel('Dị nguyên'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _allergiesController,
                      style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 2: Bảo quản
                    _buildLabel('Bảo quản'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _storageController,
                      style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 3: Hướng dẫn nhận
                    _buildLabel('Hướng dẫn nhận'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _pickupGuideController,
                      style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 4: Ghi chú
                    _buildLabel('Ghi chú'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _notesController,
                      maxLines: 4,
                      style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF183B2E)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE4E9E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5)),
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
                  onPressed: _onFinish,
                  child: Text(
                    'Xem trước túi & Mở bán',
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

