import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customlogoauth.dart';
import 'package:flutterfirebase/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                CustomLogoAuth(),
                Container(height: 20),
                Text(
                  'SignUp',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(height: 10),
                Text(
                  'Log in to continue to use the app',
                  style: TextStyle(color: Colors.grey),
                ),
                Container(height: 20),
                Text(
                  'User Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your User Name",
                  myController: userName,
                ),
                Container(height: 20),
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  myController: email,
                ),
                Container(height: 20),
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Password",
                  myController: password,
                ),
                Container(height: 10),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            Container(height: 20),
            CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                  Navigator.of(context).pushReplacementNamed('homepage');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            Container(height: 20),

            Container(height: 30),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('login');
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: " Have An Account? "),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
