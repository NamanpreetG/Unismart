import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Models/mood.dart';
import 'package:unismart/Models/user_model.dart';
import 'package:unismart/Screens/addMood.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final mood = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('mood');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddMood(),
            ));
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("How are you feeling?"),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 800.0,
                child: StreamBuilder<QuerySnapshot>(
                    stream: mood.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      final data = snapshot.requireData;
                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];

                          return Center(
                              child: Card(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("${data.docs[index]['mood']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("${data.docs[index]['title']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                          "You rated your mood ${data.docs[index]['rating']} out of 10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("    ${data.docs[index]['date']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          mood.doc(ds.id).delete();
                                        },
                                      ),
                                    ])
                              ]))
                              );
                        },
                      );
                    }),
              ),
            ),
          ),
        )
        );
  }
}
