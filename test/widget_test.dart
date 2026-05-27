
import 'package:flutter_test/flutter_test.dart';

import 'package:careconnect/main.dart';

void main() {
  testWidgets('renders splash screen title', (tester) async {
    await tester.pumpWidget(const CareConnectApp());
    await tester.pump(); // settle initial frame

    expect(find.text('CareConnect'), findsOneWidget);
  });
}
