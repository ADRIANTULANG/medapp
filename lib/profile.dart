import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/toast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/profile_edit");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/message_form");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Message Admin",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/doctors_list");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Set Appointment",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/booking_list");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "View Appointment",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/message_list_user");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "View Messages",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((value) {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, "/welcome");
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Logout",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
