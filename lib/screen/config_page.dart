import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/task_detail_page.dart';
import 'package:treetaskfocus/screen/task_page.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  String _hour = '0';
  String _minute = '0';
  String _second = '00';
  get themeProvider => Provider.of<ThemeProvider>(context);

  int? _selectedPreset; // เก็บสถานะของปุ่มที่ถูกกด

  // สร้าง TextEditingController สำหรับชั่วโมงและนาที
  late TextEditingController _hourController;
  late TextEditingController _minuteController;

  @override
  void initState() {
    super.initState();
    _hourController = TextEditingController(text: _hour);
    _minuteController = TextEditingController(text: _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

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
      if (intValue < 1 && intHour == 0) {
        return 'อย่างน้อย 1 นาที';
      }
    }
    return null; // คืนค่า null ถ้าค่าถูกต้อง
  }

  void _setPresetTime(int hour, int minute, int second, int buttonIndex) {
    setState(() {
      _hour = hour.toString().padLeft(1, '0');
      _minute = minute.toString().padLeft(2, '0');
      _second = second.toString().padLeft(2, '0');
      _selectedPreset = buttonIndex;

      // อัปเดตค่าของ TextFormField ด้วย TextEditingController
      _hourController.text = _hour;
      _minuteController.text = _minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: themeProvider.themeColor,
      body: Column(
        children: [
          // แถบด้านบนที่ไม่มี AppBar
          Container(
            decoration: BoxDecoration(
              color: themeProvider.themeColor, // สีพื้นหลัง
              borderRadius: BorderRadius.only(),
            ),
            height: 80.0, // ความสูงของแถบ
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ปุ่มยกเลิก
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      onPressed: () {
                        //ย้อนกลับไปหน้า task_page
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => TaskPage()));
                      },
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                // ปุ่มตกลง
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      onPressed: () {
                        //ย้อนกลับไปหน้า task_page พร้อมกับ add taskใหม่
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save(); //save ข้อมูล
                          tasks.add(TaskDetailPage(
                              taskName: _taskName,
                              hour: _hour,
                              minute: _minute,
                              second: _second));
                          _formKey.currentState!.reset();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) => TaskPage()));
                        }
                      },
                      child: Text(
                        'ตกลง',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          // รายการงาน
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(15),
                    ),
                    Text(
                      "ชื่องาน",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8),
                    ),
                    TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "กรุณาป้อนชื่องาน";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _taskName = value!;
                      },
                    ),
                    Text(
                      "ระยะเวลา",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _hourController,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              counterText: 'ชั่วโมง',
                            ),
                            validator: validateHour,
                            onChanged: (value) {
                              setState(() {
                                _hour =
                                    value; // บันทึกค่าทันทีเมื่อการตรวจสอบสำเร็จ
                                _selectedPreset =
                                    null; // รีเซ็ตสถานะปุ่มที่ถูกกด
                              });
                            },
                            onSaved: (value) {
                              _hour = value!.toString().padLeft(1,
                                  '0'); // บันทึกค่าเมื่อมีการบันทึกฟอร์มทั้งหมด
                            },
                          ),
                        ),
                        SizedBox(width: 8), // เพิ่มช่องว่างระหว่างฟิลด์
                        Text(
                          ':',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        // TextFormField สำหรับ นาที
                        Expanded(
                          child: TextFormField(
                            controller: _minuteController,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              counterText: 'นาที',
                            ),
                            validator: validateMinute,
                            onChanged: (value) {
                              setState(() {
                                _minute =
                                    value; // บันทึกค่าทันทีเมื่อการตรวจสอบสำเร็จ
                                _selectedPreset =
                                    null; // รีเซ็ตสถานะปุ่มที่ถูกกด
                              });
                            },
                            onSaved: (value) {
                              _minute = value!.toString().padLeft(2,
                                  '0'); // บันทึกค่าเมื่อมีการบันทึกฟอร์มทั้งหมด
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            // ปุ่ม 5 นาที
                            SizedBox(
                              width: 100, // กำหนดความกว้างคงที่
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _setPresetTime(0, 5, 0, 1);
                                },
                                child: Text(
                                  '5 นาที',
                                  style: TextStyle(
                                    color: _selectedPreset == 1
                                        ? themeProvider.themeColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // ปุ่ม 30 นาที
                            SizedBox(
                              width: 100, // กำหนดความกว้างคงที่
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _setPresetTime(0, 30, 0, 2);
                                },
                                child: Text(
                                  '30 นาที',
                                  style: TextStyle(
                                    color: _selectedPreset == 2
                                        ? themeProvider.themeColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // ปุ่ม 1 ชั่วโมง
                            SizedBox(
                              width: 100, // กำหนดความกว้างคงที่
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _setPresetTime(1, 0, 0, 3);
                                },
                                child: Text(
                                  '1 ชั่วโมง',
                                  style: TextStyle(
                                    color: _selectedPreset == 3
                                        ? themeProvider.themeColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
