import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unismart/Models/user_model.dart';
import 'package:unismart/Screens/LoginScreen.dart';
import 'package:unismart/Screens/MoodTrackerScreen.dart';
import 'package:unismart/Screens/MotivationScreen.dart';
import 'package:unismart/Screens/RecipesScreen.dart';
import 'package:unismart/Screens/SettingsScreen.dart';
import 'package:unismart/Screens/UniversityScreen.dart';
import 'package:unismart/Screens/EventsScreen.dart';
import 'Calender.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  //Create dashboard

  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF004B8D),
                    Color(0xFFffffff),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Calendar())));
            }
            if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => MoodTrackerScreen())));
            }
            if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => EventsScreen())));
            }
            if (index == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => UniversityScreen())));
            }
            if (index == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => MotivationScreen())));
            }
            if (index == 5) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => RecipesScreen())));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  img,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "UniSmart",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        leading: (Container(
          width: 30,
          child: Image.asset(
            'assets/UniSmart.png',
          ),
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SettingsScreen())));
            },
          ),
          // add more IconButton
        ],
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.surname}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(2),
                children: [
                  makeDashboardItem("Calendar", "assets/calender-64.png", 0),
                  makeDashboardItem(
                      "Mood-Tracker", "assets/mood-swings-64.png", 1),
                  makeDashboardItem("Events", "assets/events-64.png", 2),
                  makeDashboardItem(
                      "University", "assets/university-60.png", 3),
                  makeDashboardItem("Quotes", "assets/motivation-64.png", 4),
                  makeDashboardItem("Recipes", "assets/cookbook-50.png", 5),
                ],
              )),
              SizedBox(
                height: 2,
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    logout(context);
                  })
            ],
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
