import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/merchant_order.dart';

class MerchantQrScannerScreen extends StatefulWidget {
  const MerchantQrScannerScreen({super.key});

  @override
  State<MerchantQrScannerScreen> createState() => _MerchantQrScannerScreenState();
}

class _MerchantQrScannerScreenState extends State<MerchantQrScannerScreen> {
  bool _flashOn = false;
  final TextEditingController _manualCodeController = TextEditingController();

  @override
  void dispose() {
    _manualCodeController.dispose();
    super.dispose();
  }

  void _onScanSuccess(String code) {
    MerchantOrder order;
    if (code == 'RESQ-EXPIRED') {
      Navigator.pushNamed(
        context,
        '/merchant-qr-valid',
        arguments: {'isError': true, 'errorType': 'used'},
      );
      return;
    }

    try {
      order = mockMerchantOrders.firstWhere((o) => o.orderCode == code);
    } catch (_) {
      order = mockMerchantOrders.first;
    }

    Navigator.pushNamed(
      context,
      '/merchant-qr-valid',
      arguments: {'order': order, 'isError': false},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quét mã nhận túi',
          style: GoogleFonts.beVietnamPro(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off, color: _flashOn ? Colors.amber : Colors.white),
            onPressed: () {
              setState(() {
                _flashOn = !_flashOn;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Simulated camera view with dark gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF1E293B), Colors.black],
                radius: 1.2,
              ),
            ),
          ),

          // Central Viewfinder Box
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Đưa mã của khách vào giữa khung',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.sdgGold, width: 2.5),
                  ),
                  child: Stack(
                    children: [
                      // Scanning laser line simulation
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 2,
                          width: 240,
                          decoration: BoxDecoration(
                            color: AppColors.sdgGold,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sdgGold.withValues(alpha: 0.8),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.qr_code_2,
                          size: 160,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Fast test scan buttons
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app_outlined, color: AppColors.sdgGold, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Chạm để thử quét nhanh mã khách hàng:',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _onScanSuccess('RESQ-8942-DN'),
                      icon: const Icon(Icons.check_circle, size: 16, color: Colors.white),
                      label: const Text('Mã hợp lệ (RB-8942)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forestGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () => _onScanSuccess('RESQ-EXPIRED'),
                      icon: const Icon(Icons.error_outline, size: 16, color: Colors.orange),
                      label: const Text('Mã đã nhận (M27)', style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.orange),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Bar: Enter code manually (M29)
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _manualCodeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Nhập mã nhận túi (VD: RB-8942)',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final code = _manualCodeController.text.trim().isEmpty
                          ? 'RESQ-8942-DN'
                          : _manualCodeController.text.trim();
                      _onScanSuccess(code);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sdgGold,
                      foregroundColor: AppColors.forestGreenDark,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Xác nhận'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
