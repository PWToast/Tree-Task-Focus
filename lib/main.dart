import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treetaskfocus/screen/coinProvider.dart';
import 'package:treetaskfocus/screen/config_page.dart';
import 'package:treetaskfocus/screen/home_screen.dart';
import 'package:treetaskfocus/screen/plant_Provider.dart';
import 'package:treetaskfocus/screen/theme_screen.dart';
import 'package:treetaskfocus/screen/tounch_screen.dart';
import 'package:treetaskfocus/screen/storage_screen.dart';
import 'package:treetaskfocus/screen/theme_provider.dart';
import 'package:treetaskfocus/screen/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlantsModel()),
        ChangeNotifierProvider(create: (_) => CoinProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: themeProvider.themeColor),
              useMaterial3: true,
            ),
            home: const TounchScreen(),
            initialRoute: "/tounchscreen",
            routes: {
              "/homescreen": (context) => const HomeScreen(),
              "/themescreen": (context) => const ThemeScreen(),
              "/tounchscreen": (context) => const TounchScreen(),
              "/storagescreen": (context) => const StorageScreen(),
              "/config": (context) => const ConfigPage(),
              "/weather": (context) => const WeatherPage(),
            },
          );
        },
      ),
    );
  }
}
