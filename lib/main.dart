import 'package:flutter/material.dart';
import 'package:loja_online/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_online/screens/login_screen.dart';
import 'package:loja_online/screens/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter's Clothing",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 4, 125, 141),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
