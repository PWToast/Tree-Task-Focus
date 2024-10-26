import 'package:flutter/material.dart';

class CoinProvider with ChangeNotifier {
  int _coin = 100; // ค่าเหรียญเริ่มต้น

  int get coin => _coin;

  void addCoins(int coins) {
    _coin += coins;
    notifyListeners(); // แจ้งให้ผู้ที่ฟัง (UI) ทราบถึงการเปลี่ยนแปลง
  }

  bool buy(int coins) {
    if (_coin >= coins) {
      _coin -= coins; // หักเหรียญ
      notifyListeners(); // แจ้งให้ผู้ที่ฟัง (UI) ทราบถึงการเปลี่ยนแปลง
      return true; // ส่งค่า true เมื่อซื้อสำเร็จ
    } else {
      return false; // ส่งค่า false เมื่อซื้อไม่สำเร็จ
    }
  }

  void subtractCoins(int coins) {
    if (_coin >= coins) {
      _coin -= coins;
      notifyListeners(); // แจ้งให้ผู้ที่ฟัง (UI) ทราบถึงการเปลี่ยนแปลง
    } else {
      // อาจแสดงข้อความเตือนผู้ใช้ว่ามีเหรียญไม่พอ
    }
  }
}
