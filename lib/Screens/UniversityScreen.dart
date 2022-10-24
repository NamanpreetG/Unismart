import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Models/user_model.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key? key}) : super(key: key);

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  Stream<QuerySnapshot> board =
      FirebaseFirestore.instance.collection("board").snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${loggedInUser.universityName} Board Page".toUpperCase()),
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
                stream: board,
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
                              ListTile(
                                title: Text(
                                  "${data.docs[index]['Name']}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                subtitle: Text(
                                  "${data.docs[index]['Event']}                   ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("${data.docs[index]['Where']}   "),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("${data.docs[index]['When']}   "),
                                  ])
                            ])));
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
