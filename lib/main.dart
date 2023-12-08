import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medapp/add_new_medicine/add_new_medicine.dart';
import 'package:medapp/book_a_doctor.dart';
import 'package:medapp/bookings_list.dart';
import 'package:medapp/doctors_list.dart';
import 'package:medapp/home/home.dart';
import 'package:medapp/message_form.dart';
import 'package:medapp/message_list.dart';
import 'package:medapp/message_list_admin.dart';
import 'package:medapp/message_view.dart';
import 'package:medapp/message_view_admin.dart';
import 'package:medapp/profile.dart';
import 'package:medapp/profile_admin.dart';
import 'package:medapp/profile_edit.dart';
import 'package:medapp/profile_view.dart';
import 'package:medapp/signin.dart';
import 'package:medapp/toast.dart';
import 'package:medapp/user_list.dart';
import 'package:medapp/welcome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 100, 214)),
        useMaterial3: true,
      ),
      routes: {
        '/welcome': (context) => const Welcome(),
        '/home': (context) => const MyHomePage(title: "Medicine App"),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const Home(),
        "/add_new_medicine": (context) => const AddNewMedicine(),
        "/profile": (context) => const ProfilePage(),
        "/profile_edit": (context) => const ProfileEditPage(),
        "/message_form": (context) => const MessageFormPage(),
        "/message_list_user": (context) => const MessageList(),
        "/message_list_admin": (context) => const MessageListAdmin(),
        "/message_view_user": (context) => const MessageViewPage(),
        "/message_view_admin": (context) => const MessageViewAdminPage(),
        "/profile_admin": (context) => const ProfileAdminPage(),
        "/profile_view_admin": (context) => const ProfileViewPage(),
        "/user_list": (context) => const UserList(),
        "/doctors_list": (context) => const DoctorsListView(),
        "/set_appointment": (context) => const BookDoctor(),
        "/booking_list": (context) => const BookingList(),

        // Add other named routes here
      },
      initialRoute: '/welcome',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    toastMessage("Signing In");
    print(_emailController.text);
    print(_passwordController.text);
    print("hello");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toString().trim(),
        password: _passwordController.text.toString().trim(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot docsnap =
          await db.collection("users").doc(user!.uid).get();
      Map<String, dynamic> docData = docsnap.data() as Map<String, dynamic>;
      if (docData["type"] == "user_deleted") {
        await db.collection("users").doc(user.uid).delete();
        await FirebaseAuth.instance.currentUser!.delete();
        toastMessage("Your account was deleted by the admin");
      } else {
        toastMessage("Signing Successful");
      }
      Navigator.pushReplacementNamed(context, '/welcome');
    } catch (e) {
      toastMessage("Signing Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'user@example.com',
                      ),
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: '',
                      ),
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                      ),
                      child: const Text("Login"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dont have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text("Sign Up"))
                      ],
                    )
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
