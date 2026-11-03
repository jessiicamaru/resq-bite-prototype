import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/store/merchant_store.dart';

class MerchantOrdersPendingScreen extends StatefulWidget {
  final int initialTab;
  const MerchantOrdersPendingScreen({super.key, this.initialTab = 0});

  @override
  State<MerchantOrdersPendingScreen> createState() => _MerchantOrdersPendingScreenState();
}

class _MerchantOrdersPendingScreenState extends State<MerchantOrdersPendingScreen> {
  late int _selectedTab;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return AnimatedBuilder(
      animation: MerchantStore.instance,
      builder: (context, _) {
        final store = MerchantStore.instance;

        // Filter orders by tab status
        final tabStatus = _selectedTab == 0
            ? 'Chờ nhận'
            : (_selectedTab == 1 ? 'Đã nhận' : 'Đã hủy');

        final ordersForTab = store.orders.where((o) => o.status == tabStatus).toList();

        // Search filtering
        final query = _searchController.text.trim().toLowerCase();
        final filteredOrders = query.isEmpty
            ? ordersForTab
            : ordersForTab.where((o) =>
                o.orderCode.toLowerCase().contains(query) ||
                o.customerName.toLowerCase().contains(query)).toList();

        // Subtitle dynamic text
        final subtitleText = _selectedTab == 0
            ? '${ordersForTab.length} khách sẽ đến trong khung 20:00–21:30.'
            : (_selectedTab == 1
                ? '${ordersForTab.length} đơn đã bàn giao thành công hôm nay.'
                : '${ordersForTab.length} đơn đã hủy theo yêu cầu.');

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: canPop
                ? Container(
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
                  )
                : null,
            title: Text(
              _selectedTab == 0
                  ? 'Đơn chờ nhận'
                  : (_selectedTab == 1 ? 'Đơn đã nhận' : 'Đơn đã hủy'),
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF183B2E),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE4E9E1)),
                    ),
                    child: Text(
                      'Đơn giao tận nơi',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF12543B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                        const SizedBox(height: 4),
                        Text(
                          _selectedTab == 0
                              ? 'Đơn chờ nhận'
                              : (_selectedTab == 1 ? 'Đơn đã nhận' : 'Đơn đã hủy'),
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitleText,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: const Color(0xFF718076),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 3 Tabs: Chờ nhận | Đã nhận | Đã hủy (Figma M23)
                        Container(
                          height: 41,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF0E3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildTabItem('Chờ nhận', 0),
                              _buildTabItem('Đã nhận', 1),
                              _buildTabItem('Đã hủy', 2),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Search box: Tìm theo mã đơn…
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE4E9E1)),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Icon(Icons.search, size: 18, color: Color(0xFF718076)),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (_) => setState(() {}),
                                  decoration: InputDecoration(
                                    hintText: 'Tìm theo mã đơn hoặc tên khách…',
                                    hintStyle: GoogleFonts.beVietnamPro(
                                      color: const Color(0xFF718076),
                                      fontSize: 12,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              if (_searchController.text.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 16, color: Color(0xFF718076)),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Empty State if no orders in this tab
                        if (filteredOrders.isEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(
                                  _selectedTab == 0
                                      ? Icons.hourglass_empty_rounded
                                      : (_selectedTab == 1
                                          ? Icons.check_circle_outline_rounded
                                          : Icons.cancel_outlined),
                                  size: 40,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _selectedTab == 0
                                      ? 'Không có đơn nào đang chờ nhận'
                                      : (_selectedTab == 1
                                          ? 'Chưa có đơn nào đã nhận'
                                          : 'Không có đơn hàng nào bị hủy'),
                                  style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
                                ),
                              ],
                            ),
                          ),

                        // Orders list matching Figma M23
                        ...filteredOrders.map((order) {
                          final isPending = order.status == 'Chờ nhận';
                          final isCompleted = order.status == 'Đã nhận';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE4E9E1)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '#${order.orderCode}',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: isPending
                                            ? const Color(0xFFFFE6CF)
                                            : (isCompleted
                                                ? const Color(0xFFEAF3DD)
                                                : const Color(0xFFFEEBE4)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        order.status,
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: isPending
                                              ? const Color(0xFF8F4C17)
                                              : (isCompleted
                                                  ? const Color(0xFF12543B)
                                                  : const Color(0xFFC13A23)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  order.customerName,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF183B2E),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  order.pickupTime,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 11,
                                    color: const Color(0xFF718076),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Divider(color: Color(0xFFE4E9E1), height: 1),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${currencyFormat.format(order.totalPrice)}đ',
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF183B2E),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // Interactive Action Button
                                        if (isPending) ...[
                                          // Trao túi button
                                          GestureDetector(
                                            onTap: () {
                                              store.completeOrder(order.orderCode);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Đã xác nhận trao túi cho ${order.customerName}!'),
                                                  backgroundColor: const Color(0xFF12543B),
                                                  duration: const Duration(seconds: 1),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF12543B),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Trao túi',
                                                style: GoogleFonts.beVietnamPro(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],

                                        // Chi tiết button
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/merchant-qr-valid',
                                              arguments: {'order': order},
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEAF3DD),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Chi tiết',
                                              style: GoogleFonts.beVietnamPro(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF12543B),
                                              ),
                                            ),
                                          ),
                                        ),

                                        if (!isPending) ...[
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              store.restoreOrder(order.orderCode);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Đã hoàn tác đơn #${order.orderCode} về Chờ nhận!'),
                                                  duration: const Duration(seconds: 1),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: const Color(0xFFE4E9E1)),
                                              ),
                                              child: Text(
                                                'Hoàn tác',
                                                style: GoogleFonts.beVietnamPro(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF718076),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Sticky Bottom CTA matching Figma M23: Quét mã nhận hàng
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFE4E9E1)),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12543B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/merchant-scanner'),
                      icon: const Icon(Icons.qr_code_scanner_rounded, size: 18),
                      label: Text(
                        'Quét mã nhận hàng',
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
          ),
        );
      },
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ),
      ),
    );
  }
}
