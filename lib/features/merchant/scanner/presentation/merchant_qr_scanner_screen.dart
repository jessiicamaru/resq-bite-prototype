import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantQrScannerScreen extends StatefulWidget {
  const MerchantQrScannerScreen({super.key});

  @override
  State<MerchantQrScannerScreen> createState() => _MerchantQrScannerScreenState();
}

class _MerchantQrScannerScreenState extends State<MerchantQrScannerScreen>
    with SingleTickerProviderStateMixin {
  bool _flashOn = false;
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 180).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showManualInputDialog() {
    final controller = TextEditingController(text: 'RB-1024');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          'Nhập mã nhận túi',
          style: GoogleFonts.beVietnamPro(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nhập mã số 6 ký tự hiển thị trên ứng dụng của khách:',
              style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                color: const Color(0xFF718076),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'VD: RB-1024',
                hintStyle: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF849187)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE4E9E1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE4E9E1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF12543B), width: 1.5),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hủy',
              style: GoogleFonts.beVietnamPro(color: const Color(0xFF718076), fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12543B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/merchant-qr-valid');
            },
            child: Text(
              'Kiểm tra',
              style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showTestStatusDialog(String title, String message, bool isError) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isError ? const Color(0xFFFDE8E8) : const Color(0xFFEAF3DD),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isError ? Icons.error_outline_rounded : Icons.history_rounded,
                color: isError ? Colors.red.shade700 : const Color(0xFF12543B),
                size: 36,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: GoogleFonts.beVietnamPro(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF183B2E),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                color: const Color(0xFF718076),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12543B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Đóng',
                  style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          'Quét mã nhận túi',
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF183B2E),
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE4E9E1)),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                _flashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                size: 18,
                color: _flashOn ? const Color(0xFFDDA63A) : const Color(0xFF183B2E),
              ),
              onPressed: () => setState(() => _flashOn = !_flashOn),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
                'Quét mã nhận túi',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Đưa mã QR của khách vào giữa khung.',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: const Color(0xFF718076),
                ),
              ),
              const SizedBox(height: 18),

              // Scanner Viewfinder Area
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF183B2E),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Subtle background grid or gradient
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: const RadialGradient(
                            center: Alignment.center,
                            radius: 0.9,
                            colors: [
                              Color(0xFF1E4A3A),
                              Color(0xFF10271E),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Target Scan Window
                    Container(
                      width: 210,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFFD9F19E),
                          width: 3.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Animated scan line
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Positioned(
                                top: _animation.value,
                                left: 10,
                                right: 10,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCF59A),
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFDCF59A).withValues(alpha: 0.8),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Center(
                            child: Icon(
                              Icons.qr_code_2_rounded,
                              size: 130,
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Prompt at bottom of scanner
                    Positioned(
                      bottom: 14,
                      child: Text(
                        'Đưa mã của khách vào khung',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Info-grid: Flash & Manual Input buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEAF3DD),
                          foregroundColor: const Color(0xFF12543B),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => setState(() => _flashOn = !_flashOn),
                        icon: Icon(
                          _flashOn ? Icons.flash_on_rounded : Icons.flashlight_on_outlined,
                          size: 16,
                          color: const Color(0xFF12543B),
                        ),
                        label: Text(
                          'Đèn flash',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12543B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFE4E9E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _showManualInputDialog,
                        child: Text(
                          'Nhập mã',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Prototype Sandbox Card
              Container(
                width: double.infinity,
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
                      'Chế độ thử prototype',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF183B2E),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Chọn kết quả quét để kiểm tra từng tình huống.',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        color: const Color(0xFF718076),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Primary Full Button: Mã hợp lệ
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF12543B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/merchant-qr-valid');
                        },
                        child: Text(
                          'Mã hợp lệ',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 2 Secondary buttons: Đã dùng & Quá giờ
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEAF3DD),
                                foregroundColor: const Color(0xFF12543B),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _showTestStatusDialog(
                                  'Mã đã sử dụng',
                                  'Mã vé RB-8942 này đã được xác nhận trao túi lúc 19:30 ngày hôm nay.',
                                  true,
                                );
                              },
                              child: Text(
                                'Đã dùng',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF12543B),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEAF3DD),
                                foregroundColor: const Color(0xFF12543B),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _showTestStatusDialog(
                                  'Quá giờ nhận',
                                  'Đã qua khung giờ nhận túi hôm nay (20:00 - 21:30). Vui lòng liên hệ hỗ trợ.',
                                  true,
                                );
                              },
                              child: Text(
                                'Quá giờ',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF12543B),
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

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
