// user profile and profile edit

import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talio_travel/Api/api_list.dart';
import 'package:talio_travel/Api/api_provider.dart';
import 'package:talio_travel/models/profile.dart';
import 'package:provider/provider.dart';

import 'package:talio_travel/blocs/blog_bloc.dart';
import 'package:talio_travel/blocs/places_bloc.dart';
import 'package:talio_travel/models/blog.dart';
import 'package:talio_travel/pages/blog_details.dart';

import 'edit_profile.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  TabController tabController;

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {

  String userEmail, userPhone, userGender, userBirth, userProfilePic, joiningDate;
  String userName = '';
  String name, email, phone, birth, profilePic, uid;

  String _title = 'Your Profile';

/*
  Icon suffixIcon = Icon(LineIcons.edit);
  Icon closeIcon = Icon(LineIcons.close);
  Icon editIcon = Icon(LineIcons.edit);
  bool readonly = true;
  bool readmode = true;
  Icon _backIcon = Icon(Icons.keyboard_backspace);
  Icon _closeIcon = Icon(LineIcons.close);
  List<Gender> _genderList = Gender.getGender();
  List<DropdownMenuItem<Gender>> _dropdownGender;
  Gender _selectedGender;
  List<PhoneCode> _phoneCodeList = PhoneCode.getPhoneCode();
  List<DropdownMenuItem<PhoneCode>> _dropdownPhoneCode;
  PhoneCode _selectedPhoneCode;
  DateTime _dtBirth;

  Widget uI = Container(height: 300, child: Center(child: CircularProgressIndicator()));

  var formKey = GlobalKey<FormState>();
  var textFieldName = TextEditingController();
  var textFieldEmail = TextEditingController();
  var textFieldGender = TextEditingController();
  var textFieldBirth = TextEditingController();
  var textFieldPhoneCode = TextEditingController();
  var textFieldPhone = TextEditingController();
*/
  // getting saved data after signup from shared preferences
  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var pic = sharedPreferences.getString('userProfilePic');
    setState(() {
      this.name = name;
      this.profilePic = pic;
    });
  }

  @override
  void initState() {
    //_dropdownGender = buildDropdownMenuItems(_genderList);
    //_selectedGender = _dropdownGender[0].value;
    //print(_selectedGender);
    super.initState();
    _getUserDetailsfromSP().whenComplete(() {
      //_getUserDataFirebase();
    });

    widget.tabController = TabController(
      length: 2,
      vsync: this,
    );

    BlogBloc().getBookmarkedBlogList(); //getting bookmarked blog list(if any)
    PlacesBloc().getBookmarkedPlaceList();
  }


  /*
  // getting user data from firebase realtime database
  void _getUserDataFirebase() async {
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
    if (formKey.currentState.validate()) {
      print("here");
      formKey.currentState.save();
      FocusScope.of(context).unfocus();
      var data = {
        'name': name,
        'email': email,
        'phone': phone,
        'birth': birth,
        'profile_pic_url': profilePic,
      };
      var res = await Network().putData(data, APIList.userInfoAPI);

      print(res.body);
      var body = json.decode(res.body);
    }
  }*/

/*
  // setting page (edit data > navigate to edit page, after edit or back > navigate to profile page)
  Widget switchPage() {
    return name == null || name.isEmpty
        ? uI
        : readmode == true ? profileUI() : EditProfilePage();
  }


  // after edit button is pressed

  _editButtonPressed() {
    setState(() {
      readmode = false;
      closeIcon = _backIcon;
      _title = 'Edit Profile';
      switchPage();
    });
  }
*/
/*
  // after save button is pressed
  _saveButtonPreesed() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _saveDataToDb().whenComplete(() {
      setState(() {
        sp.setString('userName', name);
        readmode = true;
        closeIcon = _closeIcon;
        _title = 'Your Profile';
        switchPage();
      });
    });
  }
*/
  // after back button is pressed when in edit page
  /*_backPressedOnEditPage() {
    setState(() {
      readmode = true;
      closeIcon = _closeIcon;
      _title = 'Your Profile';
      switchPage();
    });
  }*/

  // after back button is pressed when in profile page
  /*void _leadingButtonPressed() {
    _title == 'Edit Profile'
        ? _backPressedOnEditPage()
        : Navigator.pop(context);
  }*/
/*
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

  File image;
  String fileName;


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
      FirebaseStorage.instance.ref().child('Profile Pictures/$uid');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      if (uploadTask.isComplete) {
        print('upload complete');
      }

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      var imageUrl = url.toString();
      setState(() {
        profilePic = imageUrl;
      });
      _updatePictureData();
    });
    return null;
  }


  // after upload is completed the new picture url will be updated on firebase database
  _updatePictureData() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userProfilePic', profilePic);
    reference.child('Users/$uid').update({
      'profile pic url': profilePic,
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
                this.phone = value;
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


  // profile edit page
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
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
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
                        image: CachedNetworkImageProvider(profilePic),
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
                key: formKey,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Name'),
                    subtitle: TextFormField(
                        autofocus: false,
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
                            this.name = value;
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
                              this.email = value;
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
                                  this.birth = value;
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
              _saveButtonPreesed();
            },
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              leading: new Container(
                width: 0,
              ),
              expandedHeight: 370.0,
              floating: false,
              pinned: true,
              snap: false,
              brightness: Brightness.dark,
              title: new Text(_title),
              centerTitle: true,
              flexibleSpace: profileUI(),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
                controller: widget.tabController,
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: widget.tabController,
                children: <Widget>[
                  Center(child: Text("Tab one")),
                  Center(child: Text("Tab two")),
                ],
              ),
            ),
          ],
        ),
    );
  }



  //profile page
  Widget profileUI() {
    final BlogBloc blogBloc = Provider.of<BlogBloc>(context);
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context);
    BlogData blogData = BlogData();

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

          SizedBox(
            height: 40,
          ),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(profilePic), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              name==null?"":name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
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
              print("Pressed");
              //EditProfilePage();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage()
              ));
            },
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}