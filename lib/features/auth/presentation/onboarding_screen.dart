import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  final int initialPage;
  const OnboardingScreen({super.key, this.initialPage = 0});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'code': 'C02',
      'image': 'assets/screens/hero_c02.png',
      'title': 'Bữa ngon, giá nhẹ',
      'subtitle': 'Đồ ăn cuối ngày vẫn có thể trở thành một bữa ngon.',
      'btn': 'Tiếp tục',
    },
    {
      'code': 'C03',
      'image': 'assets/screens/hero_c03.png',
      'title': 'Một túi bất ngờ',
      'subtitle': 'Biết danh mục, bất ngờ với món ngon bên trong.',
      'btn': 'Tiếp tục',
    },
    {
      'code': 'C04',
      'image': 'assets/screens/hero_c04.png',
      'title': 'Đến nhận, cứu một bữa',
      'subtitle': 'Đặt trước. Đến đúng giờ. Đưa mã QR tại quầy.',
      'btn': 'Khám phá ngay',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Topbar matching Figma C02-C04
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
                      icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                      color: AppColors.textPrimary,
                      onPressed: () {
                        if (_currentPage > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacementNamed(context, '/splash');
                        }
                      },
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

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),

                        // Hero Photo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            slide['image']!,
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 280,
                              color: AppColors.primaryLight,
                              child: const Icon(Icons.fastfood_rounded, size: 64, color: AppColors.primary),
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
                          slide['title']!,
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
                          slide['subtitle']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: const Color(0xFF718076),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dots matching Figma
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (dotIndex) {
                            final isActive = dotIndex == _currentPage;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: isActive ? 24 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isActive ? const Color(0xFF12543B) : const Color(0xFFD0DCC6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
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
                  );
                },
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
                  onPressed: _onNext,
                  child: Text(
                    _slides[_currentPage]['btn']!,
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
