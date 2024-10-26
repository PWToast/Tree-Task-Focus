import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color _themeColor = Color(0xFF00A36C); // สีเริ่มต้น
  String _imagePath = 'assets/Photo/Spring.gif'; // ภาพเริ่มต้น

  Color get themeColor => _themeColor;
  String get imagePath => _imagePath;

  void changeTheme(Color newColor, String newPath) {
    _themeColor = newColor;
    _imagePath = newPath;
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลง
  }
}