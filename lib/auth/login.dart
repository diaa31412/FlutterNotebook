import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customlogoauth.dart';
import 'package:flutterfirebase/components/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
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
                  InkWell(
                    onTap: () async {
                      if (email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please Enter Your Email',
                        ).show();
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: email.text,
                        );
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Info Title',
                          desc:
                              'Please got to your email to recieve the reset email',
                        ).show();
                      } catch (e) {
                        print(e);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Info Title',
                          desc: 'Please Enter Correct email and try again',
                        ).show();
                      }
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 20),
            CustomButtonAuth(
              title: "Login",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                    if (credential.user!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed('homepage');
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error Title',
                        desc: 'Please verified your email',
                      ).show();
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error Title',
                        desc: 'No user found for that email.',
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error Title',
                        desc: 'Wrong password provided for that user.',
                      ).show();
                    }
                  }
                } else {
                  print('Not valiad ');
                }
              },
            ),
            Container(height: 20),
            MaterialButton(
              color: Colors.red[700],
              textColor: Colors.white,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                signInWithGoogle();
              },
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
