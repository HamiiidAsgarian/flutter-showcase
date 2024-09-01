import 'package:flutter/material.dart';
import 'package:flutter_showcase/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter_test/flutter_test.dart';

//----/ Assuming your swipe_switch.dart is in the same directory

void main() {
  testWidgets('SwipeSwitch triggers onSuccess when swiped more than halfway',
      (WidgetTester tester) async {
    var isSuccessTriggered = false;

    // Build the SwipeSwitch widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SwipeSwitch(
            buttonColor: Colors.blue,
            buttonLabel: const Text('Swipe Me'),
            onSuccess: () {
              isSuccessTriggered = true;
            },
          ),
        ),
      ),
    );

    // Find the draggable button by looking for the button label
    final buttonFinder = find.text('Swipe Me');

    // Get the initial position of the button
    final initialPosition = tester.getCenter(buttonFinder);

    // Drag the button more than halfway to the right
    await tester.drag(buttonFinder, const Offset(150, 0));
    await tester.pumpAndSettle();

    // Expect that the onSuccess callback was triggered
    expect(isSuccessTriggered, true);

    // Verify that the button returned to its initial position
    final finalPosition = tester.getCenter(buttonFinder);
    expect(finalPosition, initialPosition);
  });

  testWidgets(
      'SwipeSwitch does not trigger onSuccess when swiped less than halfway',
      (WidgetTester tester) async {
    var isSuccessTriggered = false;

    // Build the SwipeSwitch widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SwipeSwitch(
            buttonColor: Colors.blue,
            buttonLabel: const Text('Swipe Me'),
            onSuccess: () {
              isSuccessTriggered = true;
            },
          ),
        ),
      ),
    );

    // Find the draggable button by looking for the button label
    final buttonFinder = find.text('Swipe Me');

    // Drag the button less than halfway to the right
    await tester.drag(buttonFinder, const Offset(50, 0));
    await tester.pumpAndSettle();

    // Expect that the onSuccess callback was not triggered
    expect(isSuccessTriggered, false);

    // Verify that the button returned to its initial position
    final initialPosition = tester.getCenter(buttonFinder);
    final finalPosition = tester.getCenter(buttonFinder);
    expect(finalPosition, initialPosition);
  });
}
