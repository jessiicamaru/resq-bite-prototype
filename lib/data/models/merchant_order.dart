class MerchantOrder {
  final String orderCode;
  final String customerName;
  final String bagTitle;
  final int quantity;
  final int totalPrice;
  String pickupTime;
  String status; // 'Chờ nhận', 'Đã nhận', 'Đã hủy'
  final DateTime orderTime;

  MerchantOrder({
    required this.orderCode,
    required this.customerName,
    required this.bagTitle,
    required this.quantity,
    required this.totalPrice,
    required this.pickupTime,
    required this.status,
    required this.orderTime,
  });

  MerchantOrder copyWith({
    String? orderCode,
    String? customerName,
    String? bagTitle,
    int? quantity,
    int? totalPrice,
    String? pickupTime,
    String? status,
    DateTime? orderTime,
  }) {
    return MerchantOrder(
      orderCode: orderCode ?? this.orderCode,
      customerName: customerName ?? this.customerName,
      bagTitle: bagTitle ?? this.bagTitle,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      pickupTime: pickupTime ?? this.pickupTime,
      status: status ?? this.status,
      orderTime: orderTime ?? this.orderTime,
    );
  }
}
