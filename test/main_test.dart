import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sayit/main.dart';
import '../lib/pages/ConversationPageList.dart';

void main() {
  testWidgets('Main UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SayIt());

    expect(find.byType(ConversationPageList), findsOneWidget);
  });
}
