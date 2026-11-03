import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantRevenueReportScreen extends StatefulWidget {
  const MerchantRevenueReportScreen({super.key});

  @override
  State<MerchantRevenueReportScreen> createState() => _MerchantRevenueReportScreenState();
}

class _MerchantRevenueReportScreenState extends State<MerchantRevenueReportScreen> {
  int _selectedTab = 0; // 0: Tuần, 1: Tháng

  final List<Map<String, dynamic>> _weekData = [
    {'day': 'T2', 'bags': 16, 'height': 0.6},
    {'day': 'T3', 'bags': 18, 'height': 0.7},
    {'day': 'T4', 'bags': 14, 'height': 0.5},
    {'day': 'T5', 'bags': 20, 'height': 0.8},
    {'day': 'T6', 'bags': 22, 'height': 0.88},
    {'day': 'T7', 'bags': 24, 'height': 1.0},
    {'day': 'CN', 'bags': 12, 'height': 0.45},
  ];

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
          'Doanh thu tuần này',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESQ PARTNER',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF63834D),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _selectedTab == 0 ? 'Doanh thu tuần này' : 'Doanh thu tháng này',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _selectedTab == 0
                    ? '4.410.000đ • 126 túi • 16–22/10'
                    : '18.900.000đ • 540 túi • Tháng 10',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 16),

              // Segmented Toggle: Tuần / Tháng
              Container(
                height: 38,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFE7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _selectedTab == 0
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Tuần',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: _selectedTab == 0 ? FontWeight.w700 : FontWeight.w500,
                              color: _selectedTab == 0 ? const Color(0xFF12543B) : const Color(0xFF718076),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _selectedTab == 1
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Tháng',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: _selectedTab == 1 ? FontWeight.w700 : FontWeight.w500,
                              color: _selectedTab == 1 ? const Color(0xFF12543B) : const Color(0xFF718076),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Total Revenue Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedTab == 0 ? 'TỔNG DOANH THU 16–22/10' : 'TỔNG DOANH THU THÁNG 10',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF718076),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _selectedTab == 0 ? '4.410.000đ' : '18.900.000đ',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '↗ 12,4% so với kỳ trước',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B8C44),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Daily Bar Chart
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _weekData.map((d) {
                          final double h = (d['height'] as double) * 90;
                          final isPeak = d['day'] == 'T7';
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 28,
                                height: h,
                                decoration: BoxDecoration(
                                  color: isPeak ? const Color(0xFF12543B) : const Color(0xFFA4C777),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                d['day'] as String,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF718076),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Stat Grid (2 Columns)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số túi đã bán',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _selectedTab == 0 ? '126' : '540',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4E9E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giá trị trung bình',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '35k',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Section Title: Theo loại túi
              Text(
                'Theo loại túi',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 10),

              // Table Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Túi',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF718076),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Số lượng',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF718076),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Doanh thu',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF718076),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFFE4E9E1), height: 18),
                    // Row 1
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Bánh cuối ngày',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '86',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '3.010.000đ',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFFE4E9E1), height: 18),
                    // Row 2
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Bánh mì',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '40',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '1.400.000đ',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Section Title: Hiệu quả giải cứu
              Text(
                'Hiệu quả giải cứu',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              const SizedBox(height: 10),

              // Donut Efficiency Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E9E1)),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: 58,
                          height: 58,
                          child: CircularProgressIndicator(
                            value: 0.92,
                            strokeWidth: 6,
                            backgroundColor: Color(0xFFEAF3DD),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF12543B)),
                          ),
                        ),
                        Text(
                          '92%',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tỷ lệ bán hết túi mở bán',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              color: const Color(0xFF718076),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '92%',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF183B2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Full CTA Button: Xem kỳ đối soát
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
                  onPressed: () => _showSettlementModal(context),
                  child: Text(
                    'Xem kỳ đối soát',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettlementModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kỳ đối soát 16–22/10',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF183B2E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildModalRow('Doanh thu tích lũy', '4.410.000đ'),
            const SizedBox(height: 8),
            _buildModalRow('Phí dịch vụ đối tác (0% ưu đãi)', '0đ'),
            const SizedBox(height: 8),
            _buildModalRow('Thực nhận chuyển khoản', '4.410.000đ', isBold: true),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.account_balance, size: 16, color: Color(0xFF12543B)),
                const SizedBox(width: 8),
                Text(
                  'Vietcombank •••• 6789 (Thứ Sáu, 25/10)',
                  style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildModalRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
        ),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? const Color(0xFF12543B) : const Color(0xFF183B2E),
          ),
        ),
      ],
    );
  }
}
