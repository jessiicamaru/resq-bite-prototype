import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Topbar matching Figma C01
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
                      border: Border.all(color: AppColors.border),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      tooltip: 'Danh sách màn hình',
                      icon: const Icon(Icons.apps_rounded, size: 20, color: AppColors.primary),
                      onPressed: () => Navigator.pushNamed(context, '/catalog'),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Chào mừng đến ResQ Bites',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: Text(
                      'Bỏ qua',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
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

                    // Hero Photo from Figma C01
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            'assets/images/hero_c01.png',
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 280,
                              color: AppColors.primaryLight,
                              child: const Icon(Icons.restaurant_rounded, size: 64, color: AppColors.primary),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.92),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.eco_rounded, color: AppColors.primary, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Tiêu dùng bền vững · SDG 2 & 12',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                      'Bữa ngon còn đó.\nCùng nhau giải cứu.',
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
                      'Bữa ngon còn đó. Cùng nhau giải cứu.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Dots matching Figma (dot 1 active pill, dot 2 & 3 dots)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF12543B),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD0DCC6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD0DCC6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Badge: TIẾT KIỆM ĐẾN 70%
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF3DD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'TIẾT KIỆM ĐẾN 70%',
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

            // Sticky Bottom CTA container matching Figma
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
                  onPressed: () => Navigator.pushReplacementNamed(context, '/onboarding'),
                  child: Text(
                    'Bắt đầu',
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
