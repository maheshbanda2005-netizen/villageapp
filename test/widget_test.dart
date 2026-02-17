import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:village_app/main.dart';
import 'package:village_app/data/sample_village_data.dart';

void main() {
  testWidgets('Village app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VillageApp());

    // Verify that the village name is displayed.
    expect(find.text(sampleVillage.name), findsAtLeast(1));

    // Verify that we start on the Home tab.
    expect(find.text('History'), findsOneWidget);

    // Tap on Demographics tab.
    await tester.tap(find.byIcon(Icons.analytics));
    await tester.pumpAndSettle();

    // Verify Demographics content.
    expect(find.text('Population Statistics'), findsOneWidget);

    // Tap on Facilities tab.
    await tester.tap(find.byIcon(Icons.account_balance));
    await tester.pumpAndSettle();

    // Verify Facilities content (Offices tab is default).
    expect(find.text('Offices'), findsOneWidget);
  });
}
