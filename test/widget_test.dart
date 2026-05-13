import 'package:flutter_test/flutter_test.dart';
import 'package:hotel/main.dart';

void main() {
  testWidgets('affiche la page principale', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Accueil'), findsOneWidget);
    expect(find.textContaining('Trouves'), findsOneWidget);
  });
}
