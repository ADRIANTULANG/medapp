import 'dart:convert';

List<Booking> bookingFromJson(String str) =>
    List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  String firstname;
  String doctorid;
  String doctoremail;
  DateTime dateScheduled;
  String doctorspecialty;
  String userid;
  String doctorname;
  String email;
  String doctorimage;
  String contactno;
  String lastname;
  String id;

  Booking({
    required this.firstname,
    required this.doctorid,
    required this.doctoremail,
    required this.dateScheduled,
    required this.doctorspecialty,
    required this.userid,
    required this.doctorname,
    required this.email,
    required this.doctorimage,
    required this.contactno,
    required this.lastname,
    required this.id,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        firstname: json["firstname"],
        doctorid: json["doctorid"],
        doctoremail: json["doctoremail"],
        dateScheduled: DateTime.parse(json["dateScheduled"]),
        doctorspecialty: json["doctorspecialty"],
        userid: json["userid"],
        doctorname: json["doctorname"],
        email: json["email"],
        doctorimage: json["doctorimage"],
        contactno: json["contactno"],
        lastname: json["lastname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "doctorid": doctorid,
        "doctoremail": doctoremail,
        "dateScheduled": dateScheduled.toIso8601String(),
        "doctorspecialty": doctorspecialty,
        "userid": userid,
        "doctorname": doctorname,
        "email": email,
        "doctorimage": doctorimage,
        "contactno": contactno,
        "lastname": lastname,
        "id": id,
      };
}
