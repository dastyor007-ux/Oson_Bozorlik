import 'package:flutter_test/flutter_test.dart';

import 'package:oson_bozorlik/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const OsonBozorlikApp());

    expect(find.text('Выберите адрес'), findsOneWidget);
    expect(find.text('Выберите категорию товаров'), findsOneWidget);
  });
}
