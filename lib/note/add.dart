import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customformadd.dart';
import 'package:flutterfirebase/components/textformfield.dart';
import 'package:flutterfirebase/note/view.dart';

class AddNote extends StatefulWidget {
  final String categoryId;
  const AddNote({super.key, required this.categoryId});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  bool isLoading = false;

  addNote() async {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('note');
    // Call the user's CollectionReference to add a new user
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await notes.add({"name": note.text});
        isLoading = false;
        setState(() {});
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteView(categoryId: widget.categoryId),
          ),
        );
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Form(
        key: formState,
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 25,
                      ),
                      child: CustomFormAdd(
                        hinttext: 'Enter Your Note',
                        myController: note,
                        valdiator: (val) {
                          if (val == "") {
                            return "Can't be empty";
                          }
                        },
                      ),
                    ),
                    CustomButtonAuth(
                      title: 'Add',
                      onPressed: () {
                        addNote();
                      },
                    ),
                  ],
                ),
      ),
    );
  }
}
