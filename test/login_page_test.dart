import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_bazaar/login_page.dart';

Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: LoginPage())
);

void main() {
  testWidgets('test that guest screen is showed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidget);

    expect(find.widgetWithText(RaisedButton, 'Login'), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(3));
  });
}
