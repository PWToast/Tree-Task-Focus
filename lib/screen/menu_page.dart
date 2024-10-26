import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:treetaskfocus/screen/task_page.dart'; // นำเข้าข้อมูล Task จาก TaskPage
import 'package:treetaskfocus/screen/task_detail_page.dart';

class MenuPage extends StatefulWidget {
  final TaskDetailPage task;

  const MenuPage({super.key, required this.task});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late TaskDetailPage task;
  late int totalSeconds; // ตัวแปรสำหรับเก็บเวลาที่คำนวณได้เป็นวินาที
  late int remainingSeconds; // ตัวแปรสำหรับเก็บเวลาที่เหลือ
  Timer? timer; // ตัวแปร Timer
  bool isCounting = false; // ตัวแปรสำหรับตรวจสอบสถานะการนับถอยหลัง

  @override
  void initState() {
    super.initState();
    // กำหนดค่า task จาก widget.task เมื่อเริ่มต้นหน้าครั้งแรก
    task = widget.task;
    totalSeconds = (int.parse(task.hour) * 3600) +
        (int.parse(task.minute) * 60) +
        int.parse(task.second);
    remainingSeconds = totalSeconds; // กำหนดเวลาเริ่มต้นจากค่าที่คำนวณได้
  }


  void startCountdown() {
    if (!isCounting) {
      isCounting = true; // ตั้งค่า isCounting เป็น true
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--; // ลดเวลาที่เหลือทุก ๆ วินาที
          });
        } else {
          timer.cancel(); // หยุด Timer เมื่อถึง 0
          isCounting = false; // ตั้งค่า isCounting เป็น false
        }
      });
    }
  }

  void stopCountdown() {
    if (isCounting) {
      timer?.cancel(); // หยุด Timer
      isCounting = false; // ตั้งค่า isCounting เป็น false
    }
  }

  void pauseCountdown() {
    if (isCounting) {
      stopCountdown(); // หยุด Timer เมื่อมีการสัมผัส
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // ยกเลิก Timer เมื่อออกจากหน้า
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = (remainingSeconds ~/ 3600);
    int minutes = (remainingSeconds % 3600) ~/ 60;
    int seconds = remainingSeconds % 60;

    return GestureDetector(
        onTap: () {
          pauseCountdown(); // หยุดนับถอยหลังเมื่อมีการสัมผัสใน Body
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Task List',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            backgroundColor: Color(0xFF00A36C),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ชื่อ Task: ${task.taskName}",
                    style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                Text("เวลา: ${task.hour}:${task.minute}:${task.second}",
                    style: TextStyle(fontSize: 20)),
                Text("${totalSeconds}"), //test จำนวนวินาที
                SizedBox(height: 20),
                Text(
                  'เวลานับถอยหลัง: $hours ชั่วโมง $minutes นาที $seconds วินาที',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: startCountdown, // เริ่มนับถอยหลังเมื่อกดปุ่ม
                  child: Text(
                    'เริ่มนับถอยหลัง',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: Color(0xFF00A36C), // สีพื้นหลังของปุ่ม
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
