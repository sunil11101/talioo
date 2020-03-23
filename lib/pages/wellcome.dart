import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talio_travel/pages/intro.dart';
import 'package:talio_travel/Api/api_provider.dart';
import 'package:talio_travel/Api/api_list.dart';

// welcome page 


class WellComePage extends StatefulWidget {
  WellComePage({Key key}) : super(key: key);

  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {

  int uI = 0;
  int uI1 = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  String name, email, profilePic, uid, phone, joiningDate, accessToken;


  // sign in procedure
  Future<FirebaseUser> _signIn() async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;  // getting data from google 

    var userName = userDetails.displayName;
    var userEmail = userDetails.email;
    var userProfilePic = userDetails.photoUrl;
    var uid = userDetails.uid;
    var phoneNumber = userDetails.phoneNumber;
    

    //print("UserID:" + uid);
    setState(() {
      this.name = userName;
      this.email = userEmail;
      this.profilePic = userProfilePic;
      this.uid = uid;
      this.phone = phoneNumber;
      
    });

    _saveToDb();

    return userDetails;
  }

  //saving new user data to the firebase realtime database
  Future _saveToDb() async {
    var data = {
      'name': name,
      'email': email,
      'phone': phone,
      'profile_pic_url': profilePic,
      'provider' : 'google',
      'provider_user_id' : uid
    };

    var res = await Network().authData(data, APIList.socialAuthAPI);
    print(res.body);
    var body = json.decode(res.body);

    if(res.statusCode == APIList.statusCodeOK) {
      print("Status 200");
      accessToken = body['access_token'];
      print("TTTTT:$accessToken");
    }
  }

  // saving user data in shared preferences for further offline uses.
  Future _saveDataToSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print("Saving Token: $accessToken");

    await sharedPreferences.setString('name', name);
    await sharedPreferences.setString('userEmail', email);
    await sharedPreferences.setString('userProfilePic', profilePic);
    await sharedPreferences.setString('uid', uid);
    await sharedPreferences.setString('accessToken', accessToken);
  }




  // when signin is comppleted  
   afterSuccess(){
   var duration = Duration(milliseconds: 3000);
   return Timer(duration, nextPage);
 }

  void nextPage (){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => IntroPage()
    ));
  }


  // setting page for wellcome screen will appear or not when the user open this app for the secound time
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



  // loading animation ui
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

  // wellcome page
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
              image: AssetImage('assets/images/travel4.png'),
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
                    _saveToDb().whenComplete((){
                      _saveDataToSP().whenComplete((){
                        setState(() {
                        uI1 = 1; // to show success ui
                        afterSuccess();
                        _setPage();
                        });
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

  // success animation
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
