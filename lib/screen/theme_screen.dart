import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/shop_page.dart';
import 'package:treetaskfocus/screen/storage_screen.dart';
import 'package:treetaskfocus/screen/task_page.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.themeColor,
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Theme',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () => themeProvider.changeTheme(
                  Color(0xFF00A36C), 'assets/Photo/Spring.gif'),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/Photo/Spring_theme.png'),
              ),
            ),
            GestureDetector(
              onTap: () => themeProvider.changeTheme(
                  Color(0xFF0097b2), 'assets/Photo/raining.gif'),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/Photo/Raining_theme.png'),
              ),
            ),
            GestureDetector(
              onTap: () => themeProvider.changeTheme(
                  Color.fromARGB(255, 233, 130, 13), 'assets/Photo/Autum.gif'),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/Photo/Autumn_theme.png'),
              ),
            ),
            GestureDetector(
              onTap: () => themeProvider.changeTheme(
                  Color(0xFF3b525e), 'assets/Photo/Winter.gif'),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/Photo/Winter_theme.png'),
              ),
            ),
          ],
        ));
  }
}
