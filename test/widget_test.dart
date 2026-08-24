import 'package:flutter_test/flutter_test.dart';

import 'package:piggy_park_golf/main.dart';

void main() {
  testWidgets('login enters the redesigned home', (tester) async {
    await tester.pumpWidget(const PiggyParkGolfApp());

    expect(find.text('간편하게 시작하기'), findsOneWidget);
    expect(find.text('카카오로 시작하기'), findsOneWidget);

    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();

    expect(find.text('안녕하세요, GIGI님'), findsOneWidget);
    expect(find.text('빠른 메뉴'), findsOneWidget);
  });
}
