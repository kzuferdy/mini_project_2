import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter screen test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Counter Value: 0'),
        ),
      ),
    ));

    // Verify the text is present
    expect(find.text('Counter Value: 0'), findsOneWidget);
  });
}
