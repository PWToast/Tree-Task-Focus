class ValidationService {
  String _hour = '0';
  String _minute = '0';
  // Method สำหรับตรวจสอบค่า hour
  String? validateHour(String? value) {
    final int? intMinute = int.tryParse(_minute); // เอาค่า minute ปัจจุบันมาใช้
    final int? intHour = int.tryParse(_hour);
    final int? intValue = int.tryParse(value.toString());
    // ถ้าไม่ได้กรอกชั่วโมง และไม่ได้กรอกนาที ให้แจ้งเตือน
    if ((value == null || value.isEmpty || intValue == 0) &&
        (intMinute == null || intMinute == 0) &&
        intHour == 0) {
      return 'กรุณากรอกชั่วโมง'; // แจ้งเตือนถ้าทั้งชั่วโมงและนาทีว่าง
    }

    if (value != null && value.isNotEmpty) {
      final int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'ใส่ตัวเลขเท่านั้น'; // แจ้งเตือนถ้าไม่ใช่ตัวเลข
      }
      if (intValue < 0 || intValue > 8) {
        return 'สูงสุด 8 ชั่วโมง'; // แจ้งเตือนถ้าไม่อยู่ในช่วง 0-8
      }
    }
    return null; // คืนค่า null ถ้าค่าถูกต้อง
  }

  String? validateMinute(String? value) {
    final int? intHour = int.tryParse(_hour); // เอาค่า hour ปัจจุบันมาใช้
    final int? intMinute = int.tryParse(_minute);
    final int? intValue = int.tryParse(value.toString());
    // ถ้าไม่ได้กรอกนาที และไม่ได้กรอกชั่วโมง ให้แจ้งเตือน
    if ((value == null || value.isEmpty || intValue == 0) &&
        (intHour == null || intHour == 0) &&
        intMinute == 0) {
      return 'กรุณากรอกนาที'; // แจ้งเตือนถ้าทั้งชั่วโมงและนาทีว่าง
    }

    if (value != null && value.isNotEmpty) {
      final int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'ใส่ตัวเลขเท่านั้น'; // แจ้งเตือนถ้าไม่ใช่ตัวเลข
      }
      if (intValue < 0 || intValue >= 60) {
        return '0-59 เท่านั้น'; // แจ้งเตือนถ้าไม่อยู่ในช่วง 0-59
      }
    }
    return null; // คืนค่า null ถ้าค่าถูกต้อง
  }
}
