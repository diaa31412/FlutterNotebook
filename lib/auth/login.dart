import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Image.asset(
                      'images/logo.jpeg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
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
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                Container(height: 20),
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Your password",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
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
            MaterialButton(
              color: Colors.orange,
              textColor: Colors.white,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {},
              child: Text('Login'),
            ),
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
            Text(
              "Don't Have An Account? Register",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
