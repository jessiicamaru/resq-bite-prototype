import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock/mock_data.dart';

class ScreenCatalogScreen extends StatelessWidget {
  const ScreenCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      // Auth & Onboarding
      {
        'title': '1. Splash Screen',
        'desc': 'Giới thiệu ResQ Bites, định hướng SDG 2 & 12, nút Bắt đầu',
        'route': '/splash',
        'icon': Icons.flash_on_rounded,
        'tag': 'Onboarding & Auth',
      },
      {
        'title': '2. Onboarding Flow (3 Slides)',
        'desc': 'Bữa ngon giá nhẹ, Túi bí mật (Mystery Bag), Giờ đón hàng QR',
        'route': '/onboarding',
        'icon': Icons.view_carousel_rounded,
        'tag': 'Onboarding & Auth',
      },
      {
        'title': '3. Login Screen',
        'desc': 'Đăng nhập tài khoản người tiêu dùng, ghi nhớ đăng nhập, social login',
        'route': '/login',
        'icon': Icons.login_rounded,
        'tag': 'Onboarding & Auth',
      },
      {
        'title': '4. Register Screen',
        'desc': 'Tạo tài khoản mới, cam kết chống lãng phí thực phẩm',
        'route': '/register',
        'icon': Icons.person_add_alt_1_rounded,
        'tag': 'Onboarding & Auth',
      },
      {
        'title': '5. Forgot Password Screen',
        'desc': 'Khôi phục mật khẩu qua email đã đăng ký',
        'route': '/forgot-password',
        'icon': Icons.lock_reset_rounded,
        'tag': 'Onboarding & Auth',
      },
      {
        'title': '6. OTP Verification Screen',
        'desc': 'Xác thực mã OTP 6 số bảo mật với đếm ngược 45s',
        'route': '/verify-otp',
        'icon': Icons.pin_rounded,
        'tag': 'Onboarding & Auth',
      },

      // Khám phá & Bản đồ
      {
        'title': '7. Home Discover Screen',
        'desc': 'Trang chủ khám phá: Định vị Đà Nẵng, tìm kiếm, banner SDGs, danh mục, túi giải cứu',
        'route': '/home',
        'icon': Icons.explore_rounded,
        'tag': 'Khám phá & Bản đồ',
      },
      {
        'title': '8. Map Explorer Screen',
        'desc': 'Bản đồ trực quan bán kính 1km – 5km quanh Hải Châu, ghim các cửa hàng',
        'route': '/map-explorer',
        'icon': Icons.map_rounded,
        'tag': 'Khám phá & Bản đồ',
      },
      {
        'title': '9. Search Results Screen',
        'desc': 'Tìm kiếm thời gian thực theo tên món, tiệm bánh kèm gợi ý từ khóa',
        'route': '/search-results',
        'icon': Icons.search_rounded,
        'tag': 'Khám phá & Bản đồ',
      },
      {
        'title': '10. Category Detail Screen',
        'desc': 'Danh mục "Thơm một góc bánh": Bộ lọc 3km, dưới 50k, danh sách túi',
        'route': '/category-detail',
        'icon': Icons.bakery_dining_rounded,
        'tag': 'Khám phá & Bản đồ',
      },

      // Chi tiết quán & Túi đồ ăn
      {
        'title': '11. Mystery Bag Detail Screen',
        'desc': 'Chi tiết Túi Bí Mật: Khung giờ 20:00–21:30, đếm ngược, lưu ý dị ứng, giảm 65%',
        'route': '/bag-detail',
        'icon': Icons.card_giftcard_rounded,
        'tag': 'Chi tiết Túi đồ ăn',
      },
      {
        'title': '12. Store Detail Screen',
        'desc': 'Hồ sơ Tiệm Bánh Mây: Giờ mở cửa, địa chỉ, cam kết vệ sinh, các túi mở bán',
        'route': '/store-detail',
        'icon': Icons.storefront_rounded,
        'tag': 'Chi tiết Cửa hàng',
      },
      {
        'title': '13. Store Reviews Screen',
        'desc': 'Khách nói gì về quán: Đánh giá 4.8★, nhận xét thực tế về độ tươi ngon',
        'route': '/store-reviews',
        'icon': Icons.rate_review_rounded,
        'tag': 'Chi tiết Cửa hàng',
      },

      // Đặt hàng & Thanh toán
      {
        'title': '14. Cart & Checkout Screen',
        'desc': 'Xác nhận đặt túi: Khung giờ đến nhận, ghi chú dị ứng, bảng kê chi phí',
        'route': '/cart-checkout',
        'icon': Icons.shopping_cart_checkout_rounded,
        'tag': 'Đặt hàng & Thanh toán',
      },
      {
        'title': '15. Payment Methods Screen',
        'desc': 'Chọn phương thức: Ví MoMo, ZaloPay, Thẻ Napas/Visa, Điểm Thưởng Xanh',
        'route': '/payment-methods',
        'icon': Icons.account_balance_wallet_rounded,
        'tag': 'Đặt hàng & Thanh toán',
      },
      {
        'title': '16. Payment Success Screen',
        'desc': 'Thanh toán thành công: Tác động xanh tức thì (+2.4 kg CO₂), mở vé lấy hàng',
        'route': '/payment-success',
        'icon': Icons.check_circle_rounded,
        'tag': 'Đặt hàng & Thanh toán',
      },
      {
        'title': '17. Pick-up QR Code Screen',
        'desc': 'Vé điện tử kèm mã QR lấy hàng trực tiếp tại quầy trong 5–10 giây',
        'route': '/order-qr',
        'icon': Icons.qr_code_2_rounded,
        'tag': 'Đặt hàng & Thanh toán',
      },

      // Quản lý đơn hàng & Lịch sử
      {
        'title': '18. Orders History Screen',
        'desc': 'Quản lý đơn hàng 3 tab: Chờ lấy, Đã hoàn tất, Đã hủy',
        'route': '/orders-history',
        'icon': Icons.receipt_long_rounded,
        'tag': 'Quản lý Đơn hàng',
      },
      {
        'title': '19. Order Review Screen',
        'desc': 'Đánh giá sau khi nhận túi: Chấm sao, chọn tag "Tươi ngon, tiết kiệm", nhận điểm xanh',
        'route': '/order-review',
        'icon': Icons.stars_rounded,
        'tag': 'Quản lý Đơn hàng',
      },

      // Hồ sơ & Tác động xanh
      {
        'title': '20. Green Impact Dashboard',
        'desc': 'Bảng thành tích xanh: Tiết kiệm 780k, cứu 12 bữa, giảm 28.5 kg CO₂ (SDG 12)',
        'route': '/green-impact',
        'icon': Icons.eco_rounded,
        'tag': 'Hồ sơ & Impact',
      },
      {
        'title': '21. Consumer Profile Screen',
        'desc': 'Hồ sơ Thanh Hậu: Địa chỉ, phương thức đã lưu, cài đặt & đăng xuất',
        'route': '/consumer-profile',
        'icon': Icons.person_rounded,
        'tag': 'Hồ sơ & Impact',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Danh Mục 21 Màn Hình Prototype'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified_rounded, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'ResQ Bites · 21 Màn Hình Chuẩn Flow',
                      style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Chọn bất kỳ màn hình nào dưới đây để kiểm tra trực tiếp hoặc bấm nút bên dưới để trải nghiệm luồng hoàn chỉnh từ đầu.',
                  style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/splash'),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Chạy toàn bộ luồng từ Splash Screen'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          ...screens.map((s) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: AppColors.border),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(s['icon'] as IconData, color: AppColors.primary),
                ),
                title: Text(
                  s['title'] as String,
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      s['desc'] as String,
                      style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        s['tag'] as String,
                        style: GoogleFonts.beVietnamPro(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                onTap: () {
                  final route = s['route'] as String;
                  if (route == '/bag-detail' || route == '/store-detail' || route == '/store-reviews' || route == '/order-review') {
                    Navigator.pushNamed(context, route, arguments: mockMysteryBags.first);
                  } else if (route == '/cart-checkout') {
                    Navigator.pushNamed(context, route, arguments: {
                      'bag': mockMysteryBags.first,
                      'quantity': 1,
                    });
                  } else if (route == '/payment-success' || route == '/order-qr') {
                    Navigator.pushNamed(context, route, arguments: {
                      'bag': mockMysteryBags.first,
                      'quantity': 1,
                      'payment': 'Ví MoMo',
                    });
                  } else {
                    Navigator.pushNamed(context, route);
                  }
                },
              ),
            );
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
