import 'dart:convert';

class Profile {
  int id;
  String firstName;
  String lastName;
  String userName;
  String gender;
  String birth;
  String profilePic;
  String email;
  int phone;
  String facebookId;
  String googleId;

  Profile({this.id = 0, this.firstName, this.lastName, this.userName, this.gender, this.birth, this.profilePic, this.email, this.phone});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"], firstName: map["firstName"], lastName: map["lastName"], userName: map["userName"], gender: map["gender"], birth: map["birth"], profilePic: map["profilePic"], email: map["email"], phone: map["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "firstName": firstName, "lastName": lastName, "userName": userName, "gender": gender, "birth": birth, "profilePic": profilePic, "email": email, "phone": phone};
  }

  @override
  String toString() {
    return 'Profile{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, gender: $gender, birth: $birth, profilePic: $profilePic, email: $email, phone: $phone}';
  }
}

class Gender {
  String key;
  String value;

  Gender(this.key, this.value);

  static List<Gender> getGender() {
    return <Gender>[
      Gender('', 'Please select your gender.'),
      Gender('M', 'Male'),
      Gender('F', 'Female'),
    ];
  }
}

class PhoneCode {
  String key;
  String value;

  PhoneCode(this.key, this.value);

  static List<PhoneCode> getPhoneCode() {
    return <PhoneCode>[
      PhoneCode('852', '+852'),
      PhoneCode('091', '+91'),
    ];
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
