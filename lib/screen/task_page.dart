import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/config_page.dart';
import 'package:treetaskfocus/screen/home_screen.dart';
import 'package:treetaskfocus/screen/shop_page.dart';
import 'package:treetaskfocus/screen/storage_screen.dart';
import 'package:treetaskfocus/screen/task_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:treetaskfocus/screen/theme_screen.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  String path = 'assets/t.gif';
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.themeColor,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Task List',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
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
      backgroundColor: themeProvider.themeColor,
      body: Column(
        children: [
          // แถบด้านบนที่ไม่มี AppBar
          // Container(
          //   decoration: BoxDecoration(
          //     color: Color(0xFF00A36C), // สีพื้นหลัง
          //     borderRadius: BorderRadius.only(),
          //   ),
          //   height: 80.0, // ความสูงของแถบ
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // ปุ่มย้อนกลับ
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: CircleAvatar(
          //           backgroundColor: Colors.grey[300],
          //           child: IconButton(
          //             icon: Icon(Icons.arrow_back),
          //             onPressed: () {
          //               // กำหนดการทำงานปุ่มย้อนกลับ
          //             },
          //           ),
          //         ),
          //       ),
          //       // ชื่อหัวข้อ
          //       Text(
          //         'Task List',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       // ปุ่มเมนู
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: IconButton(
          //           icon: Icon(Icons.menu, color: Colors.grey[300], size: 30),
          //           onPressed: () {
          //             // กำหนดการทำงานปุ่มเมนู
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // รายการงาน
          Expanded(
              child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    // เมื่อกด Task จะนำทางไปหน้า MenuPage พร้อมส่งข้อมูล Task ที่เลือกไปด้วย
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MenuPage(
                    //         task:
                    //             tasks[index]), // ส่งข้อมูล task ไปที่ MenuPage
                    //   ),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            task: tasks[
                                index]), // ส่งข้อมูล task ไปที่ HomePage ของฮ้อ
                      ),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tasks[index].taskName,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${(tasks[index].hour)}:${(tasks[index].minute)}:${(tasks[index].second)}",
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle,
                                color: Color.fromARGB(255, 247, 3, 3)),
                            onPressed: () {
                              // กำหนดการทำงานเมื่อกดปุ่มลบ
                              // เช่น ลบงานนี้ออกจากรายการ
                              _removeTask(index);
                            },
                          ),
                        ],
                      )));
            },
          )),
          // ปุ่มเพิ่มงาน
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  // กำหนดการทำงานปุ่มเปลี่ยน
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const ConfigPage()));
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
