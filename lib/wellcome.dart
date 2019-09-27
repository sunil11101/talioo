import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/intro.dart';



class WellComePage extends StatefulWidget {
  WellComePage({Key key}) : super(key: key);

  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {

  
  var uI = 0;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  String name, email, profilePic,uid, phone,date;
  

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
    var dates = DateTime.december;

    print(uid);
    setState(() {
      this.name = userName;
      this.email = userEmail;
      this.profilePic = userProfilePic;
      this.uid = uid;
      this.phone = phoneNumber;
      this.date = dates.toString();

    });
    
    _saveToFirebase();

    return userDetails;
  }

  Future _saveToFirebase () async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child('Users/$uid').set({
      'name' : name,
      'email': email,
      'uid' : uid,
      'phone' : phone,
      'profile pic url' : profilePic,
      'joining date' : date
      
    });

  }


   _saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    await sharedPreferences.setString('userName', name);
    await sharedPreferences.setString('userEmail', email);
    await sharedPreferences.setString('userProfilePic', profilePic);
    await sharedPreferences.setString('uid', uid);
    
    


  }

  // Future<void> _handleSignOut () async {
  //   try{
  //     await _googleSignIn.signOut();
  //   }
  //   catch (error){
  //     print(error);
  //   }
  // }

  
    
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: uI ==0 ? 
      //loadingUI() : welcomeUI()
       welcomeUI() : loadingUI()
    );
  }

  Widget loadingUI (){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 180,
            width: 180,
            child: CircularProgressIndicator(
              
              strokeWidth: 5,
              
              
              
            ),
          ),
          SizedBox(height: 25,),
          Text('Signing with google....',style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }

  Widget welcomeUI (){
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
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700,color: Colors.indigoAccent),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Explore every famous places in Bangladesh with the easiest way',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.grey[600]),
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
                child: 
                
                FlatButton.icon(
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
                    _signIn().whenComplete((){
                      _saveData();
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IntroPage()));
                    });
                    
                    
                  },
                )
                ),
            SizedBox(
              height: h * 0.12,
            )
          ],
        ),
      );
  }


}
