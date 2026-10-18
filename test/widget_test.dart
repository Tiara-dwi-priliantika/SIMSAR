
import 'package:flutter_test/flutter_test.dart';
import 'package:simsar/main.dart';

void main() {
  testWidgets('SIMSAR menampilkan halaman login', (
    WidgetTester tester,
  ) async {
    // Menampilkan aplikasi SIMSAR
    await tester.pumpWidget(const SimSarApp());

    // Memastikan halaman login muncul
    expect(find.text('Selamat Datang di SIMSAR'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
