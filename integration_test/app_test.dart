import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vase/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('onboarding screen test',
        (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final btn = find.text("Get Started");

      await tester.tap(btn);

      await tester.pumpAndSettle();

      await tester.tap(find.text('Take me there !!'));
      await tester.pumpAndSettle();
      expect(find.text('Transactions'), findsOneWidget);
    });
  });
}
