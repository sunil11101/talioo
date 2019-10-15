import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  
  String userEmail, userProfilePic, joiningDate;
  String userName = '';
  String name, email, pic, uid;

  Icon suffixIcon = Icon(LineIcons.edit);
  Icon closeIcon = Icon(LineIcons.close);
  Icon editIcon = Icon(LineIcons.edit);
  bool readonly = true;
  bool readmode = true;
  String _title = 'Your Profile';
  Icon _backIcon = Icon(Icons.keyboard_backspace);
  Icon _closeIcon = Icon(LineIcons.close);

  Widget uI = Container(height: 300, child: Center(child: CircularProgressIndicator()));

  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();

  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('userName');
    var email = sharedPreferences.getString('userEmail');
    var pic = sharedPreferences.getString('userProfilePic');
    var uidx = sharedPreferences.getString('uid');
    setState(() {
      this.name = name;
      this.email = email;
      this.pic = pic;
      this.uid = uidx;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserDetailsfromSP().whenComplete(() {
      _getUserDataFirebase();
    });
  }

  void _getUserDataFirebase() async {
    DatabaseReference dr = FirebaseDatabase.instance.reference();
    

    dr.child('Users/$uid/email').once().then((DataSnapshot snap) {
      var emailx = snap.value;
      setState(() {
        userEmail = emailx;
      });
      print(userEmail);
    });

    dr.child('Users/$uid/profile pic url').once().then((DataSnapshot snap) {
      var picx = snap.value;
      setState(() {
        userProfilePic = picx;
      });
      print(userProfilePic);
    });

    dr.child('Users/$uid/joining date').once().then((DataSnapshot snap) {
      var datex = snap.value;
      setState(() {
        joiningDate = datex;
      });
      print(joiningDate);
    });
    dr.child('Users/$uid/name').once().then((DataSnapshot snap) {
      var namex = snap.value;

      setState(() {
        userName = namex;
      });
      print(userName);
    });
  }

  Future _saveDataFirebase() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FocusScope.of(context).unfocus();
      reference.child('Users/$uid').update({
        'name': name,
      });
    }
  }

  Widget switchPage() {
    return userName.isEmpty
        ? uI
        : readmode == true ? profileUI() : profileEdit();
  }

  _editButtonPreesed() {
    setState(() {
      readmode = false;
      closeIcon = _backIcon;
      _title = 'Edit Profile';
      switchPage();
    });
  }

  _saveButtonPreesed() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _saveDataFirebase().whenComplete(() {
      setState(() {
        sp.setString('userName', name);
        readmode = true;
        closeIcon = _closeIcon;
        _title = 'Your Profile';
        switchPage();
      });
    });
  }

  _backPressedOnEditPage() {
    setState(() {
      readmode = true;
      closeIcon = _closeIcon;
      _title = 'Your Profile';
      switchPage();
    });
  }

  void _leadingButtonPressed() {
    _title == 'Edit Profile'
        ? _backPressedOnEditPage()
        : Navigator.pop(context);
  }

  File image;
  String fileName;

  Future _pickImage() async {
    var imagepicked = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = imagepicked;
      fileName = (image.path);
    });
  }

  void _uploadPicture() async {
    _pickImage().whenComplete(() async {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('Profile Pictures/$uid');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      if (uploadTask.isComplete) {
        print('upload complete');
      }

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      var imageUrl = url.toString();
      setState(() {
        pic = imageUrl;
      });
      print(imageUrl);
      _updatePictureData();
    });
    return null;
  }

  _updatePictureData() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userProfilePic', pic);
    reference.child('Users/$uid').update({
      'profile pic url': pic,
    });
  }

  Widget profileEdit() {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

    return Container(
      //height: h * 0.60,
      width: w,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          InkWell(
            child: Container(
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
                      image: CachedNetworkImageProvider(pic),
                      fit: BoxFit.cover)),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.black,
                  )),
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
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        readOnly: readonly,
                        onTap: () {
                          setState(() {
                            readonly = false;
                            suffixIcon = closeIcon;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            suffixIcon = editIcon;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        controller: textFieldCtrl,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
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
                                textFieldCtrl.clear();
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
                            this.name = value;
                          });
                        }),
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
              _saveButtonPreesed();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: h,
      width: w,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 65,
              width: w,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: closeIcon,
                    onPressed: () {
                      _leadingButtonPressed();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            switchPage(),
          ],
        ),
      ),
    ));
  }

  Widget profileUI() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: h * 0.50,
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(pic), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            userName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Text(
            userEmail,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            'Member Since $joiningDate',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
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
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(LineIcons.arrow_right, color: Colors.white)
                ],
              ),
            ),
            onTap: () {
              _editButtonPreesed();
            },
          ),
        ],
      ),
    );
  }
}
