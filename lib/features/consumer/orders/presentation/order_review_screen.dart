import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class OrderReviewScreen extends StatefulWidget {
  final MysteryBag bag;
  const OrderReviewScreen({super.key, required this.bag});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  int _rating = 5;
  final Set<String> _selectedTags = {'Đồ ăn tươi ngon', 'Tiết kiệm nhiều'};
  final _commentController = TextEditingController();

  final List<String> _feedbackTags = [
    'Đồ ăn tươi ngon',
    'Tiết kiệm nhiều',
    'Đóng gói sạch sẽ',
    'Nhân viên thân thiện',
    'Bất ngờ thú vị',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cảm ơn bạn! Đã cộng +50 Điểm Thưởng Xanh vào ví của bạn.'),
        backgroundColor: AppColors.primary,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Đánh Giá Túi Đồ Ăn'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.bag.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.bag.storeName,
                style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              Text(
                'Túi hôm nay thế nào?',
                style: GoogleFonts.beVietnamPro(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),

              // Star Rating Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return IconButton(
                    iconSize: 38,
                    onPressed: () => setState(() => _rating = starIndex),
                    icon: Icon(
                      starIndex <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: AppColors.star,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              Text(
                _rating == 5 ? 'Tuyệt vời, rất hài lòng!' : 'Hài lòng với bữa ăn',
                style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),

              const SizedBox(height: 24),

              // Feedback Tags
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bạn ấn tượng điều gì nhất?',
                  style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _feedbackTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: AppColors.primaryLight,
                    checkmarkColor: AppColors.primary,
                    labelStyle: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Comment input
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Chia sẻ cảm nhận về món ăn và trải nghiệm nhận túi bí mật…',
                  hintStyle: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textMuted),
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Gửi Đánh Giá & Nhận Điểm Xanh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

