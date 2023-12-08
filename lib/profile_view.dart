import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/sessionprefs.dart';
import 'package:medapp/toast.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});
  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void delete() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final userData = <String, String>{"type": "user_deleted"};
      await db.collection("users").doc(SessionPrefs().userID).update(userData);
      toastMessage("Profile updated");
      Navigator.pop(context);
    } catch (e) {
      toastMessage("Update Failed" + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot docsnap = await db.collection("users").doc(SessionPrefs().userID).get();
    Map<String, dynamic> docData = docsnap.data() as Map<String, dynamic>;
    _nameController.text = docData["name"];
    _emailController.text = docData["email"];
    _phoneController.text = docData["phone_number"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: '',
                      ),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '',
                      ),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'user@example.com',
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: delete,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                      ),
                      child: const Text("Delete User"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
