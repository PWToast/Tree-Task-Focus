import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/shop_page.dart';
import 'package:treetaskfocus/screen/storage_screen.dart';
import 'package:treetaskfocus/screen/task_page.dart';
import 'package:treetaskfocus/screen/theme_screen.dart';
import 'package:treetaskfocus/screen/task_detail_page.dart';
import 'dart:async';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:treetaskfocus/screen/timeout_modal.dart';
import 'package:treetaskfocus/screen/plant_Provider.dart';
import 'package:treetaskfocus/screen/coinProvider.dart';
import 'package:treetaskfocus/screen/weather_service.dart';
import 'package:treetaskfocus/screen/weather_model.dart';

class HomeScreen extends StatefulWidget {
  final TaskDetailPage? task;
  const HomeScreen({super.key, this.task});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String autum = "assets/Photo/Autum.gif";
  String winter = "assets/Photo/Winter.gif";
  String spring = "assets/Photo/Spring.gif";
  String treepicture = "assets/Photo/Autum.gif";
  String currentseason = "assets/Photo/Spring.gif";
  String treename = "Level : 1";
  String exp = "Current EXP : 0/100";
  late TaskDetailPage task;
  late int totalSeconds; // ตัวแปรสำหรับเก็บเวลาที่คำนวณได้เป็นวินาที
  late int remainingSeconds; // ตัวแปรสำหรับเก็บเวลาที่เหลือ
  Timer? timer; // ตัวแปร Timer
  bool isCounting = false; // ตัวแปรสำหรับตรวจสอบสถานะการนับถอยหลัง
  bool isStartButtonVisible = true; // ตัวแปรสำหรับควบคุมการแสดงผลของปุ่มเริ่ม
  String level = '1';
  String currentExp = '0';
  String maxExp = '200';
  int elapsedSeconds = 0; // ตัวแปรสำหรับนับจำนวนวินาทีที่ผ่านไป
  final _WeatherService = WeatherService('5cea55e44a57358a71b7835a21225eed');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    // กำหนดค่า task จาก widget.task เมื่อเริ่มต้นหน้าครั้งแรก
    task = widget.task ??
        TaskDetailPage(
            taskName: "ยังไม่มี กดที่นี่!",
            hour: '0',
            minute: '0',
            second: '0');
    totalSeconds = (int.parse(task.hour) * 3600) +
        (int.parse(task.minute) * 60) +
        int.parse(task.second);
    remainingSeconds = totalSeconds; // กำหนดเวลาเริ่มต้นจากค่าที่คำนวณได้

    _fetchWeather(); // เรียกใช้งาน method สภาพอากาศ ที่นี่
  }

  _fetchWeather() async {
    String cityName = "Nakhon Pathom";

    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e'); // แสดง error ใน console
    }
  }

  // void startCountdown() {
  //   final plantsModel = Provider.of<PlantsModel>(context, listen: false);

  //   if (!isCounting) {
  //     setState(() {
  //       isCounting = true; // ตั้งค่า isCounting เป็น true
  //       isStartButtonVisible = false; // ซ่อนปุ่มเริ่ม
  //     });
  //     timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
  //       if (remainingSeconds > 0) {
  //         setState(() {
  //           remainingSeconds--; // ลดเวลาที่เหลือทุก ๆ วินาที
  //         });
  //       } else {
  //         timer.cancel(); // หยุด Timer เมื่อถึง 0
  //         setState(() {
  //           isCounting = false; // ตั้งค่า isCounting เป็น false
  //           isStartButtonVisible = true; // แสดงปุ่มเริ่มอีกครั้ง
  //           remainingSeconds =
  //               totalSeconds; // รีเซ็ตค่าเวลาถอยหลังกลับไปเป็นค่าเริ่มต้น

  //           // แสดง snackbar เมื่อเวลาถึง 0
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Time is up!'),
  //               duration: Duration(seconds: 3),
  //             ),
  //           );
  //         });
  //       }
  //     });
  //   } else {
  //     // หากการนับถอยหลังยังคงทำงานอยู่ (isCounting = true) ให้รีเซ็ตค่า
  //     setState(() {
  //       isCounting = false; // ตั้งค่า isCounting เป็น false
  //       isStartButtonVisible = true; // แสดงปุ่มเริ่มอีกครั้ง
  //       remainingSeconds =
  //           totalSeconds; // รีเซ็ตค่าเวลาถอยหลังกลับไปเป็นค่าเริ่มต้น
  //     });
  //   }
  // }
  void startCountdown() {
    final plantsModel = Provider.of<PlantsModel>(context, listen: false);

    if (!isCounting) {
      setState(() {
        isCounting = true; // ตั้งค่า isCounting เป็น true
        isStartButtonVisible = false; // ซ่อนปุ่มเริ่ม
      });

      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--; // ลดเวลาที่เหลือทุก ๆ วินาที
            elapsedSeconds++; // เพิ่มจำนวนวินาทีที่ผ่านไป

            // ตรวจสอบทุกๆ 60 วินาที (1 นาที)
            if (elapsedSeconds % 60 == 0) {
              // อัพเลเวล
              Provider.of<CoinProvider>(context, listen: false).addCoins(100);
              plantsModel.updateLevel();
              // Reset elapsedSeconds to keep counting for the next minute
            }
          });
        } else {
          timer.cancel(); // หยุด Timer เมื่อถึง 0
          setState(() {
            isCounting = false; // ตั้งค่า isCounting เป็น false
            isStartButtonVisible = true; // แสดงปุ่มเริ่มอีกครั้ง
            remainingSeconds =
                totalSeconds; // รีเซ็ตค่าเวลาถอยหลังกลับไปเป็นค่าเริ่มต้น

            // แสดง snackbar เมื่อเวลาถึง 0
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Time is up!'),
                duration: Duration(seconds: 3),
              ),
            );
          });
        }
      });
    } else {
      // หากการนับถอยหลังยังคงทำงานอยู่ (isCounting = true) ให้รีเซ็ตค่า
      setState(() {
        isCounting = false; // ตั้งค่า isCounting เป็น false
        isStartButtonVisible = true; // แสดงปุ่มเริ่มอีกครั้ง
        remainingSeconds =
            totalSeconds; // รีเซ็ตค่าเวลาถอยหลังกลับไปเป็นค่าเริ่มต้น
      });
    }
  }

  void stopCountdown() {
    if (isCounting) {
      timer?.cancel(); // หยุด Timer
      setState(() {
        isCounting = false; // ตั้งค่า isCounting เป็น false
        isStartButtonVisible = true; // แสดงปุ่มเริ่มอีกครั้ง
      });
    }
  }

  void resumeCountdown() {
    // ฟังก์ชันสำหรับเริ่มนับถอยหลังต่อ
    startCountdown();
  }

  void showTimeoutModal() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // พื้นหลังจางๆ
      builder: (BuildContext context) {
        return TimeoutModal(
          onCancel: resumeCountdown, // เริ่มนับถอยหลังต่อเมื่อกด Cancel
        );
      },
    );
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

  String checkTasks(List<TaskDetailPage> taskList) {
    if (taskList.isEmpty) {
      return 'ยังไม่มีกิจกรรม';
    } else {
      String tasksText = 'ชื่อกิจกรรม: ${task.taskName}';

      return tasksText;
    }
  }

  String getTreeImage(String name, int level) {
    if (name != "Opuntia" && name != "Golden Barrel") {
      if (level == 1) {
        return "assets/Photo/${name}_state1.png"; // รูปต้นไม้สำหรับเลเวลเริ่มต้น
      } else if (level == 2) {
        return "assets/Photo/${name}_state2.png"; // รูปต้นไม้สำหรับเลเวล 2
      } else {
        return "assets/Photo/${name}_state3.png"; // รูปต้นไม้สำหรับเลเวล สูงสุด
      }
    } else {
      //Opuntia ,Golden barrel แม่งมี2เวล ลำบากชห. ชื่อก็เสือกเว้นอีก
      if (level == 1 && name == "Opuntia") {
        return "assets/Photo/${name}_state1.png"; // รูปต้นไม้สำหรับเลเวลเริ่มต้น
      } else if (name == "Opuntia") {
        return "assets/Photo/${name}_state3.png"; // รูปต้นไม้สำหรับเลเวล สูงสุด
      }
      if (level == 1 && name == "Golden Barrel") {
        return "assets/Photo/Golden_barrel_state1.png"; // รูปต้นไม้สำหรับเลเวลเริ่มต้น
      } else {
        return "assets/Photo/Golden_barrel_state3.png"; // รูปต้นไม้สำหรับเลเวล สูงสุด
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int hours = (remainingSeconds ~/ 3600);
    int minutes = (remainingSeconds % 3600) ~/ 60;
    int seconds = remainingSeconds % 60;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final plantsModel = Provider.of<PlantsModel>(context);
    Plants selectedPlant = plantsModel.selectedPlant;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.themeColor,
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Home',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          leading: IconButton(
              icon: const Icon(Icons.shopping_cart), // ใช้ไอคอนรูปตะกร้า
              onPressed: () {
                pauseCountdown();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Shop()),
                );
              } // เมื่อกดจะไปยังหน้าตะกร้า
              ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  themeProvider.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: const Text('Storage'),
                leading: const Icon(Icons.inventory_2),
                onTap: () {
                  pauseCountdown();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StorageScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Shop'),
                leading: const Icon(Icons.shopping_cart),
                onTap: () {
                  pauseCountdown();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Shop(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Task'),
                leading: const Icon(Icons.task_alt),
                onTap: () {
                  pauseCountdown();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Theme'),
                leading: const Icon(Icons.format_paint),
                onTap: () {
                  pauseCountdown();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // ทำให้ข้อความอยู่ชิดซ้าย
                  child: Text(
                    _weather?.cityName ?? "Loading city...",
                    textAlign: TextAlign.left, // ชิดซ้ายใน Text widget
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // ทำให้ข้อความอยู่ชิดซ้าย
                  child: Text(
                    _weather != null
                        ? '${_weather!.temperature.round().toString()}°C'
                        : 'Loading weather...',
                    textAlign: TextAlign.center, // ชิดซ้ายใน Text widget
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // สีกรอบ
                      width: 2, // ความหนาของเส้นกรอบ
                    ),
                    borderRadius: BorderRadius.circular(10), // มุมโค้งของกรอบ
                  ),
                  padding: const EdgeInsets.all(30),
                  child: GestureDetector(
                    onTap: () {
                      pauseCountdown();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StorageScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      getTreeImage(selectedPlant.name, selectedPlant.level),
                      fit: BoxFit.fill,
                      width: 350,
                      height: 300,
                    ),
                  ),
                ),
              ),
              Text(
                "Level: ${selectedPlant.level} ${selectedPlant.name}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "EXP: ${selectedPlant.currentExp}/${selectedPlant.maxExp}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    pauseCountdown();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskPage(),
                      ),
                    );
                  },
                  child: Text(
                    checkTasks(tasks),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                //ส่วนการคำนวณเวลาและแสดงผล
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'เวลานับถอยหลัง',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 1),
                    Text(
                      '$hours ชั่วโมง $minutes นาที $seconds วินาที',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: isStartButtonVisible &&
                          remainingSeconds >
                              0, // แสดงปุ่มเริ่มเมื่อ isStartButtonVisible เป็น true และ remainingSeconds > 0
                      child: ElevatedButton(
                        onPressed: startCountdown,
                        child: Text(
                          'เริ่ม',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          backgroundColor: Color(0xFF00A36C),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !isStartButtonVisible &&
                          remainingSeconds >
                              0, // แสดงปุ่มหยุดเมื่อ isStartButtonVisible เป็น false และ remainingSeconds > 0
                      child: ElevatedButton(
                        onPressed: () {
                          pauseCountdown();
                          showTimeoutModal(); // แสดง TimeoutModal
                        },
                        child: Text(
                          'หยุด',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          backgroundColor: Colors.red, // สีพื้นหลังของปุ่มหยุด
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]))));
  }
}
