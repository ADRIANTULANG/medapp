import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/sessionprefs.dart';
import 'package:medapp/toast.dart';

class MessageViewAdminPage extends StatefulWidget {
  const MessageViewAdminPage({super.key});
  @override
  State<MessageViewAdminPage> createState() => _MessageViewAdminPageState();
}

class _MessageViewAdminPageState extends State<MessageViewAdminPage> {
  final _messageController = TextEditingController();
  final _responseController = TextEditingController();

  void sendMessage() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final messageData = <String, String>{
        "admin_id": user!.uid,
        "response": _responseController.text.toString(),
      };
      await db.collection("messages").doc(SessionPrefs().messageID).update(messageData);
      toastMessage("Profile updated");
      Navigator.pop(context);
    } catch (e) {
      toastMessage("Update Failed" + e.toString());
    }
  }

  void setData() async {
    String id = SessionPrefs().messageID;
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot docsnap = await db.collection("messages").doc(id).get();
    Map<String, dynamic> docData = docsnap.data() as Map<String, dynamic>;
    _messageController.text = docData["message"];
    _responseController.text = docData["response"] ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    maxLines: 10,
                    readOnly: true,
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
                  TextField(
                    maxLines: 10,
                    readOnly: false,
                    decoration: InputDecoration(
                      labelText: 'Response',
                      hintText: 'No response yet',
                    ),
                    controller: _responseController,
                    keyboardType: TextInputType.emailAddress,
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
                      child: const Text("Respond"),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
