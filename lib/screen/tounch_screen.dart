import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/home_screen.dart';

class TounchScreen extends StatelessWidget {
  const TounchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Photo/tounch.gif'),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Align(
                alignment:
                    Alignment.bottomCenter, 
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 50),
                  child: Text(
                    'Tap to Start',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}