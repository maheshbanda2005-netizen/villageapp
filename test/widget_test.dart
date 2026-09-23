import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mana_gramam/main.dart';
import 'package:mana_gramam/screens/new_home_screen.dart';
import 'package:mana_gramam/screens/notifications_screen.dart';
import 'package:mana_gramam/screens/village_gallery_screen.dart';
import 'package:mana_gramam/screens/village_selection_screen.dart';
import 'package:mana_gramam/screens/voice_assistant_screen.dart';
import 'package:mana_gramam/theme/mana_gramam_theme.dart';

void main() {
  testWidgets('NewHomeScreen renders home tab with services', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ManaTheme.data(),
      home: const NewHomeScreen(isTelugu: false),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Village Services'), findsOneWidget);
  });
  testWidgets('App launches splash with Get Started', (WidgetTester tester) async {
    await tester.pumpWidget(const ManaGramamApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1800));

    expect(find.text('Mana Gramam'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('VillageSelectionScreen renders with options', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ManaTheme.data(),
      home: const VillageSelectionScreen(),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Select Your Village'), findsOneWidget);
    expect(find.text('Farmer'), findsOneWidget);
  });

  testWidgets('NotificationsScreen renders with categories', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ManaTheme.data(),
      home: const NotificationsScreen(),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Water Supply Update'), findsOneWidget);
  });

  testWidgets('VoiceAssistantScreen renders with prompts', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ManaTheme.data(),
      home: const VoiceAssistantScreen(),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Ask Mana Gramam'), findsWidgets);
    expect(find.text('Where is the nearest hospital?'), findsOneWidget);
  });

  testWidgets('VillageGalleryScreen renders unified gallery and filters', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ManaTheme.data(),
      home: const VillageGalleryScreen(),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Our Village Gallery'), findsOneWidget);
    expect(find.text('Search village fields, temples, places…'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Village Fields & Crop Lands'), findsOneWidget);

    // Tap Animals chip and verify Animals item is shown
    await tester.tap(find.text('Animals'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Village Cattle, Buffaloes & Sheep'), findsOneWidget);
  });
}
