import 'package:flutter/material.dart';
import 'package:bitcoin_icons/bitcoin_icons.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:treetaskfocus/screen/plant_Provider.dart';
import 'package:treetaskfocus/screen/coinProvider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Shop(),
    );
  }
}

class Shop extends StatefulWidget {
  const Shop({super.key, this.title});
  final String? title;

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  String coin = '100';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final plantsModel = Provider.of<PlantsModel>(context);
    final coinProvider = Provider.of<CoinProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.themeColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Shop',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        actions: [
          // เพิ่มส่วนแสดงเหรียญใน AppBar
          Container(
            margin: const EdgeInsets.only(right: 10), // ระยะห่างจากขอบขวา
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(BitcoinIcons.coins, size: 24.0, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  coinProvider.coin.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: themeProvider.themeColor,
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            // เช็คว่าเหรียญเพียงพอหรือไม่
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Apple', 0, 100, 1,
                                  'assets/Photo/Apple_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/Photo/Apple_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Apple\ndescription : เป็นไม้ยืนต้นชนิดหนึ่งมีถิ่นกำเนิดอยู่เอเชียกลาง ว่ากันว่าต้นไม้ชนิดนี้ทำให้ชายคนหนึ่งค้นพบแรงโน้มถ่วงของโลก',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Sakura', 0, 100, 1,
                                  'assets/Photo/Sakura_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/Photo/Sakura_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Sakura\ndescription : ชาวญี่ปุ่นเชื่อกันว่าชื่อของมันมาจากเทพธิดาในเทพปกรณัมของญี่ปุ่น เป็นเทพีแห่งภูเขาไฟฟูจิ ชื่อของพระนางมีความหมายดังกล่าวว่า "เจ้าหญิงดอกไม้บาน"',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Tulip', 0, 100, 1,
                                  'assets/Photo/Tulip_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/Photo/Tulip_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Tulib\ndescription : เป็นดอกไม้ที่มีรูปร่างสวยงามผู้คนมักให้กันในเนื่องโอกาสเกี่ยวกับความรัก  ตำนานชาวเปอร์เซียว่ากันว่า ดอกทิวลิปเติบโตเบ่งบานจากเลือดของ Farhad ที่ฆ่าตัวตายเพราะเข้าใจว่า Shirin หญิงคนรักตาย',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Marigold', 0, 100, 1,
                                  'assets/Photo/Marigold_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/Photo/Marigold_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Marigold\ndescription : เป็นพันธ์ดอกใหญ่ แต่ละฟากของโลกมีวัฒนธรรมเกี่ยวกับดอกไม้ชนิดนี้ไม่เหมือนกัน บางส่วนก็ใช้ในแง่ทางศาสนา บางส่วนมีความสำคัญในแง่วัฒนธรรมถึงขั้นใช้ในเทศกาลวันแห่งความตาย (Día de Muertos)',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            // เช็คว่าเหรียญเพียงพอหรือไม่
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Golden Barrel', 0, 100, 1,
                                  'assets/Photo/Golden_barrel_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                              'assets/Photo/Golden_barrel_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Golden Barrel\ndescription : แม้จะเป็นพืชที่นิยมปลูกและหาซื้อได้ง่ายตามร้านขายพันธ์ แต่ในธรรมชาติถิ่นกำเนิด (Mexico) ของมันกลับหาได้ยาก?  จนทำให้มันเป็นพืชที่เสี่ยงต่อสูญพันธ์จากพื้นที่ธรรมชาติ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmModal(
                          onConfirm: () {
                            // เช็คว่าเหรียญเพียงพอหรือไม่
                            bool success = coinProvider.buy(100); // หักเหรียญ
                            if (success) {
                              plantsModel.addPlants('Opuntia', 0, 100, 1,
                                  'assets/Photo/Opuntia_state1.png');
                              // ปิด modal หลังจากสร้างต้นไม้
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ซื้อสำเร็จ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เงินไม่พอ!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/Photo/Opuntia_shop.png'),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Opuntia\ndescription : เป็นพืชดอกในวงศ์กระบองเพชร ชาวปาเลสไตน์มองว่ากระบองเพชรชนิดนี้เป็นตัวแทนของความยืดหยุ่นและความอดทน ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class confirmModal extends StatelessWidget {
  final VoidCallback onConfirm;

  confirmModal({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              "ยืนยันการซื้อต้นไม้?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm, // เมื่อกด "ใช่" จะเรียก onConfirm
                    child: const Text("ใช่"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด modal เมื่อกด "ไม่"
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
