import 'package:app_hoc_tieng_anh/main.dart';
import 'package:app_hoc_tieng_anh/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('validates email format', () {
    expect(AuthService.isValidEmail('@'), isFalse);
    expect(AuthService.isValidEmail('abc@'), isFalse);
    expect(AuthService.isValidEmail('@gmail.com'), isFalse);
    expect(AuthService.isValidEmail('abc@gmail'), isFalse);
    expect(AuthService.isValidEmail('abc@gmail.com'), isTrue);
  });

  testWidgets('shows register screen on startup', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bắt đầu học ngay!'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
  });
}
