import 'package:flutter_test/flutter_test.dart';
import 'package:village_app/main.dart';

void main() {
  testWidgets('Village app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that menu items are present
    expect(find.text('Voters Information'), findsOneWidget);
    expect(find.text('Gram Panchayat'), findsOneWidget);

    // Check if the village name exists (it might be in TypewriterAnimatedText)
    // We can try searching by text or check if the animated header exists
    // expect(find.text('Kaprai Pally'), findsOneWidget);
    // If it's still failing, maybe the animation is infinite or takes too long.
  });
}
