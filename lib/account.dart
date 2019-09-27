import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  Widget uI = Center(
    child: CircularProgressIndicator(),
  );

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
      getUserDataFirebase();
    });
  }

  void getUserDataFirebase() async {
    DatabaseReference dr = FirebaseDatabase.instance.reference();
    dr.child('Users/$uid/name').once().then((DataSnapshot snap) {
      var namex = snap.value;

      setState(() {
        userName = namex;
      });
      print(userName);
    });

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
  }

  Icon suffixIcon = Icon(LineIcons.edit);
  Icon closeIcon = Icon(LineIcons.close);
  Icon editIcon = Icon(LineIcons.edit);
  bool readonly = true;

  Widget profileEdit() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    
    return Container(
      //height: h * 0.50,
      width: w,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(pic),
                    fit: BoxFit.contain)),
          ),

          SizedBox(height: 20,),
          Container(
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
                      onTap: (){
                        setState(() {
                          readonly = false;
                          suffixIcon = closeIcon;
                        });
                      },
                      onEditingComplete: (){
                        setState(() {
                          suffixIcon = editIcon;
                        });
                      },
                      controller: textFieldCtrl,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.w600),
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
                      

                      //keyboardType: TextInputType.datetime,

                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

                        return value = null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          
                        });
                      }),


                      TextFormField(
                      
                      readOnly: readonly,
                      onTap: (){
                        setState(() {
                          readonly = false;
                        });
                      },
                      controller: textFieldCtrl,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        
                        labelText: userName,
                        hintText: "Enter New Name",
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500]),
                        
                        
                        
                        suffixIcon: IconButton(
                          icon: Icon(LineIcons.close,color: Colors.grey[800],size: 25,),
                          onPressed: () {
                            setState(() {
                              textFieldCtrl.clear();
                            });
                          },
                        ),
                      ),
                      

                      //keyboardType: TextInputType.datetime,

                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

                        return value = null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          
                        });
                      }),

                      TextFormField(
                      
                      readOnly: readonly,
                      onTap: (){
                        setState(() {
                          readonly = false;
                        });
                      },
                      controller: textFieldCtrl,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        
                        labelText: userName,
                        hintText: "Enter New Name",
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500]),
                        
                        
                        
                        suffixIcon: IconButton(
                          icon: Icon(LineIcons.close,color: Colors.grey[800],size: 25,),
                          onPressed: () {
                            setState(() {
                              textFieldCtrl.clear();
                            });
                          },
                        ),
                      ),
                      

                      //keyboardType: TextInputType.datetime,

                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

                        return value = null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          
                        });
                      }),
                    ],
                  )
                  
                  
                  
              ),
                
             
          ),
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
                    icon: Icon(LineIcons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            userName.isEmpty ? uI : profileEdit(),
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
      height: h * 0.40,
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(pic),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Text(
            email,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            'Member since september,2019',
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
            onTap: () {},
          )
        ],
      ),
    );
  }
}
