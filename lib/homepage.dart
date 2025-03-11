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

  getData() async {
    QuerySnapshot querySnpashot =
        await FirebaseFirestore.instance.collection('categories').get();
    data.addAll(querySnpashot.docs);
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
      body: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemBuilder: (context, i) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Image.asset('images/folder.png', height: 130),
                  Text("${data[i]['name']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
