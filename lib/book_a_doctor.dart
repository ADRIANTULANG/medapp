import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medapp/models/doctors.dart';

class BookDoctor extends StatefulWidget {
  const BookDoctor({super.key});

  @override
  State<BookDoctor> createState() => _BookDoctorState();
}

class _BookDoctorState extends State<BookDoctor> {
  Doctors? doctorsDetails;
  String dateSelectedString = '';
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  getHeight(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.height * toDecimal;
  }

  getWidth(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.width * toDecimal;
  }

  pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2040, 12, 30));

    if (!context.mounted) return;
    TimeOfDay? time = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 12, minute: 0));

    if (time != null && date != null) {
      DateTime newtime =
          date.add(Duration(hours: time.hour, minutes: time.minute));
      selectedDate = newtime;
      setState(() {
        dateSelectedString =
            "${DateFormat.yMMMMd().format(newtime)} ${DateFormat.jm().format(newtime)}";
      });
    }
  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactno = TextEditingController();

  submitBooking() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('bookings').add({
      "userid": FirebaseAuth.instance.currentUser!.uid,
      "doctorid": doctorsDetails!.id,
      "dateScheduled": selectedDate,
      "firstname": firstname.text,
      "lastname": lastname.text,
      "email": email.text,
      "contactno": contactno.text,
      "doctorname": "${doctorsDetails!.firstname} ${doctorsDetails!.lastname}",
      "doctorimage": doctorsDetails!.image,
      "doctoremail": doctorsDetails!.email,
      "doctorspecialty": doctorsDetails!.specialty,
    });
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Success'),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    doctorsDetails = ModalRoute.of(context)!.settings.arguments as Doctors;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading == true
            ? const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: getHeight(100),
                width: getWidth(100),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: getWidth(5), right: getWidth(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        "Appointment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        " Select time",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pickDate();
                        },
                        child: Container(
                          height: getHeight(7),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: getWidth(3), right: getWidth(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateSelectedString,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const Icon(Icons.calendar_month)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        " First name",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                      Container(
                          height: getHeight(7),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: firstname,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: getWidth(3)),
                              border: InputBorder.none,
                            ),
                          )),
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        " Last name",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                      Container(
                          height: getHeight(7),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: lastname,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: getWidth(3)),
                              border: InputBorder.none,
                            ),
                          )),
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        " Email",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                      Container(
                          height: getHeight(7),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: getWidth(3)),
                              border: InputBorder.none,
                            ),
                          )),
                      SizedBox(
                        height: getHeight(2),
                      ),
                      const Text(
                        " Contact no.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                      Container(
                          height: getHeight(7),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: contactno,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: getWidth(3))),
                          )),
                      Expanded(
                          child: SizedBox(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: getHeight(2)),
                            child: SizedBox(
                              width: getWidth(100),
                              height: getHeight(7),
                              child: ElevatedButton(
                                onPressed: () {
                                  submitBooking();
                                },
                                child: const Text("Submit"),
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
