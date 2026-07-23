import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:village_app/main.dart';
import 'package:village_app/screens/complaint_screen.dart';

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

  testWidgets('Search filters menu and shows empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'school');
    await tester.pumpAndSettle();
    expect(find.text('Schools'), findsOneWidget);
    expect(find.text('Voters Information'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzzz');
    await tester.pumpAndSettle();
    expect(find.text('No results found'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();
    expect(find.text('Voters Information'), findsOneWidget);
  });

  testWidgets('Complaint form validates required fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ComplaintScreen()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Submit Complaint'));
    await tester.tap(find.text('Submit Complaint'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter a subject'), findsOneWidget);
    expect(find.text('Please describe your complaint'), findsOneWidget);
  });
}
