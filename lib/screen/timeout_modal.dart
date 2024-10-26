import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/task_page.dart';

class TimeoutModal extends StatefulWidget {
  final VoidCallback onCancel; // Callback สำหรับส่งสัญญาณว่า Cancel ถูกกด
  const TimeoutModal({super.key, required this.onCancel});

  @override
  State<TimeoutModal> createState() => _TimeoutModalState();
}

class _TimeoutModalState extends State<TimeoutModal> {
  String path = "assets/test01.png";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // ทำให้มุมของ modal โค้งมน
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // จำกัดขนาด modal ให้พอดีกับเนื้อหา
          children: [
            const SizedBox(height: 10),
            const Text(
              "คุณต้องการหยุดใช่หรือไม่?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด modal
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const TaskPage()));
                    },
                    child: const Text("ใช่"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onCancel(); // เรียก callback เมื่อกด Cancel
                      Navigator.of(context).pop(); // ปิด modal
                    },
                    child: const Text("ไม่"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
