import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/bookings.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<Booking> bookingList = <Booking>[];
  getHeight(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.height * toDecimal;
  }

  getWidth(percent) {
    var toDecimal = percent / 100;
    return MediaQuery.of(context).size.width * toDecimal;
  }

  getBooking() async {
    try {
      var res = await FirebaseFirestore.instance.collection('bookings').get();
      var doctors = res.docs;
      List data = [];
      for (var i = 0; i < doctors.length; i++) {
        Map dataMap = doctors[i].data();
        dataMap['dateScheduled'] = dataMap['dateScheduled'].toDate().toString();
        dataMap['id'] = doctors[i].id;
        data.add(dataMap);
      }
      log(jsonEncode(data));
      setState(() {
        bookingList = bookingFromJson(jsonEncode(data));
      });
    } on Exception catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    getBooking();
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
                  "Bookings",
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
                  itemCount: bookingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: getWidth(5),
                        right: getWidth(5),
                        top: getHeight(2),
                      ),
                      child: InkWell(
                        onTap: () {},
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
                                              bookingList[index].doctorimage))),
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
                                        "${DateFormat.yMMMMd().format(bookingList[index].dateScheduled)} ${DateFormat.jm().format(bookingList[index].dateScheduled)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Dr. ${bookingList[index].doctorname}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        bookingList[index].email,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        bookingList[index].doctorspecialty,
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
