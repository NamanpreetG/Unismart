import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Models/user_model.dart';

class AddMood extends StatefulWidget {
  @override
  _AddMoodState createState() => _AddMoodState();
}

class _AddMoodState extends State<AddMood> {
  final titleEditingController = new TextEditingController();
  final moodEditingController = new TextEditingController();
  final dateEditingController = new TextEditingController();
  final ratingEditingController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
        autofocus: false,
        controller: titleEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please the title");
          }
          return null;
        },
        onSaved: (value) {
          titleEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.description,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Why do you feel that way?",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final moodField = TextFormField(
        autofocus: false,
        controller: moodEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return ("Please the title");
          }
          return null;
        },
        onSaved: (value) {
          moodEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mood,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "What is your Mood? ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final dateField = TextFormField(
        autofocus: false,
        controller: dateEditingController,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter the Date ");
          }
          return null;
        },
        onSaved: (value) {
          dateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mood,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "What's the date? DD/MM/YY",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final ratingField = TextFormField(
        autofocus: false,
        controller: ratingEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return ("Please enter your rating (1-10)");
          }
          return null;
        },
        onSaved: (value) {
          ratingEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mood,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "How would you rate your mood? 1-10",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final mood = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("mood");

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          mood.add({
            'title': titleEditingController.text,
            'mood': moodEditingController.text,
            'date': dateEditingController.text,
            'rating': ratingEditingController.text,
          });
          Navigator.of(context).pop();
        },
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Mood"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  moodField,
                  SizedBox(height: 10),
                  titleField,
                  SizedBox(height: 10),
                  ratingField,
                  SizedBox(height: 10),
                  dateField,
                  SizedBox(height: 20),
                  signUpButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
