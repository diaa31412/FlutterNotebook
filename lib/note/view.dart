import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/note/add.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteView extends StatefulWidget {
  final String categoryId;
  const NoteView({super.key, required this.categoryId});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  // getData() async {
  //   QuerySnapshot querySnpashot =
  //       await FirebaseFirestore.instance
  //           .collection('categories')
  //           .doc(widget.categoryId)
  //           .collection('note')
  //           .get();

  //   data.addAll(querySnpashot.docs);
  //   isLoading = false;
  //   setState(() {});
  // }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance
              .collection('categories')
              .doc(widget.categoryId)
              .collection('note')
              .get();

      setState(() {
        data.clear();
        data.addAll(querySnapshot.docs);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNote(categoryId: widget.categoryId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Note'),
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
      body: WillPopScope(
        child:
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
                          desc: 'Choose What do you want',
                          btnCancelText: "Delete",
                          btnOkText: "Update",
                          btnCancelOnPress: () async {
                            // await FirebaseFirestore.instance
                            //     .collection('categories')
                            //     .doc(data[i].id)
                            //     .delete();
                            // Navigator.of(
                            //   context,
                            // ).pushReplacementNamed('NoteView');
                          },
                          btnOkOnPress: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder:
                            //         (context) => EditCategory(
                            //           docid: data[i].id,
                            //           oldName: data[i]['name'],
                            //         ),
                            //   ),
                            // );
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [Text("${data[i]['note']}")]),
                        ),
                      ),
                    );
                  },
                ),
        onWillPop: () {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('homepage', (route) => false);
          return Future.value(false);
        },
      ),
    );
  }
}
