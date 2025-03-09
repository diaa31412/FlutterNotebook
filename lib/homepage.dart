import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase install'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSigin = GoogleSignIn();
              await googleSigin.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView(
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified
              ? Text("Welcome")
              : MaterialButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                },
                child: Text('Please Verified Your account'),
              ),
        ],
      ),
    );
  }
}
