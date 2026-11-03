import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/core/theme/app_theme.dart';
import 'package:final_project/features/consumer/profile/presentation/consumer_profile_screen.dart';
import 'package:final_project/features/merchant/scanner/presentation/merchant_qr_scanner_screen.dart';
import 'package:final_project/main.dart';

void main() {
  testWidgets('ResQBitesApp smoke test - Initial Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ResQBitesApp());
    expect(find.text('Chào mừng đến ResQ Bites'), findsOneWidget);
  });

  testWidgets('ConsumerProfileScreen layout test - No infinite width assertion', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ConsumerProfileScreen(),
      ),
    );
    expect(find.byType(ConsumerProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('MerchantQrScannerScreen layout test - No unconstrained button assertion', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const MerchantQrScannerScreen(),
      ),
    );
    expect(find.text('Quét mã nhận túi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
