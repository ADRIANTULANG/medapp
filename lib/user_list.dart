import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/sessionprefs.dart';
import 'package:medapp/toast.dart';

class UserF {
  String userID;
  String name;
  String email;
  String phone;
  UserF(this.userID, this.name, this.email, this.phone);
}

class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _messageController = TextEditingController();
  List<UserF> allListOfMessages = [];

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
          .collection("users").where("type", isEqualTo: "user")
          .get();
      docs.docs.forEach((message) { 
        Map<String,dynamic> messageData = message.data() as Map<String, dynamic>;
        messageData["id"] = message.id;
        UserF msg = UserF(messageData["id"], messageData["name"], messageData["email"], messageData["phone_number"]);
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
                          UserCard(user: allListOfMessages[index]),
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

class UserCard extends StatefulWidget {
  final UserF user;
  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Color.fromARGB(255, 85, 190, 251),
        child: ListTile(
          onTap: (){
            SessionPrefs().userID = widget.user.userID;
            Navigator.pushNamed(context, "/profile_view_admin");
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          title: Text(
            widget.user.name,
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
