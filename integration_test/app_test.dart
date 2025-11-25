import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('placeholder test', (WidgetTester tester) async {
      // O teste de integração começará aqui.
      expect(true, isTrue);
    });
  });
}
