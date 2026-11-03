import 'package:flutter/foundation.dart';

class MerchantBag {
  final String id;
  String title;
  String category;
  String description;
  int originalPrice;
  int rescuePrice;
  String pickupDate;
  String startTime;
  String endTime;
  String closeTime;
  int remainingQuantity;
  int orderedCount;
  String allergies;
  String storageGuide;
  String pickupGuide;
  String notes;
  bool isSelling;
  bool isDraft;
  String image;

  MerchantBag({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.originalPrice,
    required this.rescuePrice,
    required this.pickupDate,
    required this.startTime,
    required this.endTime,
    required this.closeTime,
    required this.remainingQuantity,
    this.orderedCount = 0,
    required this.allergies,
    required this.storageGuide,
    required this.pickupGuide,
    required this.notes,
    this.isSelling = true,
    this.isDraft = false,
    required this.image,
  });

  int get discountPercent => originalPrice > 0
      ? (((originalPrice - rescuePrice) / originalPrice) * 100).round()
      : 0;

  MerchantBag copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    int? originalPrice,
    int? rescuePrice,
    String? pickupDate,
    String? startTime,
    String? endTime,
    String? closeTime,
    int? remainingQuantity,
    int? orderedCount,
    String? allergies,
    String? storageGuide,
    String? pickupGuide,
    String? notes,
    bool? isSelling,
    bool? isDraft,
    String? image,
  }) {
    return MerchantBag(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      originalPrice: originalPrice ?? this.originalPrice,
      rescuePrice: rescuePrice ?? this.rescuePrice,
      pickupDate: pickupDate ?? this.pickupDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      closeTime: closeTime ?? this.closeTime,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      orderedCount: orderedCount ?? this.orderedCount,
      allergies: allergies ?? this.allergies,
      storageGuide: storageGuide ?? this.storageGuide,
      pickupGuide: pickupGuide ?? this.pickupGuide,
      notes: notes ?? this.notes,
      isSelling: isSelling ?? this.isSelling,
      isDraft: isDraft ?? this.isDraft,
      image: image ?? this.image,
    );
  }
}

class MerchantStore extends ChangeNotifier {
  static final MerchantStore instance = MerchantStore._internal();
  factory MerchantStore() => instance;

  MerchantStore._internal() {
    _initData();
  }

  bool isOpen = true;

  // Closing shift checklist
  bool checklistHandedOver = true;
  bool checklistInventoryUpdated = false;
  bool checklistSanitized = false;

  late List<MerchantBag> bags;
  late MerchantBag draftBag;

  void _initData() {
    bags = [
      MerchantBag(
        id: 'mb_01',
        title: 'Túi bánh cuối ngày',
        category: 'Bánh mì & bánh ngọt',
        description: 'Bánh còn dư được chọn trong ngày',
        originalPrice: 100000,
        rescuePrice: 35000,
        pickupDate: 'Hôm nay, 22/10',
        startTime: '20:00',
        endTime: '21:30',
        closeTime: '22:00',
        remainingQuantity: 4,
        orderedCount: 2,
        allergies: 'Sữa, trứng, gluten, hạt',
        storageGuide: 'Làm theo nhãn từng món',
        pickupGuide: 'Quầy bên phải cửa chính',
        notes: 'Không đảm bảo loại trừ dị nguyên',
        isSelling: true,
        image: 'assets/images/hero_c01.png',
      ),
      MerchantBag(
        id: 'mb_02',
        title: 'Bữa cơm nhà ấm bụng',
        category: 'Cơm phần & món mặn',
        description: 'Suất cơm gia đình thơm ngon cuối ngày',
        originalPrice: 95000,
        rescuePrice: 39000,
        pickupDate: 'Hôm nay, 22/10',
        startTime: '19:30',
        endTime: '21:00',
        closeTime: '21:30',
        remainingQuantity: 3,
        orderedCount: 1,
        allergies: 'Hải sản, đậu phộng',
        storageGuide: 'Dùng ngay trong 2 giờ',
        pickupGuide: 'Quầy nhận cơm số 2',
        notes: 'Đã bao gồm hộp sinh học',
        isSelling: true,
        image: 'assets/images/hero_c02.png',
      ),
    ];
    _resetDraftBag();
  }

  void _resetDraftBag() {
    draftBag = MerchantBag(
      id: 'mb_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Túi bánh cuối ngày',
      category: 'Bánh mì & bánh ngọt',
      description: 'Bánh còn dư được chọn trong ngày',
      originalPrice: 100000,
      rescuePrice: 35000,
      pickupDate: 'Hôm nay, 22/10',
      startTime: '20:00',
      endTime: '21:30',
      closeTime: '22:00',
      remainingQuantity: 4,
      orderedCount: 0,
      allergies: 'Sữa, trứng, gluten, hạt',
      storageGuide: 'Làm theo nhãn từng món',
      pickupGuide: 'Quầy bên phải cửa chính',
      notes: 'Không đảm bảo loại trừ dị nguyên',
      isSelling: true,
      image: 'assets/images/hero_c01.png',
    );
  }

  void toggleStoreOpen() {
    isOpen = !isOpen;
    notifyListeners();
  }

  void toggleChecklistHandedOver() {
    checklistHandedOver = !checklistHandedOver;
    notifyListeners();
  }

  void toggleChecklistInventoryUpdated() {
    checklistInventoryUpdated = !checklistInventoryUpdated;
    notifyListeners();
  }

  void toggleChecklistSanitized() {
    checklistSanitized = !checklistSanitized;
    notifyListeners();
  }

  void updateBagQuantity(String id, int newQuantity) {
    final idx = bags.indexWhere((b) => b.id == id);
    if (idx != -1) {
      bags[idx].remainingQuantity = newQuantity.clamp(0, 999);
      notifyListeners();
    }
  }

  void toggleBagSelling(String id) {
    final idx = bags.indexWhere((b) => b.id == id);
    if (idx != -1) {
      bags[idx].isSelling = !bags[idx].isSelling;
      notifyListeners();
    }
  }

  void updateDraftBag(MerchantBag updated) {
    draftBag = updated;
    notifyListeners();
  }

  void saveDraftBag() {
    bags.add(draftBag);
    _resetDraftBag();
    notifyListeners();
  }
}
