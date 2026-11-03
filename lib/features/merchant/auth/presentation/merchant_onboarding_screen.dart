import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantOnboardingScreen extends StatelessWidget {
  const MerchantOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Topbar matching Figma M01
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
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
                  const Spacer(),
                  Text(
                    'Chào mừng đến ResQ Bites',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/merchant-home'),
                    child: Text(
                      'Bỏ qua',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Hero Photo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/screens/hero_c01.png',
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 280,
                          color: const Color(0xFFEAF3DD),
                          child: const Icon(Icons.storefront_rounded, size: 64, color: Color(0xFF12543B)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Logo Mark: resq bites.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'resq',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF183B2E),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'bites.',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF80A05B),
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Title
                    Text(
                      'Cùng cứu những bữa ngon',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Biến thực phẩm cuối ngày thành cơ hội mới.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Badge: DÀNH CHO ĐỐI TÁC
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF3DD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'DÀNH CHO ĐỐI TÁC',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF12543B),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE4E9E1)),
                ),
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
                  onPressed: () => Navigator.pushNamed(context, '/merchant-register'),
                  child: Text(
                    'Đăng ký cửa hàng',
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
