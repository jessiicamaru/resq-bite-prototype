import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/merchant_order.dart';

class MerchantQrValidScreen extends StatelessWidget {
  final MerchantOrder? order;
  final bool isError;
  final String errorType; // 'used', 'expired'

  const MerchantQrValidScreen({
    super.key,
    this.order,
    this.isError = false,
    this.errorType = 'used',
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final activeOrder = order ?? mockMerchantOrders.first;

    if (isError) {
      return _buildErrorState(context);
    }

    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mã hợp lệ',
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
          children: [
            // Success Verification Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MÃ VÉ HỢP LỆ & ĐÃ THANH TOÁN',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF15803D),
                          ),
                        ),
                        Text(
                          'Kiểm tra đúng gói trước khi bàn giao cho khách hàng.',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: const Color(0xFF166534),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Detail Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activeOrder.orderCode,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Đã thanh toán',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forestGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  _buildDetailRow('Người nhận', activeOrder.customerName, isBold: true),
                  const SizedBox(height: 12),
                  _buildDetailRow('Gói giải cứu', '${activeOrder.quantity}x ${activeOrder.bagTitle}'),
                  const SizedBox(height: 12),
                  _buildDetailRow('Tổng tiền đã thu', currencyFormatter.format(activeOrder.totalPrice), isGreen: true),
                  const SizedBox(height: 12),
                  _buildDetailRow('Khung giờ nhận', activeOrder.pickupTime),
                  const SizedBox(height: 12),
                  _buildDetailRow('Thời gian đặt', DateFormat('HH:mm - dd/MM/yyyy').format(activeOrder.orderTime)),
                  const Divider(height: 24),

                  // Customer Note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.ecoIvory,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.sticky_note_2_outlined, color: AppColors.sdgGold, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ghi chú từ khách hàng:',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.forestGreenDark),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '“Nếu còn croissant bơ hoặc bánh hạt ngũ cốc thì cho mình xin nhé. Cảm ơn tiệm!”',
                                style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.charcoal, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                _showDeliveredDialog(context, activeOrder);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: AppColors.forestGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.task_alt, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Xác nhận đã trao túi cho khách',
                    style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: AppColors.forestGreen),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Quét mã đơn tiếp theo',
                style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.forestGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
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
          'Mã không hợp lệ (M27)',
          style: GoogleFonts.beVietnamPro(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cancel_outlined, color: Colors.red.shade600, size: 64),
            ),
            const SizedBox(height: 20),
            Text(
              'Mã đã được sử dụng (M27)',
              style: GoogleFonts.beVietnamPro(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.red.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Mã này đã được xác nhận trao túi lúc 19:30 ngày hôm nay. Không thể quét nhận lại lần thứ 2.',
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.forestGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Quét lại mã khác',
                style: GoogleFonts.beVietnamPro(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(fontSize: 13, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : (isGreen ? FontWeight.w800 : FontWeight.w600),
            color: isGreen ? AppColors.forestGreen : AppColors.charcoal,
          ),
        ),
      ],
    );
  }

  void _showDeliveredDialog(BuildContext context, MerchantOrder activeOrder) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.forestGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.celebration, color: AppColors.forestGreen, size: 48),
            ),
            const SizedBox(height: 16),
            Text(
              'Đã trao túi thành công!',
              style: GoogleFonts.beVietnamPro(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Đơn hàng ${activeOrder.orderCode} của khách ${activeOrder.customerName} đã được đánh dấu hoàn tất. +1 Bữa ăn ngon đã được cứu!',
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forestGreen,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Hoàn tất',
                style: GoogleFonts.beVietnamPro(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

