import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/components/custombuttonauth.dart';
import 'package:flutterfirebase/components/customformadd.dart';
import 'package:flutterfirebase/components/textformfield.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool isLoading = false;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference categories = FirebaseFirestore.instance.collection(
    'categories',
  );

  addCategory() async {
    // Call the user's CollectionReference to add a new user
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await categories.add({
          "name": name.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
        });

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
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    super.dispose();
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
                      title: 'Add',
                      onPressed: () {
                        addCategory();
                      },
                    ),
                  ],
                ),
      ),
    );
  }
}
