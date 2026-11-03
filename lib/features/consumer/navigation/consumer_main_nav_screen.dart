import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/presentation/home_discover_screen.dart';
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
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF12543B),
          unselectedItemColor: const Color(0xFF718076),
          selectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w500),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 22),
              activeIcon: Icon(Icons.home_rounded, size: 22),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, size: 22),
              activeIcon: Icon(Icons.map_rounded, size: 22),
              label: 'Bản đồ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, size: 22),
              activeIcon: Icon(Icons.shopping_bag_rounded, size: 22),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 22),
              activeIcon: Icon(Icons.person_rounded, size: 22),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
