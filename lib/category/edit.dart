import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customformadd.dart';
import 'package:flutterfirebase/components/textformfield.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldName;
  const EditCategory({super.key, required this.docid, required this.oldName});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool isLoading = false;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference categories = FirebaseFirestore.instance.collection(
    'categories',
  );

  editCategory() async {
    // Call the user's CollectionReference to add a new user
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await categories.doc(widget.docid).update({"name": name.text});
        isLoading = false;
        setState(() {});
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.oldName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
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
                        hinttext: 'Enter Name',
                        myController: name,
                        valdiator: (val) {
                          if (val == "") {
                            return "Can't be empty";
                          }
                        },
                      ),
                    ),
                    CustomButtonAuth(
                      title: 'Save',
                      onPressed: () {
                        editCategory();
                      },
                    ),
                  ],
                ),
      ),
    );
  }
}
