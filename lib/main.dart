import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchStatus = false;

  @override
  void initState() {
    super.initState();
    readStoredValue();
  }

  void readStoredValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switchStatus = prefs.getBool('SWITCHSTATUS') ?? true;
    setState(() {});
  }

  void bulbOn(bool newValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switchStatus = newValue;
    await prefs.setBool('SWITCHSTATUS', switchStatus);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Center(child: Text('Shared Preferences Exp'),)
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lightbulb,
                size: 400,
                color: switchStatus ? Colors.amber : Colors.white10,
              ),
              Switch(
                value: switchStatus,
                onChanged: (value) {
                  bulbOn(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
