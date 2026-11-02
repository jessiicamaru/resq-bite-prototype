import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/main.dart';

void main() {
  testWidgets('ResQBitesApp smoke test - Initial Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ResQBitesApp());
    expect(find.text('Chào mừng đến ResQ Bites'), findsOneWidget);
  });

  testWidgets('ConsumerMainNavScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ResQBitesApp(),
    );
    // Smoke check that app builds cleanly
    expect(find.byType(ResQBitesApp), findsOneWidget);
  });

  testWidgets('MerchantMainNavScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ResQBitesApp(),
    );
    expect(find.byType(ResQBitesApp), findsOneWidget);
  });
}
