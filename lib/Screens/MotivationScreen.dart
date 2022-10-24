import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({Key? key}) : super(key: key);

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  Stream<QuerySnapshot> quotes =
      FirebaseFirestore.instance.collection("quotes").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Quotes"),
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
                    stream: quotes,
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
                          return Card(
                            child: ListTile(
                              title: Text("${data.docs[index]['quote']}"),
                              subtitle: Text(
                                  " -  ${data.docs[index]['Author']}",
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
        ));
  }
}
