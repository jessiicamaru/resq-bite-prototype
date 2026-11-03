class MysteryBag {
  final String id;
  final String title;
  final String storeName;
  final String storeAddress;
  final String category;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final int rescuePrice;
  final int originalPrice;
  final String pickupWindow;
  final String pickupCountdown;
  final int remainingBags;
  final String imageUrl;
  final String description;
  final List<String> possibleItems;
  final List<String> allergyNotice;
  final String merchantStory;

  const MysteryBag({
    required this.id,
    required this.title,
    required this.storeName,
    required this.storeAddress,
    required this.category,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.rescuePrice,
    required this.originalPrice,
    required this.pickupWindow,
    required this.pickupCountdown,
    required this.remainingBags,
    required this.imageUrl,
    required this.description,
    required this.possibleItems,
    required this.allergyNotice,
    required this.merchantStory,
  });

  int get discountPercent =>
      (((originalPrice - rescuePrice) / originalPrice) * 100).round();

  MysteryBag copyWith({
    String? id,
    String? title,
    String? storeName,
    String? storeAddress,
    String? category,
    double? distanceKm,
    double? rating,
    int? reviewCount,
    int? rescuePrice,
    int? originalPrice,
    String? pickupWindow,
    String? pickupCountdown,
    int? remainingBags,
    String? imageUrl,
    String? description,
    List<String>? possibleItems,
    List<String>? allergyNotice,
    String? merchantStory,
  }) {
    return MysteryBag(
      id: id ?? this.id,
      title: title ?? this.title,
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      category: category ?? this.category,
      distanceKm: distanceKm ?? this.distanceKm,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      rescuePrice: rescuePrice ?? this.rescuePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      pickupWindow: pickupWindow ?? this.pickupWindow,
      pickupCountdown: pickupCountdown ?? this.pickupCountdown,
      remainingBags: remainingBags ?? this.remainingBags,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      possibleItems: possibleItems ?? this.possibleItems,
      allergyNotice: allergyNotice ?? this.allergyNotice,
      merchantStory: merchantStory ?? this.merchantStory,
    );
  }
}

class GreenImpact {
  final int rescuedMeals;
  final int totalSavedVnd;
  final double co2ReducedKg;
  final String ambassadorRank;

  const GreenImpact({
    required this.rescuedMeals,
    required this.totalSavedVnd,
    required this.co2ReducedKg,
    required this.ambassadorRank,
  });
}

