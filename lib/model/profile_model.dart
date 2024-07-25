import 'dart:convert';

ProfileModel profileFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Address address;
  int id;
  Name name;
  String username;
  String password;
  String email;
  String phone;
  int v;

  ProfileModel({
    required this.address,
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        address: Address.fromJson(json["address"]),
        id: json["id"],
        name: Name.fromJson(json["name"]),
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phone: json["phone"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "id": id,
        "name": name.toJson(),
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "__v": v,
      };
}

class Name {
  String firstname;
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}

class Address {
  String city;
  String street;
  int number;
  String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
      };
}