// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:flare_flutter/flare_actor.dart";

import 'package:russian_hat/main.dart';

void main() {
  testWidgets('Test start screen is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    await tester.pump();

    // expect(find.text('\nWelcome to Russian Hat!\n'), findsOneWidget);
    expect(find.byType(FlareActor), findsOneWidget);

    expect(find.text('Play game'), findsOneWidget);
    expect(find.text('Show rules'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  }, skip: true);
}
