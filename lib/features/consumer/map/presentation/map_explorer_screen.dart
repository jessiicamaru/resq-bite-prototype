import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/food_bag.dart';

class MapExplorerScreen extends StatefulWidget {
  const MapExplorerScreen({super.key});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  final currencyFormat = NumberFormat('#,###', 'vi_VN');
  MysteryBag _selectedBag = mockMysteryBags.first;
  String _selectedRadius = '3 km';

  final List<String> _radiusOptions = ['1 km', '3 km', '5 km', 'Tất cả'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Map Background Simulation (Interactive styled vector map layout)
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE8ECE9),
              child: CustomPaint(
                painter: _MapCanvasPainter(),
              ),
            ),
          ),

          // Interactive Store Pins on Map
          Positioned(
            top: 240,
            left: 90,
            child: _buildStorePin(mockMysteryBags[0], 'Tiệm Bánh Mây (0.8km)'),
          ),
          Positioned(
            top: 310,
            right: 80,
            child: _buildStorePin(mockMysteryBags[1], 'Bếp Nhà (1.2km)'),
          ),
          Positioned(
            top: 420,
            left: 140,
            child: _buildStorePin(mockMysteryBags[2], 'Fresh Corner (0.6km)'),
          ),
          Positioned(
            top: 180,
            right: 120,
            child: _buildStorePin(mockMysteryBags[3], 'Green Bowl (1.6km)'),
          ),

          // User Location Pulse Indicator
          Positioned(
            top: 320,
            left: 180,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Bạn ở đây',
                    style: GoogleFonts.beVietnamPro(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Top Floating Search & Filter Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            'Bản Đồ Giải Cứu (Hải Châu, Đà Nẵng)',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.my_location_rounded, color: AppColors.primary),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đang định vị vị trí hiện tại của bạn...')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Radius Filter Pills
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _radiusOptions.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final radius = _radiusOptions[index];
                        final isSelected = radius == _selectedRadius;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedRadius = radius),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Bán kính $radius',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Floating Selected Store Card
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: _buildBottomSelectedCard(context, _selectedBag),
          ),
        ],
      ),
    );
  }

  Widget _buildStorePin(MysteryBag bag, String label) {
    final isSelected = bag.id == _selectedBag.id;
    return GestureDetector(
      onTap: () => setState(() => _selectedBag = bag),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_bag_rounded,
                  size: 13,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
            color: isSelected ? AppColors.primary : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSelectedCard(BuildContext context, MysteryBag bag) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              bag.imageUrl,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Còn ${bag.remainingBags} túi',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      bag.pickupCountdown,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  bag.storeName,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${bag.title} · ${bag.distanceKm} km',
                  style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${currencyFormat.format(bag.rescuePrice)}đ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${currencyFormat.format(bag.originalPrice)}đ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/bag-detail', arguments: bag),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Chi tiết',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final secondaryRoadPaint = Paint()
      ..color = const Color(0xFFF0F2EE)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final waterPaint = Paint()
      ..color = const Color(0xFFCCE4ED)
      ..style = PaintingStyle.fill;

    // Draw Sông Hàn River curve on the right
    final riverPath = Path()
      ..moveTo(size.width * 0.85, 0)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.5, size.width * 0.9, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(riverPath, waterPaint);

    // Roads
    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.35), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.65), Offset(size.width, size.height * 0.65), roadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.6, 0), Offset(size.width * 0.6, size.height), roadPaint);

    // Secondary diagonal roads
    canvas.drawLine(Offset(0, 0), Offset(size.width * 0.8, size.height), secondaryRoadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(0, size.height * 0.8), secondaryRoadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

