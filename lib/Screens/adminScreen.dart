import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Models/user_model.dart';
import 'package:unismart/Screens/LoginScreen.dart';

class adminScreen extends StatefulWidget {
  @override
  _adminScreenState createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  final eventEditingController = new TextEditingController();
  final nameEditingController = new TextEditingController();
  final whenEditingController = new TextEditingController();
  final whereEditingController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final eventField = TextFormField(
        autofocus: false,
        controller: eventEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter the Event Details");
          }
          return null;
        },
        onSaved: (value) {
          eventEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.description,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "What is the event? Provide a Description.",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return ("Please enter the Event Name");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.event,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Name of the Event",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));
    final whereField = TextFormField(
        autofocus: false,
        controller: whereEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter the Event place");
          }
          return null;
        },
        onSaved: (value) {
          whereEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.place,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Where is the event",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final whenField = TextFormField(
        autofocus: false,
        controller: whenEditingController,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter the Date ");
          }
          return null;
        },
        onSaved: (value) {
          whenEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_month,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "When is the Event? DD/MM/YY",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));

    final board = FirebaseFirestore.instance.collection("board");

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          board.add({
            'Event': eventEditingController.text,
            'Name': nameEditingController.text,
            'When': whenEditingController.text,
            'Where': whereEditingController.text,
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return adminScreen();
          }));
        },
        child: Text(
          "Save Event",
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
        title: Text("Admin"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            logout(context);
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
                  SizedBox(
                      height: 300,
                      child: Image.asset(
                        "assets/UniSmart.png",
                        fit: BoxFit.fill,
                      )),
                  SizedBox(height: 20),
                  nameField,
                  SizedBox(height: 20),
                  eventField,
                  SizedBox(height: 20),
                  whereField,
                  SizedBox(height: 20),
                  whenField,
                  SizedBox(height: 10),
                  saveButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
