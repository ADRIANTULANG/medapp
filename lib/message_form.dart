import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/toast.dart';

class MessageFormPage extends StatefulWidget {
  const MessageFormPage({super.key});
  @override
  State<MessageFormPage> createState() => _MessageFormPageState();
}

class _MessageFormPageState extends State<MessageFormPage> {
  final _messageController = TextEditingController();

  void sendMessage() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final messageData = <String, String>{
        "user_id": user!.uid,
        "message": _messageController.text.toString(),
        
      };
      await db.collection("messages").doc().set(messageData);
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
                      maxLines: 10,
                      // readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        hintText: 'Dear Admin,...',
                      ),
                      controller: _messageController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: sendMessage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                      ),
                      child: const Text("Send"),
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
