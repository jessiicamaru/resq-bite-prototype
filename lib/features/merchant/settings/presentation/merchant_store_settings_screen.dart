import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantStoreSettingsScreen extends StatelessWidget {
  const MerchantStoreSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Hồ sơ Tiệm Bánh Mây',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE4E9E1)),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.more_horiz_rounded, size: 20, color: Color(0xFF183B2E)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Header Image
              SizedBox(
                width: double.infinity,
                height: 160,
                child: Image.asset(
                  'assets/images/story_may.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFEAF3DD),
                    alignment: Alignment.center,
                    child: const Icon(Icons.storefront_rounded, size: 48, color: Color(0xFF12543B)),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store Title & Verified Badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tiệm Bánh Mây',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3DD),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Đã xác minh đối tác',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF12543B),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Section: Thông tin & vận hành
                    Text(
                      'Thông tin & vận hành',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          _buildMenuRow(
                            icon: Icons.storefront_outlined,
                            title: 'Hồ sơ cửa hàng',
                            subtitle: 'Tên, mô tả và liên hệ',
                            onTap: () {},
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.schedule_outlined,
                            title: 'Giờ hoạt động',
                            subtitle: '07:00–22:00',
                            onTap: () {},
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.location_on_outlined,
                            title: 'Điểm nhận hàng',
                            subtitle: '12 Trần Phú, Hải Châu',
                            onTap: () {},
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.calendar_today_outlined,
                            title: 'Lịch mở bán',
                            subtitle: 'Thứ Hai – Thứ Bảy',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Section: Tài chính & nhân sự
                    Text(
                      'Tài chính & nhân sự',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        children: [
                          _buildMenuRow(
                            icon: Icons.account_balance_outlined,
                            title: 'Tài khoản nhận tiền',
                            subtitle: 'Vietcombank •••• 6789',
                            onTap: () => Navigator.pushNamed(context, '/merchant-bank-settings'),
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.receipt_long_outlined,
                            title: 'Đối soát doanh thu',
                            subtitle: 'Kỳ 16–22/10',
                            onTap: () => Navigator.pushNamed(context, '/merchant-revenue'),
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.people_outline_rounded,
                            title: 'Nhân sự cửa hàng',
                            subtitle: '3 thành viên',
                            onTap: () => Navigator.pushNamed(context, '/merchant-staff'),
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.notifications_none_rounded,
                            title: 'Thông báo',
                            subtitle: null,
                            onTap: () {},
                          ),
                          const Divider(color: Color(0xFFE4E9E1), height: 1, indent: 52),
                          _buildMenuRow(
                            icon: Icons.headset_mic_outlined,
                            title: 'Hỗ trợ đối tác',
                            subtitle: null,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Role Switch Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFE4E9E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        icon: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF183B2E), size: 18),
                        label: Text(
                          'Chuyển về Chế độ Người Dùng',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF183B2E)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF183B2E),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: const Color(0xFF718076),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: Color(0xFF718076)),
          ],
        ),
      ),
    );
  }
}
