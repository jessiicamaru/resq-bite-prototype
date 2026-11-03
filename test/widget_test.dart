import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/core/theme/app_theme.dart';
import 'package:final_project/data/mock/mock_data.dart';
import 'package:final_project/features/consumer/orders/presentation/cart_checkout_screen.dart';
import 'package:final_project/features/consumer/profile/presentation/consumer_profile_screen.dart';
import 'package:final_project/features/merchant/scanner/presentation/merchant_qr_scanner_screen.dart';
import 'package:final_project/main.dart';

class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _FakeHttpOverrides();
  });

  testWidgets('ResQBitesApp smoke test - Initial Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ResQBitesApp());
    expect(find.text('Chào mừng đến ResQ Bites'), findsOneWidget);
  });

  testWidgets('ConsumerProfileScreen layout test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ConsumerProfileScreen(),
      ),
    );
    expect(find.byType(ConsumerProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CartCheckoutScreen layout test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: CartCheckoutScreen(
          bag: mockMysteryBags.first,
          quantity: 1,
        ),
      ),
    );
    expect(find.byType(CartCheckoutScreen), findsOneWidget);
    expect(find.text('Túi của bạn'), findsOneWidget);
  });

  testWidgets('MerchantQrScannerScreen layout test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const MerchantQrScannerScreen(),
      ),
    );
    expect(find.text('Quét mã nhận túi'), findsAtLeastNWidgets(1));
    expect(tester.takeException(), isNull);
  });
}
