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

