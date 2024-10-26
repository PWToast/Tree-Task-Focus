import 'package:flutter/material.dart';

class Plants {
  String name;
  int currentExp;
  int maxExp;
  int level;
  String path;
  Plants(
      {required this.name,
      required this.currentExp,
      required this.maxExp,
      required this.level,
      required this.path});
}

class PlantsModel with ChangeNotifier {
  List<Plants> _plantss = [
    Plants(
        name: "Marigold",
        currentExp: 0,
        maxExp: 500,
        level: 1,
        path: "assets/Photo/Marigold_state1.png"),
  ];
  int _selectedTreeIndex = 0;

  // คืนค่าข้อมูลของต้นไม้ที่ถูกเลือกตอนนี้
  Plants get selectedPlant => _plantss[_selectedTreeIndex];

  // Getter สำหรับการเข้าถึงต้นไม้ทั้งหมด
  List<Plants> get plantss => _plantss;

  // เพิ่มต้นไม้ใหม่
  void addPlants(
      String name, int currentExp, int maxExp, int level, String path) {
    _plantss.add(Plants(
        name: name,
        currentExp: currentExp,
        maxExp: maxExp,
        level: level,
        path: path));
    notifyListeners();
  }

  // เปลี่ยนต้นไม้ที่ถูกเลือก
  void updateindex(int selectedTreeIndex) {
    _selectedTreeIndex = selectedTreeIndex;
    notifyListeners();
  }

  void updateLevel() {
    Plants selectedPlant = _plantss[_selectedTreeIndex]; // ต้นไม้ที่ถูกเลือก

    // เพิ่มค่า currentExp
    selectedPlant.currentExp += 100;

    // ตรวจสอบว่า currentExp มากกว่าหรือเท่ากับ maxExp เพื่อเลื่อนเลเวล
    while (selectedPlant.currentExp >= selectedPlant.maxExp) {
      selectedPlant.level++; // เพิ่มเลเวล
      selectedPlant.currentExp -=
          selectedPlant.maxExp; // หัก currentExp ที่เกินจาก maxExp
      selectedPlant.maxExp =
          (selectedPlant.maxExp * 1.2).toInt(); // เพิ่ม maxExp ขึ้น 20%
    }

    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลง
  }

  // แก้ไขข้อมูลต้นไม้
  void updateCharacter(int index, String name, int currentExp, int maxExp,
      int level, String path) {
    _plantss[index].name = name;
    _plantss[index].currentExp = currentExp;
    _plantss[index].maxExp = maxExp;
    _plantss[index].level = level;
    _plantss[index].path = path;
    notifyListeners();
  }
}
