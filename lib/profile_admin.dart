import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/toast.dart';

class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({super.key});
  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Admin"),
        centerTitle: true,
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
                    Container(
                      width: 360,
                      child: ElevatedButton(onPressed: () {
                        Navigator.pushNamed(context, "/profile_edit");
                      }, child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Edit Profile", style: TextStyle(fontSize: 16),),
                      )),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 360,
                      child: ElevatedButton(onPressed: () {
                        Navigator.pushNamed(context, "/user_list");
                      }, child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Manage Users", style: TextStyle(fontSize: 16),),
                      )),
                    ),
                    SizedBox(height: 20,),
      
                    Container(
                      width: 360,
                      child: ElevatedButton(onPressed: () {
                        Navigator.pushNamed(context, "/message_list_admin");
                      }, child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("View Messages", style: TextStyle(fontSize: 16),),
                      )),
                    ),SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 360,
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((value) {
                              Navigator.pushReplacementNamed(context, "/welcome");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
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
