import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/food_bag.dart';

class PaymentPendingScreen extends StatelessWidget {
  final MysteryBag bag;
  final int quantity;
  final String payment;

  const PaymentPendingScreen({
    super.key,
    required this.bag,
    this.quantity = 1,
    this.payment = 'MoMo',
  });

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
          'Đang xác nhận',
          style: GoogleFonts.beVietnamPro(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Circular clock badge
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F2E8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.access_time_rounded,
                        size: 36,
                        color: Color(0xFF12543B),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Đang xác nhận',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Chúng mình đang chờ kết quả thanh toán.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        color: const Color(0xFF718076),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Information Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mã giao dịch RB-1024',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Vui lòng không thanh toán lại.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Nếu chờ lâu, kiểm tra trạng thái đơn.',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Status rows
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đã tiếp nhận',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Thông tin đã được ghi nhận',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  color: const Color(0xFF718076),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đang xử lý',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF183B2E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Kết quả sẽ được hiển thị khi hoàn tất',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  color: const Color(0xFF718076),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom prototype action section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Chọn kết quả mô phỏng để thử prototype:',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: const Color(0xFF718076),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF12543B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // BƯỚC TIẾP THEO: Thanh toán thành công (Image 11)
                              Navigator.pushReplacementNamed(
                                context,
                                '/payment-success',
                                arguments: {
                                  'bag': bag,
                                  'quantity': quantity,
                                  'payment': payment,
                                },
                              );
                            },
                            child: Text(
                              'Thành công',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEBF2EB),
                              foregroundColor: const Color(0xFF183B2E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Mô phỏng thất bại: Thanh toán không thành công. Vui lòng thử lại!'),
                                  backgroundColor: Color(0xFF8F4C17),
                                ),
                              );
                            },
                            child: Text(
                              'Thất bại',
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
