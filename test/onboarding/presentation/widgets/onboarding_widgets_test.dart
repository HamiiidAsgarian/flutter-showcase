import 'package:flutter/material.dart';
import 'package:flutter_showcase/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('SwipeSwitch Golden Tests', () {
    testGoldens('SwipeSwitch initial state', (WidgetTester tester) async {
      // Define the widget to be tested
      final widget = SwipeSwitch(
        buttonColor: Colors.blue,
        buttonLabel: const Text('Swipe Me'),
        onSuccess: () {},
      );

      // Wrap the widget in a MaterialApp and Scaffold
      final builder = GoldenBuilder.grid(
        columns: 1,
        widthToHeightRatio: 4 / 3,
      )..addScenario('Initial State', widget);

      // Build the widget for testing
      await tester.pumpWidgetBuilder(builder.build());

      // Compare the widget's rendering with the golden file
      await screenMatchesGolden(tester, 'swipe_switch_initial');
    });

    testGoldens('SwipeSwitch swiped state', (WidgetTester tester) async {
      // Define the widget to be tested
      final widget = SwipeSwitch(
        buttonColor: Colors.blue,
        buttonLabel: const Text('Swipe Me'),
        onSuccess: () {},
      );

      // Wrap the widget in a MaterialApp and Scaffold
      await tester.pumpWidgetBuilder(
        Scaffold(
          body: Center(child: widget),
        ),
      );

      // Drag the button halfway to simulate the swipe
      final buttonFinder = find.text('Swipe Me');
      await tester.drag(buttonFinder, const Offset(100, 0));
      await tester.pumpAndSettle();

      // Compare the swiped state with the golden file
      await screenMatchesGolden(tester, 'swipe_switch_swiped');
    });
  });
}
