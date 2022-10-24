import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Screens/FullRecipeScreen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Stream<QuerySnapshot> recipes =
      FirebaseFirestore.instance.collection("recipes").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Recipes"),
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
                stream: recipes,
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
                                  "${data.docs[index]['Recipe']}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                subtitle: Text(
                                  "${data.docs[index]['Duration']}                   ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("${data.docs[index]['Serves']}"),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullRecipeScreen(
                                                        recipe:
                                                            '${data.docs[index]['Recipe']}',
                                                        duration:
                                                            '${data.docs[index]['Duration']}',
                                                        method:
                                                            '${data.docs[index]['Method']}',
                                                        serves:
                                                            '${data.docs[index]['Serves']}',
                                                        ingredient:
                                                            '${data.docs[index]['Ingredients']}',
                                                      )));
                                        },
                                        child: const Text("View Recipe")),
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
