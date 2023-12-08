import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void register() async {
    toastMessage("Creating account");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.toString().trim(),
        password: _passwordController.text.toString().trim(),
      );
      await userCredential.user?.updateDisplayName(_nameController.text.toString().trim());
      String uid = userCredential.user!.uid;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final userData = <String, String> {
        "name": _nameController.text.toString(),
        "email": _emailController.text.toString(),
        "phone_number": _phoneController.text.toString(),
        "type": "user"
      };
      await db.collection("users").doc(uid).set(userData);
      toastMessage("Account created");
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      toastMessage("Signing Failed" + e.toString());
    }
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
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '',
                      ),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                      ),
                      child: const Text("Sign Up"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Already have an account??"),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Login"))
                    ],)
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