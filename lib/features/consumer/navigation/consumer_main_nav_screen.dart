import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../home/presentation/home_discover_screen.dart';
import '../impact/presentation/green_impact_screen.dart';
import '../map/presentation/map_explorer_screen.dart';
import '../orders/presentation/orders_history_screen.dart';
import '../profile/presentation/consumer_profile_screen.dart';

class ConsumerMainNavScreen extends StatefulWidget {
  final int initialIndex;
  const ConsumerMainNavScreen({super.key, this.initialIndex = 0});

  @override
  State<ConsumerMainNavScreen> createState() => _ConsumerMainNavScreenState();
}

class _ConsumerMainNavScreenState extends State<ConsumerMainNavScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _tabs = [
    const HomeDiscoverScreen(),
    const MapExplorerScreen(),
    const OrdersHistoryScreen(),
    const GreenImpactScreen(),
    const ConsumerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w500),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore_rounded),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map_rounded),
              label: 'Bản đồ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long_rounded),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco_outlined),
              activeIcon: Icon(Icons.eco_rounded),
              label: 'Thành tích',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Hồ sơ',
            ),
          ],
        ),
      ),
    );
  }
}
