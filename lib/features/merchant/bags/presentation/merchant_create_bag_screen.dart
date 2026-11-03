import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantCreateBagScreen extends StatefulWidget {
  const MerchantCreateBagScreen({super.key});

  @override
  State<MerchantCreateBagScreen> createState() => _MerchantCreateBagScreenState();
}

class _MerchantCreateBagScreenState extends State<MerchantCreateBagScreen> {
  final _titleController = TextEditingController(text: 'Túi bánh cuối ngày');
  final _categoryController = TextEditingController(text: 'Bánh mì & bánh ngọt');
  final _descController = TextEditingController(text: 'Bánh còn dư được chọn trong ngày');

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onContinue() {
    Navigator.pushNamed(context, '/merchant-pickup-window');
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
          'Tạo một túi mới',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stepper matching Figma M14
              Row(
                children: [
                  _buildStep('1', 'Kiểm tra', true),
                  Expanded(child: Container(height: 2, color: const Color(0xFF12543B))),
                  _buildStep('2', 'Thanh toán', false),
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
                  color: const Color(0xFF12543B),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Tạo một túi mới',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Đặt tên theo danh mục, không cam kết món cụ thể.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 24),

              // Bag Title
              Text(
                'Tên túi',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: TextField(
                  controller: _titleController,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: 'Túi bánh cuối ngày',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Category
              Text(
                'Danh mục',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: TextField(
                  controller: _categoryController,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: 'Bánh mì & bánh ngọt',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Description
              Text(
                'Mô tả',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: TextField(
                  controller: _descController,
                  maxLines: 3,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: 'Bánh còn dư được chọn trong ngày',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Illustration Photo matching Figma M14
              Text(
                'Ảnh minh họa',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/hero_c01.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Chọn ảnh hoặc dùng hình mặc định',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                      ),
                    ),
                    const Icon(Icons.photo_library_outlined, color: Color(0xFF12543B), size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12543B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: _onContinue,
                  child: Text(
                    'Thiết lập mức giá',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String number, String label, bool isActive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
            color: isActive ? const Color(0xFF183B2E) : const Color(0xFF718076),
          ),
        ),
      ],
    );
  }
}
