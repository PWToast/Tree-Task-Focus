import 'package:flutter_test/flutter_test.dart';
import 'package:treetaskfocus/test/validation_service.dart';

// pubspec dev_dependencies ใส่ test: ^1.21.0 แล้ว
// ใส่ cd C:\Users\User\Desktop\Flutter\treetaskfocus\lib ใน terminal
// พิมพ์ flutter test
void main() {
  setUp(() {
    validationService = ValidationService();
  });

  group('validateHour', () {
    test('ควรคืนค่าความผิดพลาดเมื่อชั่วโมงเป็นค่าว่าง', () {
      final result = validationService.validateHour('');
      expect(result, 'กรุณากรอกชั่วโมง');
    });

    test('ควรคืนค่าความผิดพลาดเมื่อชั่วโมงไม่ใช่ตัวเลข', () {
      final result = validationService.validateHour('abc');
      expect(result, 'ใส่ตัวเลขเท่านั้น');
    });

    test('ควรคืนค่าความผิดพลาดเมื่อชั่วโมงมากกว่า 8', () {
      final result = validationService.validateHour('9');
      expect(result, 'สูงสุด 8 ชั่วโมง');
    });

    test('ควรคืนค่า null เมื่อชั่วโมงถูกต้อง', () {
      final result = validationService.validateHour('5');
      expect(result, null);
    });
  });

  group('validateMinute', () {
    test('ควรคืนค่าความผิดพลาดเมื่อนาทีเป็นค่าว่าง', () {
      final result = validationService.validateMinute('');
      expect(result, 'กรุณากรอกนาที');
    });

    test('ควรคืนค่าความผิดพลาดเมื่อนาทีไม่ใช่ตัวเลข', () {
      final result = validationService.validateMinute('abc');
      expect(result, 'ใส่ตัวเลขเท่านั้น');
    });

    test('ควรคืนค่าความผิดพลาดเมื่อนาทีเกิน 59', () {
      final result = validationService.validateMinute('60');
      expect(result, '0-59 เท่านั้น');
    });

    test('ควรคืนค่า null เมื่อนาทีถูกต้อง', () {
      final result = validationService.validateMinute('30');
      expect(result, null);
    });
  });
}
