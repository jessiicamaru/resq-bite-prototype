import 'package:flutter/foundation.dart';
import '../mock/mock_data.dart';
import '../models/consumer_order.dart';
import '../models/food_bag.dart';

class OrderStore extends ChangeNotifier {
  static final OrderStore instance = OrderStore._internal();
  factory OrderStore() => instance;

  OrderStore._internal() {
    _initData();
  }

  late List<MysteryBag> bags;
  final List<ConsumerOrder> orders = [];
  ConsumerOrder? activeOrder;

  // Draft checkout state
  MysteryBag? draftBag;
  int draftQuantity = 1;
  String draftNotes = '';
  bool draftBringOwnBag = true;
  String draftPayment = 'MoMo';
  bool draftIsDelivery = false;

  void _initData() {
    bags = mockMysteryBags.map((b) => b.copyWith()).toList();
    draftBag = bags.isNotEmpty ? bags.first : mockMysteryBags.first;

    // Initial seed order matching Figma prototype #RB-1024
    final initialBag = bags.first;
    final seedOrder = ConsumerOrder(
      orderCode: 'RB-1024',
      bag: initialBag,
      quantity: 1,
      paymentMethod: 'MoMo',
      orderTime: DateTime.now(),
      pickupWindow: initialBag.pickupWindow,
      notes: 'Không cần dụng cụ ăn uống',
      bringOwnBag: true,
      isDelivery: false,
      status: OrderStatus.paid,
    );
    orders.add(seedOrder);
    activeOrder = seedOrder;
  }

  void setDraftBag(MysteryBag bag) {
    draftBag = bag;
    draftQuantity = 1;
    notifyListeners();
  }

  void updateDraftQuantity(int qty) {
    draftQuantity = qty;
    notifyListeners();
  }

  void updateDraftNotes(String notes) {
    draftNotes = notes;
    notifyListeners();
  }

  void updateDraftBringOwnBag(bool val) {
    draftBringOwnBag = val;
    notifyListeners();
  }

  void updateDraftPayment(String payment) {
    draftPayment = payment;
    notifyListeners();
  }

  ConsumerOrder placeOrder({
    required MysteryBag bag,
    required int quantity,
    required String paymentMethod,
    String? notes,
    bool bringOwnBag = true,
    bool isDelivery = false,
  }) {
    // Deduct stock from the store bag
    final bagIdx = bags.indexWhere((b) => b.id == bag.id);
    if (bagIdx != -1) {
      final current = bags[bagIdx];
      final newRemaining = (current.remainingBags - quantity).clamp(0, 999);
      bags[bagIdx] = current.copyWith(remainingBags: newRemaining);
    }

    final newOrder = ConsumerOrder(
      orderCode: 'RB-1024',
      bag: bagIdx != -1 ? bags[bagIdx] : bag,
      quantity: quantity,
      paymentMethod: paymentMethod,
      orderTime: DateTime.now(),
      pickupWindow: bag.pickupWindow,
      notes: notes,
      bringOwnBag: bringOwnBag,
      isDelivery: isDelivery,
      status: OrderStatus.paid,
    );

    // Replace if RB-1024 already present or add to top
    orders.removeWhere((o) => o.orderCode == newOrder.orderCode);
    orders.insert(0, newOrder);
    activeOrder = newOrder;

    notifyListeners();
    return newOrder;
  }

  void requestCancel(String orderCode, {required String reason, String? notes}) {
    final idx = orders.indexWhere((o) => o.orderCode == orderCode);
    if (idx != -1) {
      orders[idx].status = OrderStatus.cancelRequested;
      orders[idx].cancelReason = reason;
      orders[idx].cancelNotes = notes;

      // Restock the bag
      final bagId = orders[idx].bag.id;
      final bagIdx = bags.indexWhere((b) => b.id == bagId);
      if (bagIdx != -1) {
        final current = bags[bagIdx];
        bags[bagIdx] = current.copyWith(
          remainingBags: current.remainingBags + orders[idx].quantity,
        );
      }

      if (activeOrder?.orderCode == orderCode) {
        activeOrder = orders[idx];
      }
      notifyListeners();
    }
  }

  void submitReview(String orderCode, {required int rating, required List<String> tags, String? comment}) {
    final idx = orders.indexWhere((o) => o.orderCode == orderCode);
    if (idx != -1) {
      orders[idx].status = OrderStatus.reviewed;
      orders[idx].rating = rating;
      orders[idx].reviewTags = tags;
      orders[idx].reviewComment = comment;
      if (activeOrder?.orderCode == orderCode) {
        activeOrder = orders[idx];
      }
      notifyListeners();
    }
  }

  void reset() {
    orders.clear();
    _initData();
    notifyListeners();
  }
}
