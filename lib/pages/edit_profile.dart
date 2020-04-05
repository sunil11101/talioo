import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:line_icons/line_icons.dart';
import 'package:talio_travel/Api/api_list.dart';
import 'package:talio_travel/Api/api_provider.dart';
import 'package:talio_travel/models/profile.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String userEmail, userPhone, userGender, userBirth, userProfilePic = '', joiningDate;
  String userName = '';

  var _formKey = GlobalKey<FormState>();
  var textFieldName = TextEditingController();
  var textFieldEmail = TextEditingController();
  var textFieldGender = TextEditingController();
  var textFieldBirth = TextEditingController();
  var textFieldPhoneCode = TextEditingController();
  var textFieldPhone = TextEditingController();

  List<Gender> _genderList = Gender.getGender();
  List<DropdownMenuItem<Gender>> _dropdownGender;
  Gender _selectedGender;
  List<PhoneCode> _phoneCodeList = PhoneCode.getPhoneCode();
  List<DropdownMenuItem<PhoneCode>> _dropdownPhoneCode;
  PhoneCode _selectedPhoneCode;
  File image;
  String fileName;

  Icon suffixIcon = Icon(LineIcons.edit);
  Icon closeIcon = Icon(LineIcons.close);
  Icon editIcon = Icon(LineIcons.edit);

  @override
  void initState() {
    super.initState();//getting bookmarked place list(if any)

    _dropdownGender = buildDropdownMenuItems(_genderList);
    _selectedGender = _dropdownGender[0].value;

    _getUserDetailsfromSP();
    _getUserDataFromDb();

  }

  // getting saved data after signup from shared preferences
  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var pic = sharedPreferences.getString('userProfilePic');
    setState(() {
      this.userName = name;
      this.userProfilePic = pic;
    });
  }

  // getting user data from database realtime database
  void _getUserDataFromDb() async {
    var res = await Network().getData(APIList.userInfoAPI);
    print("Status Code:" + res.statusCode.toString());
    print(res.body);
    var body = json.decode(res.body);

    if(res.statusCode == APIList.statusCodeOK) {
      setState(() {
        userProfilePic = body['data']['profile_pic_url'];
        userName = body['data']['name'];
        userEmail = body['data']['email'];
        userPhone = body['data']['phone'];
        userGender = body['data']['gender'];
        userBirth = body['data']['birth'];
        joiningDate = body['data']['created_at'];
      });
    }
  }

  // saving new data to firebase if user make any changes
  Future _saveDataToDb() async {
    if (_formKey.currentState.validate()) {
      print("here");
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      var data = {
        'name': userName,
        'email': userEmail,
        'phone': userPhone,
        'birth': userBirth,
        'profile_pic_url': userProfilePic,
      };
      var res = await Network().putData(data, APIList.userInfoAPI);

      print(res.body);
      var body = json.decode(res.body);
    }
  }

  // user pick new image to change the current profile picture
  Future _pickImage() async {
    var imagepicked = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = imagepicked;
      fileName = (image.path);
    });
  }

  // upload picture procedure

  void _uploadPicture() async {
    _pickImage().whenComplete(() async {
      StorageReference storageReference =
      FirebaseStorage.instance.ref().child('Profile Pictures/1');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      if (uploadTask.isComplete) {
        print('upload complete');
      }

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      var imageUrl = url.toString();
      setState(() {
        userProfilePic = imageUrl;
      });
      //_updatePictureData();
    });
    return null;
  }


  // after upload is completed the new picture url will be updated on firebase database
  _updatePictureData() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userProfilePic', userProfilePic);
    reference.child('Users/1').update({
      'profile pic url': userProfilePic,
    });
  }

  List<DropdownMenuItem<Gender>> buildDropdownMenuItems(List genderList) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender gender in genderList) {
      items.add(
        DropdownMenuItem(
          value: gender,
          child: Text(gender.value),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Gender selectedGender) {
    setState(() {
      _selectedGender = selectedGender;
    });
  }


  Widget _buildCountry() {
    return DropdownButtonHideUnderline(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new InputDecorator(
            decoration: InputDecoration(
              filled: false,
              //hintText: 'Choose Country',
              //prefixIcon: Icon(Icons.location_on),
              //labelText: _selectedGender == null ? 'Where are you from' : 'From',
            ),
            isEmpty: _selectedGender == null,
            child: new DropdownButton<Gender>(
              value: _selectedGender,
              isDense: true,
              onChanged: (Gender newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _selectedGender = newValue;
                  textFieldGender.text = _selectedGender.value;
                });
              },
              items: _genderList.map((Gender value) {
                return DropdownMenuItem<Gender>(
                  value: value,
                  child: Text(value.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhonefield() {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new DropdownButtonHideUnderline(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new InputDecorator(
                  decoration: InputDecoration(
                    filled: false,
                    //hintText: 'Choose Country',
                    //prefixIcon: Icon(Icons.location_on),
                    //labelText: 'Code',
                  ),
                  isEmpty: _selectedPhoneCode == null,
                  child: new DropdownButton<PhoneCode>(
                    value: _selectedPhoneCode,
                    isDense: true,
                    onChanged: (PhoneCode newValue) {
                      print('value change');
                      print(newValue);
                      setState(() {
                        _selectedPhoneCode = newValue;
                        textFieldPhoneCode.text = _selectedPhoneCode.value;
                      });
                    },
                    items: _phoneCodeList.map((PhoneCode value) {
                      return DropdownMenuItem<PhoneCode>(
                        value: value,
                        child: Text(value.value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        new SizedBox(
          width: 10.0,
        ),
        new Expanded(
          child: new TextFormField(
            controller: textFieldPhone,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: false,
              labelText: userPhone,
              hintText: "Mobile number",
              prefixIcon: new Icon(Icons.mobile_screen_share),
            ),
            onSaved: (String value) {
              setState(() {
                this.userPhone = value;
              });
            },
          ),
          flex: 5,
        ),
      ],
    );
  }

  DateTime selectedDate = DateTime(1990);
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2010));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        textFieldBirth.value = TextEditingValue(text: picked.year.toString() + "-" + picked.month.toString().padLeft(2, '0') + "-" + picked.day.toString().padLeft(2, '0'));
      });
  }

  // after save button is pressed
  _saveButtonPressed() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _saveDataToDb().whenComplete(() {
      setState(() {
        sp.setString('userName', userName);
        sp.setString('userProfilePic', userProfilePic);
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding:
        const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          child: Container(
            //height: h * 0.60,
            width: w,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child:  userProfilePic.isEmpty
                        ? Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 28),
                    )
                        : Container(
                      height: 100,
                      width: 100,

                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey[800]
                          ),

                          color: Colors.grey[500],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(userProfilePic),
                              fit: BoxFit.cover)),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  onTap: () {
                    _uploadPicture();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  // height: 45,
                  width: w,
                  decoration: BoxDecoration(
                    //color: Colors.white

                  ),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Name'),
                            subtitle: TextFormField(
                                autofocus: false,
                                onTap: () {
                                  setState(() {
                                    suffixIcon = closeIcon;
                                  });
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    suffixIcon = editIcon;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                controller: textFieldName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  filled: false,
                                  labelText: userName,
                                  hintText: "Enter New Name",
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[500]),
                                  suffixIcon: IconButton(
                                    icon: suffixIcon,
                                    onPressed: () {
                                      setState(() {
                                        textFieldName.clear();
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value.length == 0)
                                    return ("Name Can't be Empty!");

                                  return value = null;
                                },
                                onSaved: (String value) {
                                  setState(() {
                                    this.userName = value;
                                  });
                                }
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: const Text('Email'),
                            subtitle: TextFormField(
                                autofocus: false,
                                onTap: () {
                                  setState(() {
                                    suffixIcon = closeIcon;
                                  });
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    suffixIcon = editIcon;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                controller: textFieldEmail,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: userEmail,
                                  hintText: "Enter Email",
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[500]),
                                  suffixIcon: IconButton(
                                    icon: suffixIcon,
                                    onPressed: () {
                                      setState(() {
                                        textFieldEmail.clear();
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value.length == 0)
                                    return ("Email Can't be Empty!");

                                  return value = null;
                                },
                                onSaved: (String value) {
                                  setState(() {
                                    this.userEmail = value;
                                  });
                                }
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: const Text('Mobile'),
                            subtitle: _buildPhonefield(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: const Text('Gender'),
                            subtitle: _buildCountry(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: const Text('Birth'),
                            subtitle: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: TextFormField(
                                    autofocus: false,
                                    controller: textFieldBirth,
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                        labelText: userBirth,
                                        hintText: "Select your birth",
                                        disabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[500]),
                                        suffixIcon: Icon(Icons.calendar_today)
                                    ),
                                    onSaved: (String value) {
                                      setState(() {
                                        this.userBirth = value;
                                      });
                                    }
                                ),
                              ),
                            ),
                          ),

                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.blue[100],
                              offset: Offset(2, 2),
                              blurRadius: 1)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(LineIcons.save, color: Colors.white)
                      ],
                    ),
                  ),
                  onTap: () {
                    _saveButtonPressed();
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}