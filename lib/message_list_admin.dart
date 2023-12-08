import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/sessionprefs.dart';
import 'package:medapp/toast.dart';

class Message {
  String id;
  String userID;
  String message;
  String? response;
  Message(this.id, this.userID, this.message, this.response);
}

class MessageListAdmin extends StatefulWidget {
  const MessageListAdmin({super.key});
  @override
  State<MessageListAdmin> createState() => _MessageListAdminState();
}

class _MessageListAdminState extends State<MessageListAdmin> {
  final _messageController = TextEditingController();
  List<Message> allListOfMessages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

   Future setData() async {
    allListOfMessages.clear();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      QuerySnapshot docs = await db
          .collection("messages")
          .get();
      docs.docs.forEach((message) { 
        Map<String,dynamic> messageData = message.data() as Map<String, dynamic>;
        messageData["id"] = message.id;
        Message msg = Message(messageData["id"], messageData["user_id"], messageData["message"], messageData["response"]);
        allListOfMessages.add(msg);
      });
    }
    // toastMessage(allListOfMessages.length.toString());
    setState(() {
      
    });
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
                    allListOfMessages.length > 0 ?
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          MessageCard(message: allListOfMessages[index]),
                      itemCount: allListOfMessages.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ): SizedBox(width: 1,)
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

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Color.fromARGB(255, 85, 190, 251),
        child: ListTile(
          onTap: (){
            SessionPrefs().messageID = widget.message.id;
            Navigator.pushNamed(context, "/message_view_admin");
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          title: Text(
            widget.message.message,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
