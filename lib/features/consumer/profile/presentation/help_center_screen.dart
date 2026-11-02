import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _faqs = [
    {
      'question': 'Túi bí mật hoạt động thế nào?',
      'answer':
          'Cửa hàng gom các món ăn thơm ngon còn dư vào cuối ngày thành các gói định giá cố định (giảm 50% – 70% so với giá gốc). Bạn biết trước danh mục (Bánh ngọt, Cơm văn phòng, Món chay, Đồ uống) nhưng nhận ngẫu nhiên các món thơm ngon còn lại trong ngày.',
    },
    {
      'question': 'Khung giờ đón hàng (Pick-up Window) là gì?',
      'answer':
          'Khung giờ vàng cửa hàng quy định để khách đến nhận túi trực tiếp (thường từ 20:00 – 22:30). Hãy sắp xếp đến đúng giờ để nhân viên bàn giao túi kịp trước giờ đóng cửa.',
    },
    {
      'question': 'Làm thế nào để nhận túi tại cửa hàng?',
      'answer':
          'Sau khi thanh toán thành công, bạn chỉ cần mở mục "Đơn hàng" -> Chọn đơn đang hoạt động -> Nhấn "Xem vé QR" và xuất trình cho nhân viên tại quầy quét chỉ trong 5-10 giây.',
    },
    {
      'question': 'Tôi bị dị ứng thức ăn thì phải làm sao?',
      'answer':
          'Mỗi túi đều có ghi rõ nhãn "Lưu ý dị ứng" (ví dụ: Chứa gluten, trứng, sữa, hải sản). Bạn cũng có thể ghi chú cho nhân viên ở bước xác nhận đơn để quán tránh chọn các món gây dị ứng cho bạn.',
    },
    {
      'question': 'Chính sách hoàn tiền hoặc hủy đơn như thế nào?',
      'answer':
          'Bạn có thể hủy đơn trước khung giờ đón hàng tối thiểu 30 phút. Nếu cửa hàng gặp sự cố đột xuất hoặc hết hàng, hệ thống sẽ tự động hoàn 100% tiền về ví điện tử / thẻ của bạn trong 24h.',
    },
    {
      'question': 'Chỉ số tác động xanh (Green Impact) được tính ra sao?',
      'answer':
          'Mỗi túi thức ăn được cứu trung bình giúp giảm khoảng 2.38 kg CO₂ thải ra môi trường và tiết kiệm từ 50.000đ – 100.000đ. Thành tích này được cộng dồn theo thời gian thực trên Dấu chân xanh của bạn.',
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqs.where((f) {
      final q = f['question']!.toLowerCase();
      final a = f['answer']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return q.contains(query) || a.contains(query);
    }).toList();

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
          'Mình có thể giúp gì?',
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
            // Header card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.forestGreen, AppColors.forestGreenDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MỖI BỮA ĂN ĐỀU ĐÁNG GIÁ',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.sdgGold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tìm câu trả lời cho hành trình giải cứu',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Tìm câu hỏi, thắc mắc...',
                        hintStyle: GoogleFonts.beVietnamPro(color: Colors.grey.shade400, fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: AppColors.forestGreen),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // FAQs List
            Text(
              'Câu hỏi thường gặp',
              style: GoogleFonts.beVietnamPro(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 12),
            ...filteredFaqs.map((faq) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  iconColor: AppColors.forestGreen,
                  collapsedIconColor: Colors.grey.shade600,
                  title: Text(
                    faq['question']!,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.charcoal,
                    ),
                  ),
                  children: [
                    Text(
                      faq['answer']!,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),
            // Contact actions
            Text(
              'Bạn vẫn cần hỗ trợ thêm?',
              style: GoogleFonts.beVietnamPro(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/support-request');
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.forestGreen.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.assignment_outlined, color: AppColors.forestGreen, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            'Gửi phiếu hỗ trợ',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.forestGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Phản hồi trong 2h',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hotline ResQ Bites: 1900 8942 (Miễn phí)')),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.headset_mic_outlined, color: AppColors.sdgGold, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            'Gọi tổng đài',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.charcoal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '1900 8942 (8h - 23h)',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

