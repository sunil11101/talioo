import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/pages/intro.dart';


class WellComePage extends StatefulWidget {
  WellComePage({Key key}) : super(key: key);

  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {

  int uI = 0;
  int uI1 = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  String name, email, profilePic, uid, phone, joiningDate;


  
  Future<FirebaseUser> _signIn() async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;

    var userName = userDetails.displayName;
    var userEmail = userDetails.email;
    var userProfilePic = userDetails.photoUrl;
    var uid = userDetails.uid;
    var phoneNumber = userDetails.phoneNumber;
    

    print(uid);
    setState(() {
      this.name = userName;
      this.email = userEmail;
      this.profilePic = userProfilePic;
      this.uid = uid;
      this.phone = phoneNumber;
      
    });

    
    _checkExistingUser();

    return userDetails;
  }

  _checkExistingUser() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child('Users').once().then((DataSnapshot snap) {
      List keys = snap.value.keys.toList();

      if (keys.contains(uid)) {
        print('User Already Exists');
      } else {
        _getJoiningDate();
        _saveToFirebase();
        print('User does not Exist');
      }
    });
  }

  Future _saveToFirebase() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child('Users/$uid').set({
      'name': name,
      'email': email,
      'uid': uid,
      'phone': phone,
      'profile pic url': profilePic,
      'joining date': joiningDate
    });
  }

  _getJoiningDate (){
    DateTime now = DateTime.now();
    String _date = DateFormat('dd-MM-yyyy').format(now);
    setState(() {
      joiningDate = _date;
    });
    print(joiningDate);
  }

  Future _saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('userName', name);
    await sharedPreferences.setString('userEmail', email);
    await sharedPreferences.setString('userProfilePic', profilePic);
    await sharedPreferences.setString('uid', uid);
  }

   
   
   afterSuccess(){
   var duration = Duration(milliseconds: 3000);
   return Timer(duration, nextPage);
 }

  void nextPage (){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => IntroPage()
    ));
  }

  _setPage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('x', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: uI == 0 ? welcomeUI() 
        
        : uI1 == 0 ? loadingUI() :
        
        successUI());
  }

  Widget loadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 180,
            width: 180,
            
            child: FlareActor(

              'assets/flr/load.flr',
              animation : 'load',
              //color: Colors.deepPurpleAccent,
              alignment: Alignment.center,
              fit: BoxFit.contain,

            
            
            
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Signing with google....',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey[500]),
          )
        ],
      ),
    );
  }

  Widget welcomeUI() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/travel4.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome to',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            'Travel Hour',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Explore every famous places in Bangladesh with the easiest way',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
          ),
          Spacer(),
          Container(
              height: 45,
              width: w * 0.80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300], width: 1),
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[100],
              ),
              child: FlatButton.icon(
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.indigoAccent,
                  size: 22,
                ),
                label: Text(
                  'Sign In With Google',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    uI = 1;
                    
                  });
                  _signIn().then((f){
                    _saveData().whenComplete((){
                      setState(() {
                        uI1 = 1;
                        afterSuccess();
                        _setPage();
                      });
                    });
                  });
                  
                },
              )),
          SizedBox(
            height: h * 0.12,
          )
        ],
      ),
    );
  }

  Widget successUI  (){
    return Center(
        child: Container(
          height: 150,
          width: 150,
          child: FlareActor(
              'assets/flr/success.flr',
              animation : 'success',
              //color: Colors.deepPurpleAccent,
              alignment: Alignment.center,
              fit: BoxFit.contain,

            
            
            
            ),
        ),
        
      
    );
  }


}
