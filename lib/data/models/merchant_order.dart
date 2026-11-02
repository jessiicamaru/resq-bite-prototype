class MerchantOrder {
  final String orderCode;
  final String customerName;
  final String bagTitle;
  final int quantity;
  final int totalPrice;
  final String pickupTime;
  final String status; // 'pending', 'completed', 'expired'
  final DateTime orderTime;

  const MerchantOrder({
    required this.orderCode,
    required this.customerName,
    required this.bagTitle,
    required this.quantity,
    required this.totalPrice,
    required this.pickupTime,
    required this.status,
    required this.orderTime,
  });
}

