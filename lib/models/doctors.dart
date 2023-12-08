import 'dart:convert';

List<Doctors> doctorsFromJson(String str) =>
    List<Doctors>.from(json.decode(str).map((x) => Doctors.fromJson(x)));

String doctorsToJson(List<Doctors> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctors {
  String image;
  String specialty;
  String firstname;
  DateTime datecreated;
  String email;
  String lastname;
  String id;

  Doctors({
    required this.image,
    required this.specialty,
    required this.firstname,
    required this.datecreated,
    required this.email,
    required this.lastname,
    required this.id,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        image: json["image"],
        specialty: json["specialty"],
        firstname: json["firstname"],
        datecreated: DateTime.parse(json["datecreated"]),
        email: json["email"],
        lastname: json["lastname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "specialty": specialty,
        "firstname": firstname,
        "datecreated": datecreated.toIso8601String(),
        "email": email,
        "lastname": lastname,
        "id": id,
      };
}
