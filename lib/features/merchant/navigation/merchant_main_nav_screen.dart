import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bags/presentation/merchant_bag_list_screen.dart';
import '../dashboard/presentation/merchant_dashboard_screen.dart';
import '../orders/presentation/merchant_orders_pending_screen.dart';
import '../settings/presentation/merchant_store_settings_screen.dart';

class MerchantMainNavScreen extends StatefulWidget {
  final int initialIndex;

  const MerchantMainNavScreen({super.key, this.initialIndex = 0});

  @override
  State<MerchantMainNavScreen> createState() => _MerchantMainNavScreenState();
}

class _MerchantMainNavScreenState extends State<MerchantMainNavScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    MerchantDashboardScreen(),
    MerchantBagListScreen(),
    MerchantOrdersPendingScreen(),
    MerchantStoreSettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF12543B),
          unselectedItemColor: const Color(0xFF718076),
          selectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w500),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined, size: 22),
              activeIcon: Icon(Icons.dashboard_rounded, size: 22),
              label: 'Tổng quan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, size: 22),
              activeIcon: Icon(Icons.shopping_bag_rounded, size: 22),
              label: 'Túi đồ ăn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined, size: 22),
              activeIcon: Icon(Icons.receipt_long_rounded, size: 22),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined, size: 22),
              activeIcon: Icon(Icons.storefront_rounded, size: 22),
              label: 'Cửa hàng',
            ),
          ],
        ),
      ),
    );
  }
}
