import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantRegisterScreen extends StatefulWidget {
  const MerchantRegisterScreen({super.key});

  @override
  State<MerchantRegisterScreen> createState() => _MerchantRegisterScreenState();
}

class _MerchantRegisterScreenState extends State<MerchantRegisterScreen> {
  final _storeNameController = TextEditingController(text: 'Tiệm Bánh Mây');
  final _categoryController = TextEditingController(text: 'Bánh mì & bánh ngọt');
  final _addressController = TextEditingController(text: '12 Trần Phú, Hải Châu');
  final _phoneController = TextEditingController(text: '0236 3822 1234');

  @override
  void dispose() {
    _storeNameController.dispose();
    _categoryController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    Navigator.pushNamed(context, '/merchant-verification');
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
          'Thông tin cửa hàng',
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESQ PARTNER',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF12543B),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thông tin cửa hàng',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Giúp khách hàng nhận ra cửa hàng của bạn.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 28),

              // Store Name
              Text(
                'Tên cửa hàng',
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
                  controller: _storeNameController,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: 'Tiệm Bánh Mây',
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

              // Address
              Text(
                'Địa chỉ',
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
                  controller: _addressController,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: '12 Trần Phú, Hải Châu',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Phone number
              Text(
                'Số điện thoại',
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF183B2E)),
                  decoration: const InputDecoration(
                    hintText: '0236 3822 1234',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
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
                    'Tiếp tục',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
