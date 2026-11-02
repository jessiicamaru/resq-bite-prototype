import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Sắp đến giờ đón túi của bạn!',
        'body': 'Khung giờ nhận túi tại Tiệm Bánh Mây đã mở (20:00 – 21:30). Hãy mang điện thoại xuất trình mã QR nhé.',
        'time': '10 phút trước',
        'isRead': false,
        'icon': Icons.alarm,
        'color': AppColors.warning,
      },
      {
        'title': 'Quán yêu thích vừa mở bán',
        'body': 'Bếp Nhà vừa cập nhật 3 Túi cơm gia đình cho tối nay. Đặt ngay kẻo hết!',
        'time': '1 giờ trước',
        'isRead': false,
        'icon': Icons.storefront_rounded,
        'color': AppColors.primary,
      },
      {
        'title': 'Huy hiệu mới: Đại Sứ Xanh Hạng Bạc',
        'body': 'Bạn đã cứu thành công 12 bữa ăn và giảm 28.5 kg CO₂. Cảm ơn bạn vì một lối sống bền vững!',
        'time': 'Hôm qua',
        'isRead': true,
        'icon': Icons.military_tech_rounded,
        'color': AppColors.sdgGold,
      },
      {
        'title': 'Cộng +50 Điểm Thưởng Xanh',
        'body': 'Đánh giá túi đồ ăn của bạn đã được ghi nhận. Điểm thưởng đã được cộng vào ví.',
        'time': '3 ngày trước',
        'isRead': true,
        'icon': Icons.eco_rounded,
        'color': AppColors.co2Reduction,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thông Báo Của Bạn'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã đánh dấu đã đọc tất cả thông báo!')),
              );
            },
            child: Text(
              'Đọc hết',
              style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: notifications.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final n = notifications[index];
            final isRead = n['isRead'] as bool;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isRead ? Colors.white : AppColors.primaryLight.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isRead ? AppColors.border : AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (n['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                n['title'] as String,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (!isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n['body'] as String,
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          n['time'] as String,
                          style: GoogleFonts.beVietnamPro(fontSize: 10, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

