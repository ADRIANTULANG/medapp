import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/toast.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      goToHomeScreen();
    });
  }

  void goToHomeScreen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot docsnap =
          await db.collection("users").doc(user.uid).get();
      Map<String, dynamic> docData = docsnap.data() as Map<String, dynamic>;
      if (docData["type"] == "user") {
        Navigator.pushReplacementNamed(context, "/dashboard");
      }else if (docData["type"] == "admin"){
        Navigator.pushReplacementNamed(context, "/profile_admin");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Image.asset('assets/images/welcome_image.png',
                width: double.infinity, height: deviceHeight * 0.4),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Text(
              "Medicine App",
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
