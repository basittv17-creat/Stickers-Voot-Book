import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stickers_voot_book/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('launch and retry remain on the channel screen', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Stickers 😀 🌹 Voot Book'), findsOneWidget);
    expect(find.text('Channel preview unavailable'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Channel preview unavailable'), findsOneWidget);
  });
}
