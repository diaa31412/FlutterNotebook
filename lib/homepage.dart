import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnpashot =
        await FirebaseFirestore.instance
            .collection('categories')
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
    data.addAll(querySnpashot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed('addcategory');
        },
        child: Icon(Icons.add),
      ),
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
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Delete',
                        desc: 'Are you sure you want delete this category',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await FirebaseFirestore.instance
                              .collection('categories')
                              .doc(data[i].id)
                              .delete();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed('homepage');
                        },
                      ).show();
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset('images/folder.png', height: 130),
                            Text("${data[i]['name']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
