import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/food_bag.dart';

class MapExplorerScreen extends StatefulWidget {
  final MysteryBag? initialBag;

  const MapExplorerScreen({super.key, this.initialBag});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  late MysteryBag _selectedBag;
  int _selectedBottomNav = 1; // Tab 1: Bản đồ

  @override
  void initState() {
    super.initState();
    _selectedBag = widget.initialBag ?? mockMysteryBags.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Topbar: < Đường đến Mây
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  const SizedBox(width: 14),
                  Text(
                    'Đường đến Mây',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                ],
              ),
            ),

            // Filter chips: [3 km] [Xem danh sách]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12543B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.tune_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          '3 km',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE4E9E1)),
                    ),
                    child: Text(
                      'Xem danh sách',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Map canvas area with interactive elements
            Expanded(
              child: Stack(
                children: [
                  // Stylized Map Canvas
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _StylizedMapPainter(),
                    ),
                  ),

                  // Pins matching Figma C13
                  // Pin 1: Trần Phú - Tiệm Bánh Mây (35k - Orange active)
                  Positioned(
                    top: 140,
                    left: 70,
                    child: _buildPricePin(
                      label: '35k',
                      isActive: true,
                      onTap: () => setState(() => _selectedBag = mockMysteryBags[0]),
                    ),
                  ),

                  // Pin 2: 25k (Dark green)
                  Positioned(
                    top: 100,
                    right: 80,
                    child: _buildPricePin(
                      label: '25k',
                      isActive: false,
                      onTap: () => setState(() => _selectedBag = mockMysteryBags[1]),
                    ),
                  ),

                  // Pin 3: 39k (Dark green)
                  Positioned(
                    top: 280,
                    right: 120,
                    child: _buildPricePin(
                      label: '39k',
                      isActive: false,
                      onTap: () => setState(() => _selectedBag = mockMysteryBags[2]),
                    ),
                  ),

                  // Pin 4: 32k (Dark green)
                  Positioned(
                    top: 360,
                    left: 45,
                    child: _buildPricePin(
                      label: '32k',
                      isActive: false,
                      onTap: () => setState(() => _selectedBag = mockMysteryBags[3]),
                    ),
                  ),

                  // User location indicator
                  Positioned(
                    top: 230,
                    left: 155,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E6FF2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2E6FF2).withValues(alpha: 0.35),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Map note
                  Positioned(
                    bottom: 120,
                    right: 16,
                    child: Text(
                      'Bản đồ mô phỏng',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ),

                  // Floating store card + CTA button
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Store card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE4E9E1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/hero_c01.png',
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 54,
                                    height: 54,
                                    color: const Color(0xFFEAF3DD),
                                    child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedBag.storeName,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _selectedBag.title,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 11,
                                        color: const Color(0xFF718076),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
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

                        const SizedBox(height: 10),

                        // Button: Mở vé nhận hàng
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF12543B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // Chuyển về màn hình vé nhận túi
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Mở vé nhận hàng',
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
                ],
              ),
            ),

            // Bottom Navigation Bar
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(0, Icons.home_outlined, 'Khám phá'),
                  _buildBottomNavItem(1, Icons.map_outlined, 'Bản đồ'),
                  _buildBottomNavItem(2, Icons.shopping_bag_outlined, 'Đơn hàng'),
                  _buildBottomNavItem(3, Icons.person_outline, 'Tài khoản'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricePin({required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE6984D) : const Color(0xFF183B2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedBottomNav == index;
    return InkWell(
      onTap: () {
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
        } else if (index == 2) {
          Navigator.pushNamed(context, '/orders-history');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/consumer-profile');
        } else {
          setState(() => _selectedBottomNav = index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ],
      ),
    );
  }
}

class _StylizedMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background fill
    final bgPaint = Paint()..color = const Color(0xFFF1F4EE);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Green parks
    final parkPaint = Paint()..color = const Color(0xFFE0EAD7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(30, 80, 70, 70), const Radius.circular(12)),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(140, 200, 75, 90), const Radius.circular(12)),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(30, 340, 60, 90), const Radius.circular(12)),
      parkPaint,
    );

    // River on the right
    final riverPaint = Paint()
      ..color = const Color(0xFFC0DFE3)
      ..style = PaintingStyle.fill;
    final riverPath = Path()
      ..moveTo(size.width * 0.82, 0)
      ..cubicTo(size.width * 0.70, size.height * 0.35, size.width * 0.88, size.height * 0.7, size.width * 0.72, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(riverPath, riverPaint);

    // Roads (White ribbons)
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    // Diagonal roads
    canvas.drawLine(Offset(0, 100), Offset(size.width * 0.75, 200), roadPaint);
    canvas.drawLine(Offset(size.width * 0.1, 0), Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.45, 0), Offset(size.width * 0.75, size.height), roadPaint);
    canvas.drawLine(Offset(0, 310), Offset(size.width * 0.8, 380), roadPaint);
    canvas.drawLine(Offset(0, 200), Offset(size.width * 0.7, 300), roadPaint);

    // Road text labels
    final textPainter1 = TextPainter(
      text: TextSpan(
        text: 'TRẦN PHÚ',
        style: TextStyle(
          color: const Color(0xFF718076).withValues(alpha: 0.8),
          fontSize: 8,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter1.paint(canvas, const Offset(70, 95));

    final textPainter2 = TextPainter(
      text: TextSpan(
        text: 'NGUYỄN VĂN LINH',
        style: TextStyle(
          color: const Color(0xFF718076).withValues(alpha: 0.8),
          fontSize: 8,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter2.paint(canvas, const Offset(165, 315));

    final textPainter3 = TextPainter(
      text: TextSpan(
        text: 'HẢI CHÂU',
        style: TextStyle(
          color: const Color(0xFF718076).withValues(alpha: 0.8),
          fontSize: 8,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter3.paint(canvas, const Offset(32, 385));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
