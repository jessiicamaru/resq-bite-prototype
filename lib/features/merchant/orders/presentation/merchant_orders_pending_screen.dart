import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/merchant_order.dart';

class MerchantOrdersPendingScreen extends StatefulWidget {
  final int initialTab;

  const MerchantOrdersPendingScreen({super.key, this.initialTab = 0});

  @override
  State<MerchantOrdersPendingScreen> createState() => _MerchantOrdersPendingScreenState();
}

class _MerchantOrdersPendingScreenState extends State<MerchantOrdersPendingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingOrders = mockMerchantOrders.where((o) => o.status == 'pending').toList();
    final completedOrders = mockMerchantOrders.where((o) => o.status == 'completed').toList();

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
          'Đơn nhận tại quán',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: AppColors.forestGreen),
            tooltip: 'Mở quét mã',
            onPressed: () {
              Navigator.pushNamed(context, '/merchant-scanner');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.forestGreen,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: AppColors.forestGreen,
          labelStyle: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, fontSize: 14),
          tabs: [
            Tab(text: 'Đơn chờ nhận (${pendingOrders.length})'),
            Tab(text: 'Đã trao tay (${completedOrders.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingList(pendingOrders),
          _buildCompletedList(completedOrders),
        ],
      ),
    );
  }

  Widget _buildPendingList(List<MerchantOrder> orders) {
    final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    if (orders.isEmpty) {
      return Center(
        child: Text(
          'Không có đơn nào đang chờ nhận',
          style: GoogleFonts.beVietnamPro(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
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
                    order.orderCode,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.forestGreen,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Chờ khách đến lấy',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.forestGreen.withValues(alpha: 0.1),
                    child: Text(
                      order.customerName.substring(0, 1),
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w700,
                        color: AppColors.forestGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.charcoal,
                          ),
                        ),
                        Text(
                          '${order.quantity}x ${order.bagTitle} · ${currencyFormatter.format(order.totalPrice)}',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.ecoIvory,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 16, color: AppColors.forestGreen),
                    const SizedBox(width: 6),
                    Text(
                      'Khung giờ nhận: ${order.pickupTime}',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forestGreenDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/merchant-qr-valid',
                          arguments: {'order': order, 'isError': false},
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, size: 16),
                      label: const Text('Bàn giao nhanh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forestGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/merchant-scanner');
                    },
                    icon: const Icon(Icons.qr_code, size: 16),
                    label: const Text('Quét mã'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.forestGreen,
                      side: const BorderSide(color: AppColors.forestGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompletedList(List<MerchantOrder> orders) {
    final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.done_all, color: Color(0xFF16A34A), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.orderCode,
                          style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.charcoal),
                        ),
                        Text(
                          currencyFormatter.format(order.totalPrice),
                          style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.forestGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${order.customerName} • ${order.quantity}x ${order.bagTitle}',
                      style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Đã trao: ${order.pickupTime}',
                      style: GoogleFonts.beVietnamPro(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

