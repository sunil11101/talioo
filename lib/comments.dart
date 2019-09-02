import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key key}) : super(key: key);

  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();
  List userNames = [
    'Rakib Bhuiyan',
    'Tonmoy',
    'Rakib Hasan',
    'Tanvir Sohan',
    'Moon Roy'
  ];

  List commentsList = [
    'This is the most beautiful place i have ever seen in my whole life',
    'Nice place',
    'Nice place',
    'This is the most beautiful place i have ever seen in my whole life, This is the most beautiful place i have ever seen in my whole life',
    'Nice place',
  ];

  List comments = ['nice'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: h,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
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
                  return Card(
                    elevation: 0.8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 10, bottom: 15),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.pinkAccent,
                            child: Icon(LineIcons.user)),
                        title: Text(
                          userNames[index],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          comments[index],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
                    

                    //keyboardType: TextInputType.datetime,

                    validator: (value) {
                      if (value.length == 0)
                        return ("Comments can't be empty!");

                      return value = null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        comments.add(value);
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
