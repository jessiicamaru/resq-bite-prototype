import 'food_bag.dart';

enum OrderStatus {
  paid,           // SẴN SÀNG NHẬN TÚI
  cancelRequested,// Chờ xét yêu cầu hủy
  cancelled,      // Đã hủy đơn
  completed,      // Đã nhận hàng thành công
  reviewed,       // Đã gửi đánh giá
}

class ConsumerOrder {
  final String orderCode;
  final MysteryBag bag;
  final int quantity;
  final String paymentMethod;
  final DateTime orderTime;
  final String pickupWindow;
  final String? notes;
  final bool bringOwnBag;
  final bool isDelivery;
  OrderStatus status;
  String? cancelReason;
  String? cancelNotes;
  int? rating;
  List<String> reviewTags;
  String? reviewComment;

  ConsumerOrder({
    required this.orderCode,
    required this.bag,
    required this.quantity,
    required this.paymentMethod,
    required this.orderTime,
    required this.pickupWindow,
    this.notes,
    this.bringOwnBag = true,
    this.isDelivery = false,
    this.status = OrderStatus.paid,
    this.cancelReason,
    this.cancelNotes,
    this.rating,
    this.reviewTags = const [],
    this.reviewComment,
  });

  int get originalTotal => bag.originalPrice * quantity;
  int get rescueTotal => bag.rescuePrice * quantity;
  int get savings => originalTotal - rescueTotal;

  String get statusTitle {
    switch (status) {
      case OrderStatus.paid:
        return 'SẴN SÀNG NHẬN TÚI';
      case OrderStatus.cancelRequested:
        return 'Chờ xét yêu cầu hủy';
      case OrderStatus.cancelled:
        return 'Đã hủy';
      case OrderStatus.completed:
        return 'Đã hoàn tất';
      case OrderStatus.reviewed:
        return 'Đã đánh giá';
    }
  }
}
