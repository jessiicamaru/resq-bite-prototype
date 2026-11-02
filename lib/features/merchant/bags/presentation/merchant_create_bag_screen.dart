import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantCreateBagScreen extends StatefulWidget {
  const MerchantCreateBagScreen({super.key});

  @override
  State<MerchantCreateBagScreen> createState() => _MerchantCreateBagScreenState();
}

class _MerchantCreateBagScreenState extends State<MerchantCreateBagScreen> {
  final _titleController = TextEditingController(text: 'Túi Bánh Cuối Ngày');
  final _originalPriceController = TextEditingController(text: '100000');
  final _rescuePriceController = TextEditingController(text: '35000');
  final _quantityController = TextEditingController(text: '5');
  final _descController = TextEditingController(
    text: 'Túi bí mật gồm các loại bánh mì artisan, croissant tươi hoặc bánh ngọt nướng trong ngày.',
  );

  String _category = 'Bánh';
  final List<String> _selectedAllergens = ['Chứa gluten', 'Chứa sữa & bơ'];

  final List<String> _allAllergens = [
    'Chứa gluten',
    'Chứa sữa & bơ',
    'Chứa trứng',
    'Chứa hạt mè',
    'Chứa đậu phộng',
    'Hải sản',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _originalPriceController.dispose();
    _rescuePriceController.dispose();
    _quantityController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _calculateRescuePrice(double discountPercent) {
    final orig = int.tryParse(_originalPriceController.text) ?? 100000;
    final res = (orig * (1 - discountPercent / 100)).round();
    setState(() {
      _rescuePriceController.text = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tạo một túi mới',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper Indicator
            Row(
              children: [
                _buildStepBadge('1', 'Thông tin túi', true),
                Expanded(child: Container(height: 2, color: AppColors.forestGreen)),
                _buildStepBadge('2', 'Giá giải cứu', true),
                Expanded(child: Container(height: 2, color: Colors.grey.shade300)),
                _buildStepBadge('3', 'Khung giờ', false),
              ],
            ),
            const SizedBox(height: 24),

            // Section 1: Basic Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Thông tin Túi bí mật',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forestGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Tên túi (đặt theo danh mục)',
                    style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.charcoal),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    'Danh mục món',
                    style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.charcoal),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Bánh', child: Text('Bánh mì & bánh ngọt')),
                      DropdownMenuItem(value: 'Cơm', child: Text('Cơm & món mặn')),
                      DropdownMenuItem(value: 'Chay', child: Text('Món chay thanh đạm')),
                      DropdownMenuItem(value: 'Đồ uống', child: Text('Đồ uống & trà sữa')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _category = val);
                    },
                  ),
                  const SizedBox(height: 14),

                  Text(
                    'Mô tả gợi ý các món có thể nhận ngẫu nhiên',
                    style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.charcoal),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 2: Pricing (M15)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2. Giá thật, giá giải cứu (M15)',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.sdgGold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Giảm 50% – 70%',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forestGreenDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giá trị gốc (VND)',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.charcoal,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _originalPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixText: 'đ',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giá giải cứu (VND)',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.forestGreen,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _rescuePriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixText: 'đ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.forestGreen, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Gợi ý nhanh mức giảm:',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 8),
                      _buildDiscountChip('50%', 50),
                      const SizedBox(width: 6),
                      _buildDiscountChip('60%', 60),
                      const SizedBox(width: 6),
                      _buildDiscountChip('65%', 65),
                      const SizedBox(width: 6),
                      _buildDiscountChip('70%', 70),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 3: Allergens & Notice
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. Lưu ý dị ứng thực phẩm',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forestGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _allAllergens.map((alg) {
                      final isSelected = _selectedAllergens.contains(alg);
                      return FilterChip(
                        selected: isSelected,
                        label: Text(alg),
                        labelStyle: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.charcoal,
                        ),
                        selectedColor: AppColors.forestGreen,
                        checkmarkColor: Colors.white,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedAllergens.add(alg);
                            } else {
                              _selectedAllergens.remove(alg);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/merchant-pickup-window');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: AppColors.forestGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tiếp tục: Cài đặt khung giờ nhận',
                    style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountChip(String label, double percent) {
    return InkWell(
      onTap: () => _calculateRescuePrice(percent),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.charcoal),
        ),
      ),
    );
  }

  Widget _buildStepBadge(String number, String title, bool isDone) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone ? AppColors.forestGreen : Colors.grey.shade300,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.beVietnamPro(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDone ? AppColors.forestGreen : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
