import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/doctors.dart';

class DoctorsListView extends StatefulWidget {
  const DoctorsListView({super.key});

  @override
  State<DoctorsListView> createState() => _DoctorsListViewState();
}

class _DoctorsListViewState extends State<DoctorsListView> {
  List<Doctors> doctorsList = <Doctors>[];
  List<Doctors> doctorsMasterList = <Doctors>[];

  getHeight(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.height * toDecimal;
  }

  getWidth(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.width * toDecimal;
  }

  getDoctors() async {
    try {
      var res = await FirebaseFirestore.instance.collection('doctor').get();
      var doctors = res.docs;
      List data = [];
      for (var i = 0; i < doctors.length; i++) {
        Map dataMap = doctors[i].data();
        dataMap['datecreated'] = dataMap['datecreated'].toDate().toString();
        dataMap['id'] = doctors[i].id;
        data.add(dataMap);
      }
      setState(() {
        doctorsList = doctorsFromJson(jsonEncode(data));
        doctorsMasterList = doctorsFromJson(jsonEncode(data));
      });
    } on Exception catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: getHeight(100),
          width: getWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(2),
              ),
              Padding(
                padding: EdgeInsets.only(left: getWidth(5), right: getWidth(5)),
                child: const Text(
                  "Doctors",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(2),
              ),
              Expanded(
                  child: SizedBox(
                child: ListView.builder(
                  itemCount: doctorsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: getWidth(5),
                        right: getWidth(5),
                        top: getHeight(2),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/set_appointment",
                              arguments: doctorsList[index]);
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: getHeight(15),
                                  width: getWidth(30),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //       color: Colors.grey,
                                      //       spreadRadius: 3,
                                      //       blurRadius: 5),
                                      // ],
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              doctorsList[index].image))),
                                ),
                                SizedBox(
                                  width: getWidth(1),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: getHeight(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. ${doctorsList[index].firstname} ${doctorsList[index].lastname}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        doctorsList[index].email,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        doctorsList[index].specialty,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: getHeight(2),
                            ),
                            const Divider(
                              thickness: 0.5,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
