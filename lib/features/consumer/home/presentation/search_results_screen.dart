import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../data/models/food_bag.dart';

class SearchResultsScreen extends StatefulWidget {
  final String initialQuery;
  const SearchResultsScreen({super.key, this.initialQuery = 'bánh'});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final TextEditingController _searchController;
  final currencyFormat = NumberFormat('#,###', 'vi_VN');

  final List<String> _suggestedKeywords = [
    'Bánh mì',
    'Cơm tấm',
    'Salad chay',
    'Trà sữa',
    'Trái cây',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final results = mockMysteryBags.where((b) {
      if (query.isEmpty) return true;
      return b.title.toLowerCase().contains(query) ||
          b.storeName.toLowerCase().contains(query) ||
          b.category.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: false,
              style: GoogleFonts.beVietnamPro(fontSize: 13, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Tìm món ngon, cửa hàng…',
                hintStyle: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search_rounded, size: 18, color: AppColors.textMuted),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16, color: AppColors.textMuted),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Suggested keywords horizontal
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _suggestedKeywords.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final kw = _suggestedKeywords[index];
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = kw;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          kw,
                          style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Tìm thấy ${results.length} túi đồ ăn phù hợp',
                style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textMuted),
              ),
            ),

            // Results List or Empty State
            Expanded(
              child: results.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: results.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return _buildResultCard(context, results[index]);
                      },
                    )
                  : _buildEmptyState(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, MysteryBag bag) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/bag-detail', arguments: bag),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                bag.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
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
                        '${bag.category} · ${bag.distanceKm} km',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, color: AppColors.textSecondary),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
                          const SizedBox(width: 2),
                          Text(
                            bag.rating.toString(),
                            style: GoogleFonts.beVietnamPro(fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bag.storeName,
                    style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  Text(
                    bag.title,
                    style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${currencyFormat.format(bag.rescuePrice)}đ',
                        style: GoogleFonts.beVietnamPro(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${currencyFormat.format(bag.originalPrice)}đ',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Còn ${bag.remainingBags} túi',
                        style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search_off_rounded, size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa tìm thấy túi phù hợp',
              style: GoogleFonts.beVietnamPro(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              'Thử tìm với từ khóa khác hoặc chuyển sang xem các túi đang mở bán quanh bạn nhé!',
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
              child: const Text('Xem tất cả các túi'),
            ),
          ],
        ),
      ),
    );
  }
}

