import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/consumer_order.dart';
import '../../../../data/models/food_bag.dart';
import '../../../../data/store/order_store.dart';

class MapExplorerScreen extends StatefulWidget {
  final MysteryBag? initialBag;

  const MapExplorerScreen({super.key, this.initialBag});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  late MysteryBag _selectedBag;

  @override
  void initState() {
    super.initState();
    final activeOrders = OrderStore.instance.orders.where((o) => o.status == OrderStatus.paid).toList();
    if (widget.initialBag != null) {
      _selectedBag = widget.initialBag!;
    } else if (activeOrders.isNotEmpty) {
      _selectedBag = activeOrders.first.bag;
    } else {
      _selectedBag = OrderStore.instance.bags.isNotEmpty ? OrderStore.instance.bags.first : mockMysteryBags.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: OrderStore.instance,
      builder: (context, _) {
        final store = OrderStore.instance;
        final activeOrders = store.orders.where((o) => o.status == OrderStatus.paid).toList();
        final activeOrderForSelected = activeOrders
            .where((o) => o.bag.id == _selectedBag.id || o.bag.storeName == _selectedBag.storeName)
            .firstOrNull;
        final hasActiveOrder = activeOrderForSelected != null;
        final currencyFormat = NumberFormat('#,###', 'vi_VN');

        final pageTitle = hasActiveOrder
            ? (_selectedBag.storeName.contains('Mây') ? 'Đường đến Mây' : 'Đường đến ${_selectedBag.storeName}')
            : 'Bản đồ quán quanh bạn';

        final bagsList = store.bags.isNotEmpty ? store.bags : mockMysteryBags;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Topbar: < Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      if (Navigator.canPop(context)) ...[
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
                      ],
                      Text(
                        pageTitle,
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
                      // Pin 1: Trần Phú - Tiệm Bánh Mây (35k)
                      if (bagsList.isNotEmpty)
                        Positioned(
                          top: 140,
                          left: 70,
                          child: _buildPricePin(
                            label: '${(bagsList[0].rescuePrice / 1000).round()}k',
                            isActive: _selectedBag.id == bagsList[0].id,
                            onTap: () => setState(() => _selectedBag = bagsList[0]),
                          ),
                        ),

                      // Pin 2: 25k
                      if (bagsList.length > 1)
                        Positioned(
                          top: 100,
                          right: 80,
                          child: _buildPricePin(
                            label: '${(bagsList[1].rescuePrice / 1000).round()}k',
                            isActive: _selectedBag.id == bagsList[1].id,
                            onTap: () => setState(() => _selectedBag = bagsList[1]),
                          ),
                        ),

                      // Pin 3: 39k
                      if (bagsList.length > 2)
                        Positioned(
                          top: 280,
                          right: 120,
                          child: _buildPricePin(
                            label: '${(bagsList[2].rescuePrice / 1000).round()}k',
                            isActive: _selectedBag.id == bagsList[2].id,
                            onTap: () => setState(() => _selectedBag = bagsList[2]),
                          ),
                        ),

                      // Pin 4: 32k
                      if (bagsList.length > 3)
                        Positioned(
                          top: 360,
                          left: 45,
                          child: _buildPricePin(
                            label: '${(bagsList[3].rescuePrice / 1000).round()}k',
                            isActive: _selectedBag.id == bagsList[3].id,
                            onTap: () => setState(() => _selectedBag = bagsList[3]),
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
                                      _selectedBag.imageUrl,
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
                                          '${currencyFormat.format(_selectedBag.rescuePrice)}đ',
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
                                      color: hasActiveOrder ? const Color(0xFFEBF2EB) : const Color(0xFFF6F8F5),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      hasActiveOrder ? 'Đã đặt' : 'Còn ${_selectedBag.remainingBags} túi',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: hasActiveOrder ? const Color(0xFF12543B) : const Color(0xFF718076),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // CTA Button
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
                                  if (hasActiveOrder) {
                                    // If active order exists, open pick-up QR
                                    Navigator.pushNamed(
                                      context,
                                      '/order-qr',
                                      arguments: {
                                        'bag': activeOrderForSelected.bag,
                                        'quantity': activeOrderForSelected.quantity,
                                      },
                                    );
                                  } else {
                                    // Navigate to bag detail to start rescue flow
                                    Navigator.pushNamed(
                                      context,
                                      '/bag-detail',
                                      arguments: _selectedBag,
                                    );
                                  }
                                },
                                child: Text(
                                  hasActiveOrder ? 'Mở vé nhận hàng' : 'Xem chi tiết túi',
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
              ],
            ),
          ),
        );
      },
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
