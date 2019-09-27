import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ArticlesDetailsPage extends StatefulWidget {
  final String blogTitle,blogSubtitle,blogSource,blogImage,blogLoves,heroTag;
  ArticlesDetailsPage({Key key, @required this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle,this.heroTag}) : super(key: key);

  _ArticlesDetailsPageState createState() => _ArticlesDetailsPageState(this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle,this.heroTag);
}

class _ArticlesDetailsPageState extends State<ArticlesDetailsPage> {

  String blogTitle,blogSubtitle,blogSource,blogImage,blogLoves,heroTag;
  _ArticlesDetailsPageState(this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle,this.heroTag);

  Icon loveIcon = Icon(Icons.favorite_border,color: Colors.grey,);
  Icon loveIconNormal = Icon(Icons.favorite_border,color: Colors.grey,);
  Icon loveIconBold = Icon(
    Icons.favorite,
    color: Colors.pinkAccent,
  );
  int loveAmount;
  int viewsAmount;

  Icon bookmarkIcon = Icon(
    Icons.bookmark_border,
    color: Colors.grey,
  );
  Icon bookmarkIconNormal = Icon(
    Icons.bookmark_border,
    color: Colors.grey,
  );
  Icon bookmarkIconBold = Icon(
    Icons.bookmark,
    color: Colors.grey[700],
  );


  _viewsCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int views = sp.getInt('$blogTitle/views') ?? 10000;
    int _viewsAmount = (views + (1));
    sp.setInt('$blogTitle/views', _viewsAmount);
    setState(() {
      viewsAmount = _viewsAmount;
    });
  }

  _loveIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';
    bool checked = sp.getBool('$uid/$blogTitle/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$blogTitle/loveAmount') ?? 10;
    if (checked == false) {
      setState(() {
        loveIcon = loveIconNormal;
        loveAmount = _loveAmount;
      });
    } else {
      setState(() {
        loveIcon = loveIconBold;
        loveAmount = _loveAmount;
      });
    }
  }

  _loveIconClicked() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$blogTitle/loveAmount') ?? 10;
    if (clicked == false) {
      sp.setBool('$uid/$blogTitle/love', true);
      int count = (_loveAmount + (1));
      setState(() {
        loveIcon = loveIconBold;
        sp.setInt('$uid/$blogTitle/loveAmount', count);
        loveAmount = count;
      });
    } else {
      sp.setBool('$uid/$blogTitle/love', false);
      int count = (_loveAmount - (1));
      setState(() {
        loveIcon = loveIconNormal;
        sp.setInt('$uid/$blogTitle/loveAmount', count);
        loveAmount = count;
      });
    }
  }

  _bookmarkIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool checked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;

    if (checked == false) {
      setState(() {
        bookmarkIcon = bookmarkIconNormal;
      });
    } else {
      setState(() {
        bookmarkIcon = bookmarkIconBold;
      });
    }
  }

  _bookmarkIconClicked() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;

    if (clicked == false) {
      sp.setBool('$uid/$blogTitle/bookmark', true);
      Toast.show('Added to your bookmark list', context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey
      );
      setState(() {
        bookmarkIcon = bookmarkIconBold;
      });
    } else {
      sp.setBool('$uid/$blogTitle/bookmark', false);

      setState(() {
        bookmarkIcon = bookmarkIconNormal;
      });
    }
  }


  @override
  void initState() { 
    _viewsCheck();
    _loveIconCheck();
    _bookmarkIconCheck();
    super.initState();
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 10,top: 25),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Container(
                 height: 56,
                 width: w,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     IconButton(
                       alignment: Alignment.centerLeft,
                       padding: EdgeInsets.all(0),
                       icon: Icon(LineIcons.long_arrow_left), onPressed: () {
                         Navigator.pop(context);
                       },),
                     Spacer(),
                     IconButton(icon: Icon(Icons.share,size: 22,), onPressed: () {},),

                   ],
                 ),
                 
               ),
               SizedBox(height: 10,),
               Text('Travel Hour Blog'),
               SizedBox(height: 15,),
               Text(blogTitle,style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w600),),
               Row(
                 children: <Widget>[
                   FlatButton.icon(
                     
                     padding: EdgeInsets.all(0),
                     icon: Icon(LineIcons.copyright,size: 20,color: Colors.indigoAccent,), label: Text(blogSource,style: TextStyle(color: Colors.grey[600]),), onPressed: () {},),
                   Spacer(),
                   IconButton(
                     
                     icon: loveIcon, onPressed: () {
                       _loveIconClicked();
                     },),

                   IconButton(icon: bookmarkIcon, onPressed: () {
                     _bookmarkIconClicked();
                   },),

                 ],
               ),
              SizedBox(height: 10,),
              Hero(
                  tag: heroTag,
                  child: Container(
                  height: 250,
                  width: w,
                  child: FadeInImage(
                    image: NetworkImage(blogImage),
                    placeholder: AssetImage('assets/travel1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    
                  icon: Icon(LineIcons.eye,color: Colors.grey[500],), label: Text('Views: $viewsAmount',style: TextStyle(color: Colors.grey[500]),), onPressed: () {},),
                  SizedBox(width: 30,),
                  FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    
                    icon: Icon(LineIcons.heart_o,color: Colors.grey[500],), label: Text('Loves: $loveAmount',style: TextStyle(color: Colors.grey[500]),), onPressed: () {},)
                ],
              ),
              SizedBox(height: 15,),

              Text('$blogSubtitle $blogSubtitle \n\n$blogSubtitle $blogSubtitle\n\n$blogSubtitle \n\n$blogSubtitle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(height: 30,)
              

              


                
                    ]
                  ),
        ),
        ),
            );
          
        
    
  }
}