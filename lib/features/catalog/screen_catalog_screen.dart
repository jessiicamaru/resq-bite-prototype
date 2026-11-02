import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock/mock_data.dart';

class ScreenCatalogScreen extends StatefulWidget {
  const ScreenCatalogScreen({super.key});

  @override
  State<ScreenCatalogScreen> createState() => _ScreenCatalogScreenState();
}

class _ScreenCatalogScreenState extends State<ScreenCatalogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _consumerScreens = [
    // Onboarding & Xác thực (8 màn)
    {
      'code': 'C01',
      'title': 'Splash Screen',
      'desc': 'Khởi động ứng dụng, định vị thương hiệu ResQ Bites & liên kết SDG 2 & 12',
      'route': '/splash',
      'icon': Icons.flash_on_rounded,
      'group': 'Onboarding & Xác thực',
    },
    {
      'code': 'C02–C04',
      'title': 'Onboarding Flow (3 Slides)',
      'desc': 'Bữa ngon giá nhẹ, Mô hình Túi bí mật (Mystery Bag), Khung giờ đón QR',
      'route': '/onboarding',
      'icon': Icons.view_carousel_rounded,
      'group': 'Onboarding & Xác thực',
    },
    {
      'code': 'C05',
      'title': 'Login Screen',
      'desc': 'Đăng nhập tài khoản người dùng, ghi nhớ đăng nhập & social login',
      'route': '/login',
      'icon': Icons.login_rounded,
      'group': 'Onboarding & Xác thực',
    },
    {
      'code': 'C06',
      'title': 'Register Screen',
      'desc': 'Đăng ký tài khoản người tiêu dùng bền vững',
      'route': '/register',
      'icon': Icons.person_add_alt_1_rounded,
      'group': 'Onboarding & Xác thực',
    },
    {
      'code': 'C07',
      'title': 'Forgot Password Screen',
      'desc': 'Khôi phục mật khẩu tài khoản qua email đã đăng ký',
      'route': '/forgot-password',
      'icon': Icons.lock_reset_rounded,
      'group': 'Onboarding & Xác thực',
    },
    {
      'code': 'C08',
      'title': 'OTP Verification Screen',
      'desc': 'Xác thực OTP 6 số với đồng hồ đếm ngược gửi lại',
      'route': '/verify-otp',
      'icon': Icons.pin_rounded,
      'group': 'Onboarding & Xác thực',
    },

    // Khám phá & Bản đồ (12 màn)
    {
      'code': 'C09',
      'title': 'Home Discover Screen',
      'desc': 'Trang chủ khám phá: Định vị Đà Nẵng, danh mục ẩm thực, túi cứu trợ quanh bạn',
      'route': '/home',
      'icon': Icons.explore_rounded,
      'group': 'Khám phá & Bản đồ',
    },
    {
      'code': 'C13',
      'title': 'Map Explorer Screen',
      'desc': 'Bản đồ trực quan bán kính 1km – 5km quanh Hải Châu, ghim các cửa hàng',
      'route': '/map-explorer',
      'icon': Icons.map_rounded,
      'group': 'Khám phá & Bản đồ',
    },
    {
      'code': 'C17/C18',
      'title': 'Search Results Screen',
      'desc': 'Tìm kiếm thời gian thực theo từ khóa "bánh", gợi ý danh mục và trạng thái trống',
      'route': '/search-results',
      'icon': Icons.search_rounded,
      'group': 'Khám phá & Bản đồ',
    },
    {
      'code': 'C10',
      'title': 'Category Detail: Bánh Mì & Bánh Ngọt',
      'desc': 'Lọc túi cứu trợ theo danh mục bánh: Bộ lọc 3km, dưới 50k, còn hàng',
      'route': '/category-detail',
      'icon': Icons.bakery_dining_rounded,
      'group': 'Khám phá & Bản đồ',
    },

    // Chi tiết cửa hàng & Túi đồ ăn (10 màn)
    {
      'code': 'C21',
      'title': 'Store Detail: Tiệm Bánh Mây',
      'desc': 'Hồ sơ quán: Giờ mở cửa, địa chỉ, cam kết ATVSTP, các túi đang bán',
      'route': '/store-detail',
      'icon': Icons.storefront_rounded,
      'group': 'Chi tiết quán & Túi đồ',
    },
    {
      'code': 'C23',
      'title': 'Store Reviews Screen',
      'desc': 'Khách nói gì về quán: Đánh giá 4.8★, nhận xét thực tế về độ tươi ngon',
      'route': '/store-reviews',
      'icon': Icons.rate_review_rounded,
      'group': 'Chi tiết quán & Túi đồ',
    },
    {
      'code': 'C25/C26',
      'title': 'Mystery Bag Detail Screen',
      'desc': 'Chi tiết Túi Bí Mật: Khung giờ 20:00–21:30, đếm ngược, lưu ý dị ứng, giảm 65%',
      'route': '/bag-detail',
      'icon': Icons.card_giftcard_rounded,
      'group': 'Chi tiết quán & Túi đồ',
    },
    {
      'code': 'C29',
      'title': 'Sold Out Bag Screen',
      'desc': 'Trạng thái hết hàng hôm nay: Đăng ký nhận thông báo đợt mở bán ngày mai',
      'route': '/sold-out-bag',
      'icon': Icons.remove_shopping_cart_outlined,
      'group': 'Chi tiết quán & Túi đồ',
    },

    // Đặt hàng & Thanh toán (8 màn)
    {
      'code': 'C59',
      'title': 'Delivery vs Pickup Mode Screen',
      'desc': 'Chọn phương thức nhận: Tự đến lấy tại quầy (Pick-up) hoặc Giao tận nơi (Green Eco)',
      'route': '/delivery-mode',
      'icon': Icons.delivery_dining_outlined,
      'group': 'Đặt hàng & Thanh toán',
    },
    {
      'code': 'C31/C34',
      'title': 'Cart & Checkout Screen',
      'desc': 'Xác nhận đặt túi: Khung giờ đến nhận, ghi chú dị ứng cho quán, bảng kê chi phí',
      'route': '/cart-checkout',
      'icon': Icons.shopping_cart_checkout_rounded,
      'group': 'Đặt hàng & Thanh toán',
    },
    {
      'code': 'C32',
      'title': 'Payment Methods Screen',
      'desc': 'Chọn phương thức: Ví MoMo, ZaloPay, Thẻ Napas/Visa, Điểm Thưởng Xanh',
      'route': '/payment-methods',
      'icon': Icons.account_balance_wallet_rounded,
      'group': 'Đặt hàng & Thanh toán',
    },
    {
      'code': 'C37',
      'title': 'Payment Success Screen',
      'desc': 'Thanh toán thành công: Tác động xanh tức thì (+2.4 kg CO₂), mở vé nhận hàng',
      'route': '/payment-success',
      'icon': Icons.check_circle_rounded,
      'group': 'Đặt hàng & Thanh toán',
    },
    {
      'code': 'C38',
      'title': 'Pick-up QR Code Screen',
      'desc': 'Vé điện tử kèm mã QR lấy hàng trực tiếp tại quầy trong 5–10 giây',
      'route': '/order-qr',
      'icon': Icons.qr_code_2_rounded,
      'group': 'Đặt hàng & Thanh toán',
    },

    // Quản lý đơn hàng & Lịch sử (7 màn)
    {
      'code': 'C39/C57/C58',
      'title': 'Orders History Screen',
      'desc': 'Quản lý đơn hàng 3 tab: Chờ lấy, Đã hoàn tất, Đã hủy',
      'route': '/orders-history',
      'icon': Icons.receipt_long_rounded,
      'group': 'Quản lý Đơn hàng',
    },
    {
      'code': 'C44',
      'title': 'Order Receipt Screen',
      'desc': 'Biên nhận điện tử chi tiết mã đơn, thời gian thanh toán, cửa hàng',
      'route': '/order-receipt',
      'icon': Icons.receipt_outlined,
      'group': 'Quản lý Đơn hàng',
    },
    {
      'code': 'C42/C73',
      'title': 'Cancel Order & Refund Screen',
      'desc': 'Yêu cầu hủy đơn: Chọn lý do và xem tiến trình hoàn tiền về Ví MoMo',
      'route': '/cancel-order',
      'icon': Icons.cancel_presentation_outlined,
      'group': 'Quản lý Đơn hàng',
    },
    {
      'code': 'C45',
      'title': 'Order Review Screen',
      'desc': 'Đánh giá sau khi nhận túi: Chấm sao, nhận xét độ tươi ngon, nhận điểm xanh',
      'route': '/order-review',
      'icon': Icons.stars_rounded,
      'group': 'Quản lý Đơn hàng',
    },

    // Hồ sơ cá nhân & Impact (10 màn)
    {
      'code': 'C50',
      'title': 'Green Impact Dashboard',
      'desc': 'Dấu chân xanh: Tiết kiệm 780k, cứu 12 bữa, giảm 28.5 kg CO₂ (SDG 12 & 2)',
      'route': '/green-impact',
      'icon': Icons.eco_rounded,
      'group': 'Hồ sơ & Tác động xanh',
    },
    {
      'code': 'C46',
      'title': 'Consumer Profile Screen',
      'desc': 'Hồ sơ Thanh Hậu: Địa chỉ đã lưu, ví tiền, trung tâm trợ giúp & chuyển sang Merchant',
      'route': '/consumer-profile',
      'icon': Icons.person_rounded,
      'group': 'Hồ sơ & Tác động xanh',
    },
    {
      'code': 'C48',
      'title': 'Saved Addresses Screen',
      'desc': 'Địa điểm đã lưu: Nhà, trường học, văn phòng & thanh trượt bán kính ưu tiên',
      'route': '/saved-addresses',
      'icon': Icons.place_outlined,
      'group': 'Hồ sơ & Tác động xanh',
    },
    {
      'code': 'C52',
      'title': 'Notifications Screen',
      'desc': 'Thông báo khung giờ vàng mở bán túi & trạng thái đơn hàng thời gian thực',
      'route': '/notifications',
      'icon': Icons.notifications_none_rounded,
      'group': 'Hồ sơ & Tác động xanh',
    },
    {
      'code': 'C53',
      'title': 'Help Center & FAQ Screen',
      'desc': 'Trung tâm trợ giúp: Câu hỏi thường gặp về Túi bí mật, khung giờ & hoàn tiền',
      'route': '/help-center',
      'icon': Icons.help_outline_rounded,
      'group': 'Hồ sơ & Tác động xanh',
    },
    {
      'code': 'C54/C55',
      'title': 'Support Request Screen',
      'desc': 'Gửi phiếu hỗ trợ: Nhập mã đơn RB-1024, đính kèm ảnh và gửi yêu cầu',
      'route': '/support-request',
      'icon': Icons.support_agent_rounded,
      'group': 'Hồ sơ & Tác động xanh',
    },
  ];

  final List<Map<String, dynamic>> _merchantScreens = [
    // Đăng ký & Onboarding đối tác (6 màn)
    {
      'code': 'M01',
      'title': 'Merchant Onboarding Screen',
      'desc': 'Cùng cứu những bữa ngon: Tối ưu chi phí thực phẩm, bảo vệ giá trị thương hiệu',
      'route': '/merchant-onboarding',
      'icon': Icons.handshake_outlined,
      'group': 'Đăng ký & Onboarding',
    },
    {
      'code': 'M02',
      'title': 'Merchant Register Screen',
      'desc': 'Đăng ký gian hàng: Nhập tên quán, địa chỉ, danh mục món & chứng nhận ATVSTP',
      'route': '/merchant-register',
      'icon': Icons.app_registration_rounded,
      'group': 'Đăng ký & Onboarding',
    },
    {
      'code': 'M04/M06',
      'title': 'Merchant Verification Screen',
      'desc': 'Hồ sơ đang được xem xét: Theo dõi tiến độ kiểm duyệt ATVSTP',
      'route': '/merchant-verification',
      'icon': Icons.hourglass_empty_rounded,
      'group': 'Đăng ký & Onboarding',
    },

    // Dashboard vận hành (6 màn)
    {
      'code': 'M07/M10',
      'title': 'Merchant Main Dashboard',
      'desc': 'Tổng quan hôm nay: 18 túi đã bán, 630k doanh thu, 42.8kg CO₂, việc cần làm tối nay',
      'route': '/merchant-home',
      'icon': Icons.dashboard_customize_outlined,
      'group': 'Dashboard Vận hành',
    },

    // Quản lý Túi đồ ăn (10 màn)
    {
      'code': 'M13/M20',
      'title': 'Merchant Bag List Screen',
      'desc': 'Túi đang mở bán: 2 loại túi, 6 túi còn sẵn sàng, bật/tắt công tắc bán',
      'route': '/merchant-bags',
      'icon': Icons.inventory_2_outlined,
      'group': 'Quản lý Túi đồ ăn',
    },
    {
      'code': 'M14/M15',
      'title': 'Merchant Create Bag Screen',
      'desc': 'Tạo túi mới & Giá giải cứu: Đặt giá gốc 100k -> Giá cứu 35k (-65%), dị ứng',
      'route': '/merchant-create-bag',
      'icon': Icons.add_box_outlined,
      'group': 'Quản lý Túi đồ ăn',
    },
    {
      'code': 'M16/M17',
      'title': 'Merchant Pickup Window Screen',
      'desc': 'Khung giờ nhận hàng: 20:00 – 21:30, cài đặt số túi sẵn sàng, lặp lại hàng ngày',
      'route': '/merchant-pickup-window',
      'icon': Icons.timer_outlined,
      'group': 'Quản lý Túi đồ ăn',
    },

    // Xác nhận đơn & Quét QR (8 màn)
    {
      'code': 'M25/M29',
      'title': 'Merchant QR Scanner Screen',
      'desc': 'Camera quét mã nhận túi: Khung ngắm laser, nút flash, chế độ thử nhanh prototype',
      'route': '/merchant-scanner',
      'icon': Icons.qr_code_scanner,
      'group': 'Xác nhận đơn & Quét QR',
    },
    {
      'code': 'M26/M27',
      'title': 'Merchant QR Verification Screen',
      'desc': 'Đối chiếu mã hợp lệ: Kiểm tra thông tin khách Thanh Hậu, xác nhận trao túi',
      'route': '/merchant-qr-valid',
      'icon': Icons.verified_user_outlined,
      'group': 'Xác nhận đơn & Quét QR',
    },
    {
      'code': 'M23/M30',
      'title': 'Merchant Orders Pending & Handover',
      'desc': 'Danh sách đơn chờ lấy tại quầy và các túi đã trao tay thành công',
      'route': '/merchant-orders-pending',
      'icon': Icons.pending_actions_outlined,
      'group': 'Xác nhận đơn & Quét QR',
    },

    // Báo cáo & Cài đặt gian hàng (15 màn)
    {
      'code': 'M31/M32/M33',
      'title': 'Merchant Revenue Report Screen',
      'desc': 'Doanh thu tuần & Tháng 10 của Mây: 4.410.000đ, biểu đồ ngày, đối soát Vietcombank',
      'route': '/merchant-revenue',
      'icon': Icons.query_stats_outlined,
      'group': 'Báo cáo & Cài đặt',
    },
    {
      'code': 'M34',
      'title': 'Merchant Food Waste & Green Report',
      'desc': 'Báo cáo giảm rác thải: 540 túi cứu, 1.285kg CO₂, chứng nhận đối tác SDG 12',
      'route': '/merchant-food-waste',
      'icon': Icons.park_outlined,
      'group': 'Báo cáo & Cài đặt',
    },
    {
      'code': 'M37/M38/M39',
      'title': 'Merchant Store Settings Screen',
      'desc': 'Hồ sơ Tiệm Bánh Mây: Giờ hoạt động 07:00–22:00, điểm nhận túi, phân quyền',
      'route': '/merchant-store-settings',
      'icon': Icons.storefront_outlined,
      'group': 'Báo cáo & Cài đặt',
    },
    {
      'code': 'M40/M41',
      'title': 'Merchant Bank Account Settings',
      'desc': 'Tài khoản nhận tiền: Vietcombank ···6789 (NGUYEN MAI ANH), chu kỳ chuyển tiền',
      'route': '/merchant-bank-settings',
      'icon': Icons.account_balance_outlined,
      'group': 'Báo cáo & Cài đặt',
    },
    {
      'code': 'M44',
      'title': 'Merchant Staff Management Screen',
      'desc': 'Nhân sự cửa hàng: 3 nhân viên có quyền quét mã QR trao túi ca tối',
      'route': '/merchant-staff',
      'icon': Icons.badge_outlined,
      'group': 'Báo cáo & Cài đặt',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Danh Mục Màn Hình Prototype',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.forestGreen,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: AppColors.forestGreen,
          labelStyle: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: [
            Tab(text: 'Consumer App (${_consumerScreens.length} Màn)'),
            Tab(text: 'Merchant Portal (${_merchantScreens.length} Màn)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScreenList(_consumerScreens, isConsumer: true),
          _buildScreenList(_merchantScreens, isConsumer: false),
        ],
      ),
    );
  }

  Widget _buildScreenList(List<Map<String, dynamic>> screenList, {required bool isConsumer}) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Summary Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isConsumer ? AppColors.forestGreen.withValues(alpha: 0.08) : const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isConsumer ? AppColors.forestGreen.withValues(alpha: 0.2) : const Color(0xFFFDE68A),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isConsumer ? Icons.person_pin_circle_rounded : Icons.store_mall_directory_rounded,
                color: isConsumer ? AppColors.forestGreen : const Color(0xFF92400E),
                size: 28,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConsumer ? 'PHÂN HỆ NGƯỜI TIÊU DÙNG (CONSUMER FLOW)' : 'PHÂN HỆ ĐỐI TÁC CỬA HÀNG (MERCHANT FLOW)',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isConsumer ? AppColors.forestGreen : const Color(0xFF92400E),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${screenList.length} Màn hình hoàn chỉnh · Nhấn vào bất kỳ mục nào để mở trải nghiệm trực tiếp.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: isConsumer ? AppColors.charcoal : const Color(0xFF78350F),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Screen Cards
        ...screenList.map((screen) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () {
                final route = screen['route'] as String;
                if (route == '/order-receipt') {
                  Navigator.pushNamed(
                    context,
                    route,
                    arguments: {
                      'bag': mockMysteryBags.first,
                      'quantity': 1,
                      'orderCode': 'RESQ-8942-DN',
                    },
                  );
                } else {
                  Navigator.pushNamed(context, route);
                }
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isConsumer ? AppColors.forestGreen.withValues(alpha: 0.1) : const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  screen['icon'] as IconData,
                  color: isConsumer ? AppColors.forestGreen : const Color(0xFFB45309),
                  size: 22,
                ),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      screen['code'] as String,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      screen['title'] as String,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      screen['desc'] as String,
                      style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade600, height: 1.3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nhóm: ${screen['group']}',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isConsumer ? AppColors.forestGreen : const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ),
          );
        }),
      ],
    );
  }
}
