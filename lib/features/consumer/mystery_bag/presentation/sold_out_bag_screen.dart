import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/food_bag.dart';

class SoldOutBagScreen extends StatefulWidget {
  final MysteryBag bag;
  const SoldOutBagScreen({super.key, required this.bag});

  @override
  State<SoldOutBagScreen> createState() => _SoldOutBagScreenState();
}

class _SoldOutBagScreenState extends State<SoldOutBagScreen> {
  bool _isNotified = false;

  @override
  Widget build(BuildContext context) {
    final otherBags = mockMysteryBags.where((b) => b.id != widget.bag.id).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.bag.storeName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Sold out banner box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.sentiment_satisfied_alt_rounded, color: AppColors.primary, size: 40),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Hôm nay đã hết túi!',
                      style: GoogleFonts.beVietnamPro(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tất cả túi bí mật tại ${widget.bag.storeName} đã được giải cứu hết. Cảm ơn cộng đồng vì lối sống không lãng phí thực phẩm!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary, height: 1.45),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() => _isNotified = !_isNotified);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_isNotified
                                ? 'Đã bật thông báo! App sẽ báo bạn khi ${widget.bag.storeName} mở bán vào ngày mai.'
                                : 'Đã tắt thông báo.'),
                          ),
                        );
                      },
                      icon: Icon(
                        _isNotified ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
                        color: AppColors.primary,
                      ),
                      label: Text(
                        _isNotified ? 'Đã bật thông báo ngày mai' : 'Báo tôi khi có túi ngày mai',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Các quán khác vẫn còn túi quanh bạn:',
                  style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),

              const SizedBox(height: 12),

              ...otherBags.map((b) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            b.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                b.storeName,
                                style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                              ),
                              Text(
                                '${b.title} · Còn ${b.remainingBags} túi',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/bag-detail', arguments: b),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(60, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text('Xem', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
