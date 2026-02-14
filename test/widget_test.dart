import 'package:flutter_test/flutter_test.dart';

import 'package:oson_bozorlik/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const OsonBozorlikApp());
    await tester.pumpAndSettle();

    expect(find.text('Зарафшан'), findsOneWidget);
    expect(find.text('Фрукты'), findsOneWidget);
  });
}
