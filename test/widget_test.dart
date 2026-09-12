import 'package:flutter_test/flutter_test.dart';

import 'package:physioghar/features/app/app.dart';

void main() {
  testWidgets('PhysioGhar app loads through GoRouter', (tester) async {
    await tester.pumpWidget(const PhysioGharApp());
    await tester.pumpAndSettle();

    expect(find.text('PhysioGhar'), findsOneWidget);
    expect(find.text('THERAPIST APP'), findsOneWidget);
  });
}
