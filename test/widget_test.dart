import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitness_app/main.dart';

void main() {
  testWidgets('Sign-up app provides Material directionality', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SignUpApp());

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
