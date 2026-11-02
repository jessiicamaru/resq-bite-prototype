import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/main.dart';

void main() {
  testWidgets('ResQBitesApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ResQBitesApp());
    expect(find.text('Chào mừng đến ResQ Bites'), findsOneWidget);
  });
}
