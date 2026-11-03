import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/consumer_order.dart';
import '../../../../data/store/order_store.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: OrderStore.instance,
      builder: (context, _) {
        final store = OrderStore.instance;
        final activeOrders = store.orders.where((o) => o.status == OrderStatus.paid).toList();
        final completedOrders = store.orders.where((o) => o.status == OrderStatus.completed || o.status == OrderStatus.reviewed).toList();
        final cancelledOrders = store.orders.where((o) => o.status == OrderStatus.cancelled || o.status == OrderStatus.cancelRequested).toList();

        return DefaultTabController(
          length: 3,
          child: Scaffold(
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
                'Quản Lý Đơn Hàng',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183B2E),
                ),
              ),
              centerTitle: false,
              bottom: TabBar(
                labelColor: const Color(0xFF12543B),
                unselectedLabelColor: const Color(0xFF718076),
                indicatorColor: const Color(0xFF12543B),
                indicatorWeight: 3,
                labelStyle: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700),
                unselectedLabelStyle: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w500),
                tabs: [
                  Tab(text: 'Chờ lấy (${activeOrders.length})'),
                  Tab(text: 'Đã nhận (${completedOrders.length})'),
                  Tab(text: 'Đã hủy (${cancelledOrders.length})'),
                ],
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildOrdersList(context, activeOrders, isActionable: true),
                        _buildCompletedList(context, completedOrders),
                        _buildCancelledList(context, cancelledOrders),
                      ],
                    ),
                  ),
                  _buildBottomNav(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrdersList(BuildContext context, List<ConsumerOrder> orders, {required bool isActionable}) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'Chưa có đơn hàng nào chờ lấy.',
          style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
        ),
      );
    }

    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E9E1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF2EB),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order.statusTitle,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF12543B),
                      ),
                    ),
                  ),
                  Text(
                    'Mã: #${order.orderCode}',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF718076),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/hero_c01.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 64,
                        height: 64,
                        color: const Color(0xFFEAF3DD),
                        child: const Icon(Icons.bakery_dining_rounded, color: Color(0xFF12543B)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.bag.storeName,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
                          ),
                        ),
                        Text(
                          order.bag.title,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: const Color(0xFF718076),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${currencyFormat.format(order.rescueTotal)}đ · x${order.quantity} túi',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF183B2E),
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
                  color: const Color(0xFFF1F6EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF12543B)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Khung giờ nhận: ${order.pickupWindow} hôm nay',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF183B2E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12543B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/order-qr',
                      arguments: {
                        'bag': order.bag,
                        'quantity': order.quantity,
                      },
                    );
                  },
                  icon: const Icon(Icons.qr_code_rounded, size: 18),
                  label: const Text('Xuất trình mã QR tại quầy'),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE4E9E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/order-receipt',
                          arguments: {
                            'bag': order.bag,
                            'quantity': order.quantity,
                            'orderCode': order.orderCode,
                          },
                        );
                      },
                      icon: const Icon(Icons.receipt_outlined, size: 16, color: Color(0xFF183B2E)),
                      label: Text(
                        'Biên nhận',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF183B2E)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFA23F2A)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/cancel-order',
                          arguments: {
                            'bag': order.bag,
                            'orderCode': order.orderCode,
                          },
                        );
                      },
                      icon: const Icon(Icons.cancel_outlined, size: 16, color: Color(0xFFA23F2A)),
                      label: Text(
                        'Hủy đơn',
                        style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFFA23F2A)),
                      ),
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

  Widget _buildCompletedList(BuildContext context, List<ConsumerOrder> orders) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ...orders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE4E9E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF2EB),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'ĐÃ NHẬN THÀNH CÔNG',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF12543B)),
                      ),
                    ),
                    Text(
                      '#${order.orderCode}',
                      style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/hero_c01.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.bag.storeName,
                            style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
                          ),
                          Text(
                            order.bag.title,
                            style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                          ),
                          Text(
                            '${currencyFormat.format(order.rescueTotal)}đ',
                            style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF12543B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/order-review',
                        arguments: {
                          'bag': order.bag,
                          'orderCode': order.orderCode,
                        },
                      );
                    },
                    child: Text(
                      order.status == OrderStatus.reviewed ? 'Xem đánh giá của bạn' : 'Đánh giá túi đồ ăn',
                      style: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCancelledList(BuildContext context, List<ConsumerOrder> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'Chưa có đơn hàng nào bị hủy.',
          style: GoogleFonts.beVietnamPro(fontSize: 13, color: const Color(0xFF718076)),
        ),
      );
    }

    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return ListView(
      padding: const EdgeInsets.all(20),
      children: orders.map((order) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E9E1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEEBE4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order.statusTitle,
                      style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFFC13A23)),
                    ),
                  ),
                  Text(
                    '#${order.orderCode}',
                    style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/hero_c01.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.bag.storeName,
                          style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
                        ),
                        Text(
                          order.bag.title,
                          style: GoogleFonts.beVietnamPro(fontSize: 12, color: const Color(0xFF718076)),
                        ),
                        Text(
                          '${currencyFormat.format(order.rescueTotal)}đ',
                          style: GoogleFonts.beVietnamPro(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF183B2E)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (order.cancelReason != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Lý do: ${order.cancelReason}',
                  style: GoogleFonts.beVietnamPro(fontSize: 11, color: const Color(0xFF718076)),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE4E9E1))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, 0, Icons.home_outlined, 'Khám phá', false, () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
          }),
          _navItem(context, 1, Icons.map_outlined, 'Bản đồ', false, () {
            Navigator.pushNamed(context, '/map-explorer');
          }),
          _navItem(context, 2, Icons.shopping_bag, 'Đơn hàng', true, () {}),
          _navItem(context, 3, Icons.person_outline, 'Tài khoản', false, () {
            Navigator.pushNamed(context, '/consumer-profile');
          }),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF12543B) : const Color(0xFF718076),
            ),
          ),
        ],
      ),
    );
  }
}
