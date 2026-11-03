import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class SupportRequestScreen extends StatefulWidget {
  final String? initialOrderCode;

  const SupportRequestScreen({
    super.key,
    this.initialOrderCode,
  });

  @override
  State<SupportRequestScreen> createState() => _SupportRequestScreenState();
}

class _SupportRequestScreenState extends State<SupportRequestScreen> {
  late final TextEditingController _orderCodeController;
  final _issueController = TextEditingController(text: 'Không tìm thấy cửa hàng');
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orderCodeController = TextEditingController(text: widget.initialOrderCode ?? 'RB-1024');
  }

  @override
  void dispose() {
    _orderCodeController.dispose();
    _issueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE4E9E1)),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            color: const Color(0xFF183B2E),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Gửi yêu cầu hỗ trợ',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MỖI BỮA ĂN ĐỀU ĐÁNG GIÁ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF63834D),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gửi yêu cầu hỗ trợ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mô tả vấn đề để chúng mình hỗ trợ đúng hạn.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Mã đơn field
                    _buildInputLabel('Mã đơn'),
                    _buildInputField(controller: _orderCodeController),

                    const SizedBox(height: 16),

                    // Vấn đề field
                    _buildInputLabel('Vấn đề'),
                    _buildInputField(controller: _issueController),

                    const SizedBox(height: 16),

                    // Mô tả field
                    _buildInputLabel('Mô tả'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 4,
                        minLines: 3,
                        style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF183B2E)),
                        decoration: InputDecoration(
                          hintText: 'Nhập nội dung cần hỗ trợ',
                          hintStyle: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ảnh đính kèm box (C54)
                    _buildInputLabel('Ảnh đính kèm'),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã đính kèm ảnh chụp màn hình vấn đề!')),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F6EE),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFD4DDD6)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.file_upload_outlined, color: Color(0xFF12543B), size: 24),
                            const SizedBox(height: 6),
                            Text(
                              'Thêm ảnh (không bắt buộc)',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 11,
                                color: const Color(0xFF718076),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 49,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF12543B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // BƯỚC TIẾP THEO: Yêu cầu đã được gửi (Screen C55)
                          Navigator.pushReplacementNamed(
                            context,
                            '/support-success',
                            arguments: {
                              'orderCode': _orderCodeController.text,
                            },
                          );
                        },
                        child: Text(
                          'Gửi yêu cầu',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.beVietnamPro(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF183B2E),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E9E1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: TextField(
        controller: controller,
        style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF183B2E)),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, 0, Icons.home_outlined, 'Khám phá', false, () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
          }),
          _navItem(context, 1, Icons.map_outlined, 'Bản đồ', false, () {
            Navigator.pushNamed(context, '/map-explorer');
          }),
          _navItem(context, 2, Icons.shopping_bag_outlined, 'Đơn hàng', false, () {
            Navigator.pushNamed(context, '/orders-history');
          }),
          _navItem(context, 3, Icons.person, 'Tài khoản', true, () {}),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ],
      ),
    );
  }
}
