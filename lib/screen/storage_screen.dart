import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/plant_Provider.dart';
import 'package:treetaskfocus/screen/sakuradetail_screen.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/shop_page.dart';
import 'package:treetaskfocus/screen/task_page.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:treetaskfocus/screen/theme_screen.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});
  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final plantsModel = Provider.of<PlantsModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.themeColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Storage Box',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: plantsModel.plantss.length, // ใช้จำนวนของ plantsList
          itemBuilder: (context, index) {
            final plant =
                plantsModel.plantss[index]; // เข้าถึงข้อมูลของพืชที่ index นั้น
            return GestureDetector(
              onTap: () {
                // นำทางไปยัง SakuradetailScreen และส่งข้อมูลต้นไม้
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (BuildContext context) {
                    return SakuradetailScreen(
                      plantsList: plant,
                      plantIndex: index, // ส่งค่า index ของต้นไม้ที่ถูกเลือก
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    height: 100,
                    width: 100,
                    plant.path,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    plant.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
