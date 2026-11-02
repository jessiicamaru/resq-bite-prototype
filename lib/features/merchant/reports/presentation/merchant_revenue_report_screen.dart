import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantRevenueReportScreen extends StatefulWidget {
  const MerchantRevenueReportScreen({super.key});

  @override
  State<MerchantRevenueReportScreen> createState() => _MerchantRevenueReportScreenState();
}

class _MerchantRevenueReportScreenState extends State<MerchantRevenueReportScreen> {
  int _selectedFilter = 0; // 0: Tuần này, 1: Tháng 10

  final List<Map<String, dynamic>> _dailyData = [
    {'day': 'T2', 'bags': 16, 'revenue': '560k', 'height': 0.6},
    {'day': 'T3', 'bags': 18, 'revenue': '630k', 'height': 0.7},
    {'day': 'T4', 'bags': 14, 'revenue': '490k', 'height': 0.55},
    {'day': 'T5', 'bags': 20, 'revenue': '700k', 'height': 0.8},
    {'day': 'T6', 'bags': 22, 'revenue': '770k', 'height': 0.9},
    {'day': 'T7', 'bags': 24, 'revenue': '840k', 'height': 1.0},
    {'day': 'CN', 'bags': 12, 'revenue': '420k', 'height': 0.45},
  ];

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
          'Doanh thu cứu trợ',
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
            // Period Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildFilterTab('Tuần 16 – 22/10', 0),
                  ),
                  Expanded(
                    child: _buildFilterTab('Tháng 10 của Mây (M32)', 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Revenue Highlight Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.forestGreen, AppColors.forestGreenDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.forestGreen.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedFilter == 0 ? 'TỔNG DOANH THU TUẦN NÀY' : 'TỔNG DOANH THU THÁNG 10',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.sdgGold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedFilter == 0 ? '4.410.000đ' : '18.900.000đ',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _selectedFilter == 0 ? '126 túi giải cứu thành công' : '540 túi giải cứu thành công',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bar Chart Representation
            Text(
              'Biểu đồ số túi & doanh thu trong tuần',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _dailyData.map((d) {
                        final double h = (d['height'] as double) * 120;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${d['bags']}',
                              style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.forestGreen),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 24,
                              height: h,
                              decoration: BoxDecoration(
                                color: AppColors.forestGreen,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              d['day'] as String,
                              style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const Divider(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trung bình ngày:',
                        style: GoogleFonts.beVietnamPro(fontSize: 13, color: Colors.grey.shade600),
                      ),
                      Text(
                        '18 túi / ngày (630.000đ)',
                        style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.charcoal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payout Settlement (M33)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_balance, color: AppColors.forestGreen, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Kỳ đối soát & chuyển tiền (M33)',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildSettlementRow('Doanh thu tích lũy tuần', '4.410.000đ'),
                  const SizedBox(height: 8),
                  _buildSettlementRow('Phí nền tảng (Ưu đãi đối tác mới 0%)', '0đ'),
                  const SizedBox(height: 8),
                  _buildSettlementRow('Thực nhận chuyển khoản', '4.410.000đ', isBold: true),
                  const Divider(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        'Chuyển tự động vào Thứ Sáu, 25/10 (Vietcombank ··6789)',
                        style: GoogleFonts.beVietnamPro(fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, int index) {
    final isSelected = _selectedFilter == index;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.forestGreen : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildSettlementRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.beVietnamPro(fontSize: 13, color: Colors.grey.shade600)),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: isBold ? AppColors.forestGreen : AppColors.charcoal,
          ),
        ),
      ],
    );
  }
}
