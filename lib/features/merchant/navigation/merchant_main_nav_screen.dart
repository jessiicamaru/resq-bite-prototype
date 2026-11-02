import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../bags/presentation/merchant_bag_list_screen.dart';
import '../dashboard/presentation/merchant_dashboard_screen.dart';
import '../orders/presentation/merchant_orders_pending_screen.dart';
import '../scanner/presentation/merchant_qr_scanner_screen.dart';
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
    MerchantQrScannerScreen(),
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
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
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
          selectedItemColor: AppColors.forestGreen,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w500),
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Tổng quan',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'Túi đồ',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.forestGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
              ),
              label: 'Quét QR',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Đơn hàng',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Cửa hàng',
            ),
          ],
        ),
      ),
    );
  }
}
