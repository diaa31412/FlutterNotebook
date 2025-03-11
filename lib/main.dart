import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/auth/login.dart';
import 'package:flutterfirebase/auth/signup.dart';
import 'package:flutterfirebase/category/add.dart';
import 'package:flutterfirebase/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      home:
          (FirebaseAuth.instance.currentUser == null &&
                  FirebaseAuth.instance.currentUser!.emailVerified)
              ? HomePage()
              : LogIn(),
      routes: {
        'signup': (context) => SignUp(),
        'login': (context) => LogIn(),
        'homepage': (context) => HomePage(),
        'addcategory': (context) => AddCategory(),
      },
    );
  }
}
