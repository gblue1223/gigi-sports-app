import 'package:flutter_test/flutter_test.dart';

import 'package:piggy_park_golf/main.dart';

void main() {
  testWidgets('login enters the redesigned home', (tester) async {
    await tester.pumpWidget(const PiggyParkGolfApp());

    expect(find.text('라운드를 시작해볼까요?'), findsOneWidget);
    expect(find.text('카카오로 계속하기'), findsOneWidget);

    await tester.tap(find.text('카카오로 계속하기'));
    await tester.pumpAndSettle();

    expect(find.text('GIGI님,\n좋은 라운드 준비되셨나요?'), findsOneWidget);
    expect(find.text('바로가기'), findsOneWidget);
  });
}
