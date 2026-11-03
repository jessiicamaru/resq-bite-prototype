import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class OrderQrPickupScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;

  const OrderQrPickupScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
  });

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
          'Vé nhận túi',
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
                    // Badge: SẴN SÀNG NHẬN TÚI
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF2EB),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'SẴN SÀNG NHẬN TÚI',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF12543B),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Một bữa ngon đang đợi.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Đưa mã này cho nhân viên khi bạn đến quầy.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // White Ticket Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'VÉ NHẬN HÀNG',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF12543B),
                              letterSpacing: 0.8,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Custom QR Graphic matching Figma
                          Container(
                            width: 170,
                            height: 170,
                            padding: const EdgeInsets.all(6),
                            child: CustomPaint(
                              painter: _FigmaQrPainter(),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(
                            '#RB-1024',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'QR minh họa · Không quét nhận thực tế',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: const Color(0xFF718076),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: Color(0xFFE4E9E1), height: 1),
                          ),

                          Text(
                            bag.storeName,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '$quantity × ${bag.title}',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              color: const Color(0xFF718076),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE6CF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${bag.pickupWindow} · Hôm nay',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF8F4C17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: Text(
                        'Đặt túi thành công',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA: Xem đường đến cửa hàng
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
                    // BƯỚC TIẾP THEO: Bản đồ đường đến cửa hàng (Image 13)
                    Navigator.pushNamed(
                      context,
                      '/map-explorer',
                    );
                  },
                  child: Text(
                    'Xem đường đến cửa hàng',
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

class _FigmaQrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF183B2E)
      ..style = PaintingStyle.fill;

    const int gridSize = 19;
    final pixelSize = size.width / gridSize;

    // Fixed pattern matching Figma image: 3 large position squares at 3 corners
    void drawPositionSquare(int startX, int startY) {
      // 7x7 outer border
      for (int x = startX; x < startX + 7; x++) {
        for (int y = startY; y < startY + 7; y++) {
          if (x == startX || x == startX + 6 || y == startY || y == startY + 6) {
            canvas.drawRect(
              Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize - 0.5, pixelSize - 0.5),
              paint,
            );
          } else if (x >= startX + 2 && x <= startX + 4 && y >= startY + 2 && y <= startY + 4) {
            canvas.drawRect(
              Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize - 0.5, pixelSize - 0.5),
              paint,
            );
          }
        }
      }
    }

    drawPositionSquare(0, 0); // Top-left
    drawPositionSquare(12, 0); // Top-right
    drawPositionSquare(0, 12); // Bottom-left

    // Decorative middle dots mimicking the prototype
    final extraPoints = [
      [8, 2], [9, 3], [8, 5], [10, 5], [8, 7], [10, 7],
      [2, 8], [3, 9], [5, 8], [6, 9], [8, 9], [9, 9], [11, 9], [13, 9], [15, 9], [17, 9],
      [8, 11], [10, 11], [12, 11], [14, 11], [16, 11],
      [9, 13], [11, 13], [13, 13], [15, 13],
      [8, 15], [10, 15], [12, 15], [14, 15],
      [9, 17], [11, 17], [13, 17], [16, 17],
    ];

    for (final pt in extraPoints) {
      canvas.drawRect(
        Rect.fromLTWH(pt[0] * pixelSize, pt[1] * pixelSize, pixelSize - 0.5, pixelSize - 0.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
