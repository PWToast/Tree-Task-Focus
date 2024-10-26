import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/plant_Provider.dart';

class SakuradetailScreen extends StatefulWidget {
  final Plants? plantsList;
  final int plantIndex; // รับค่า index ของต้นไม้ที่เลือก

  const SakuradetailScreen(
      {super.key, this.plantsList, required this.plantIndex});

  @override
  State<SakuradetailScreen> createState() => _SakuradetailScreenState();
}

class _SakuradetailScreenState extends State<SakuradetailScreen> {
  @override
  Widget build(BuildContext context) {
    final plantsProvider =
        Provider.of<PlantsModel>(context, listen: false); // ดึง provider มาใช้

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // ทำให้มุมของ modal โค้งมน
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // จำกัดขนาด modal ให้พอดีกับเนื้อหา
          children: [
            Container(
              height: 300, // กำหนดขนาดรูปภาพ
              child: Image.asset(
                widget.plantsList?.path ?? 'assets/Photo/Tulip_state1.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.plantsList?.name ?? 'Unnamed Plant',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Level: ${widget.plantsList?.level ?? 'N/A'}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // อัปเดตต้นไม้ที่ถูกเลือกใน provider
                      plantsProvider.updateindex(widget.plantIndex);
                      Navigator.of(context).pop(); // ปิด modal
                    },
                    child: const Text("Select"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด modal
                    },
                    child: const Text("Cancel"),
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
