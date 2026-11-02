import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MerchantStaffSettingsScreen extends StatefulWidget {
  const MerchantStaffSettingsScreen({super.key});

  @override
  State<MerchantStaffSettingsScreen> createState() => _MerchantStaffSettingsScreenState();
}

class _MerchantStaffSettingsScreenState extends State<MerchantStaffSettingsScreen> {
  final List<Map<String, dynamic>> _staffList = [
    {
      'name': 'Nguyễn Mai Anh',
      'role': 'Chủ quán / Quản lý chính',
      'phone': '0905 123 456',
      'canScan': true,
      'canManageBags': true,
      'isOwner': true,
    },
    {
      'name': 'Trần Quốc Tuấn',
      'role': 'Trưởng ca tối (20:00 - 22:30)',
      'phone': '0914 987 654',
      'canScan': true,
      'canManageBags': true,
      'isOwner': false,
    },
    {
      'name': 'Lê Thị Diệu',
      'role': 'Nhân viên thu ngân',
      'phone': '0935 444 888',
      'canScan': true,
      'canManageBags': false,
      'isOwner': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ecoIvory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.forestGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nhân sự cửa hàng (M44)',
          style: GoogleFonts.beVietnamPro(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.forestGreen.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.badge_outlined, color: AppColors.forestGreen, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PHÂN QUYỀN VẬN HÀNH NHANH',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forestGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Nhân viên ca tối chỉ cần mở màn hình Quét QR để đối chiếu mã vé của khách trong 5 giây.',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Danh sách nhân sự (${_staffList.length})',
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: 12),
            ..._staffList.map((staff) {
              final isOwner = staff['isOwner'] as bool;
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: isOwner ? AppColors.forestGreen : Colors.grey.shade200,
                      child: Text(
                        (staff['name'] as String).substring(0, 1),
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w700,
                          color: isOwner ? Colors.white : AppColors.charcoal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                staff['name'] as String,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.charcoal,
                                ),
                              ),
                              if (isOwner) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.forestGreen.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Chủ quán',
                                    style: GoogleFonts.beVietnamPro(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.forestGreen),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staff['role'] as String,
                            style: GoogleFonts.beVietnamPro(fontSize: 12, color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.qr_code, size: 14, color: AppColors.forestGreen),
                              const SizedBox(width: 4),
                              Text(
                                'Quyền quét mã: Bật',
                                style: GoogleFonts.beVietnamPro(fontSize: 11, color: AppColors.forestGreen, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chức năng thêm nhân sự: Gửi mã mời qua Zalo hoặc SĐT')),
                );
              },
              icon: const Icon(Icons.person_add_alt_outlined, color: AppColors.forestGreen),
              label: Text(
                'Thêm nhân viên ca tối',
                style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: AppColors.forestGreen),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: AppColors.forestGreen, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

