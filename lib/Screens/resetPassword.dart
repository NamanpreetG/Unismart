import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key? key}) : super(key: key);

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final resetButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          reset(emailEditingController.text);
          Navigator.of(context).pop();
        },
        child: Text(
          "Reset",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email Address");
          }
          //reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a Valid Email Address");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email Address",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Text(
                          "Reset Your Password",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(height: 0),
                    emailField,
                    SizedBox(height: 20),
                    resetButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reset(String email) async {
    if (_formKey.currentState!.validate()) {
      await _auth.sendPasswordResetEmail(email: email).catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }
}
