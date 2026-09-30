import 'package:flutter_test/flutter_test.dart';
import 'package:cricket/main.dart';

void main() {
  testWidgets('CricketApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CricketApp());

    // Verify splash screen title exists
    expect(find.text('CRICKET APP'), findsOneWidget);
  });
}
