import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customlogoauth.dart';
import 'package:flutterfirebase/components/textformfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                  'Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(height: 10),
                Text(
                  'Log in to continue to use the app',
                  style: TextStyle(color: Colors.grey),
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
            CustomButtonAuth(title: "Login", onPressed: () {}),
            Container(height: 20),
            MaterialButton(
              color: Colors.red[700],
              textColor: Colors.white,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('Login with Google    '),

                  Image.asset('images/4.png', width: 20),
                ],
              ),
            ),
            Container(height: 30),

            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('signup');
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don't Have An Account? "),
                      TextSpan(
                        text: "Register",
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
