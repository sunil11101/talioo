import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key key}) : super(key: key);

  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();
  List userNames = [
    'Default User',
    
  ];

  List comments = ['Beautiful place'];
  List images = [
    'http://www.newdesignfile.com/postpic/2014/10/user-profile-icon-flat_248568.png'
  ];
  String timeNow;
  String name, picture;

   _getTime (){
    DateTime now = DateTime.now();
    String _date = DateFormat('dd-MM-yy  hh:mm a').format(now);
    setState(() {
      timeNow = _date;
    });
    print(timeNow);
  }

    Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _name = sharedPreferences.getString('userName') ?? 'name';
    
    var _pic = sharedPreferences.getString('userProfilePic') ?? 'pic';
    setState(() {
      this.name = _name;
      this.picture = _pic;
    });
    
  }

  @override
  void initState() {
    _getUserDetailsfromSP();
    _getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: h,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
        child: new Column(
          children: <Widget>[
            Container(
              height: 65,
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
                    'User Reviews (${comments.length})',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(top: 15,left: 5,bottom: 10,right: 10),
                    margin: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 2,
                          offset: Offset(1, 1)
                        )
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          height: 11,
                          child: Text(timeNow, style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                          ),),
                        ),
                        ListTile(
                          leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Colors.grey[700],
                            //   width: 0.1
                            // ),
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(images[index]),
                                fit: BoxFit.cover)),
                      ),
                      title: Text(
                        userNames[index],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        comments[index],
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                        )
                      ],
                    )
                    
                    
                    // ListTile(
                    //   leading: Container(
                    //     height: 50,
                    //     width: 50,
                    //     decoration: BoxDecoration(
                    //         // border: Border.all(
                    //         //   color: Colors.grey[700],
                    //         //   width: 0.1
                    //         // ),
                    //         color: Colors.grey[300],
                    //         shape: BoxShape.circle,
                    //         image: DecorationImage(
                    //             image:
                    //                 CachedNetworkImageProvider(images[index]),
                    //             fit: BoxFit.cover)),
                    //   ),
                    //   title: Text(
                    //     userNames[index],
                    //     style: TextStyle(
                    //         fontSize: 12, fontWeight: FontWeight.w600),
                    //   ),
                    //   subtitle: Text(
                    //     comments[index],
                    //     style: TextStyle(
                    //         fontSize: 16, fontWeight: FontWeight.w500),
                    //   ),
                    //   trailing: Column(
                    //     children: <Widget>[
                    //       Text(timeNow, style: TextStyle(
                    //         fontSize: 11
                    //       ),)
                    //     ],
                    //   ),
                    // ),
                  );
                },
              ),
            ),

            // Spacer(),
            Container(
              alignment: Alignment.center,
              height: 100,
              width: w,
              //color: Colors.grey[300],
              child: Form(
                key: formKey,
                child: TextFormField(
                    controller: textFieldCtrl,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      hintText: "Review this place",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            sendClicked();
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value.length == 0)
                        return ("Comments can't be empty!");

                      return value = null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        comments.add(value);
                        images.add(picture);
                        userNames.add(name);
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void sendClicked() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      textFieldCtrl.clear();
      FocusScope.of(context).unfocus();
    }
  }
}
