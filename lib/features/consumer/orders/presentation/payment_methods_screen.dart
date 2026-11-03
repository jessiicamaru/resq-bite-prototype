import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final String currentMethod;
  const PaymentMethodsScreen({super.key, this.currentMethod = 'Ví MoMo'});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late String _selected;

  final List<Map<String, dynamic>> _methods = [
    {
      'id': 'Ví MoMo',
      'title': 'Ví Điện Tử MoMo',
      'subtitle': 'Liên kết nhanh, hoàn 5% điểm xanh',
      'icon': Icons.account_balance_wallet_rounded,
      'badge': 'Khuyên dùng',
    },
    {
      'id': 'Ví ZaloPay',
      'title': 'Ví ZaloPay',
      'subtitle': 'Thanh toán trực tiếp trong 5s',
      'icon': Icons.payment_rounded,
      'badge': null,
    },
    {
      'id': 'Thẻ Visa/Mastercard',
      'title': 'Thẻ Quốc Tế (Visa / Mastercard)',
      'subtitle': 'Đã liên kết **** 8942',
      'icon': Icons.credit_card_rounded,
      'badge': null,
    },
    {
      'id': 'Điểm Thưởng Xanh',
      'title': 'Điểm Thưởng Xanh ResQ',
      'subtitle': 'Số dư: 45.000 điểm (tương đương 45.000đ)',
      'icon': Icons.eco_rounded,
      'badge': 'Miễn phí',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.currentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context, _selected),
        ),
        title: const Text('Phương Thức Thanh Toán'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHỌN CÁCH THANH TOÁN',
                style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.8),
              ),
              const SizedBox(height: 6),
              Text(
                'Thanh toán an toàn không dùng tiền mặt',
                style: GoogleFonts.beVietnamPro(fontSize: 14, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 20),

              ..._methods.map((m) {
                final isChosen = m['id'] == _selected;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selected = m['id'] as String);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isChosen ? AppColors.primary : AppColors.border,
                        width: isChosen ? 1.8 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isChosen ? AppColors.primaryLight : AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(m['icon'] as IconData, color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    m['title'] as String,
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  if (m['badge'] != null) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        m['badge'] as String,
                                        style: GoogleFonts.beVietnamPro(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.primary),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                m['subtitle'] as String,
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isChosen ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isChosen ? AppColors.primary : AppColors.textMuted,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selected),
                  child: const Text('Xác nhận phương thức này'),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

