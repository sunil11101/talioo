import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ArticlesDetailsPage extends StatefulWidget {
  final String blogTitle,blogSubtitle,blogSource,blogImage,blogLoves;
  ArticlesDetailsPage({Key key, @required this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle}) : super(key: key);

  _ArticlesDetailsPageState createState() => _ArticlesDetailsPageState(this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle);
}

class _ArticlesDetailsPageState extends State<ArticlesDetailsPage> {

  String blogTitle,blogSubtitle,blogSource,blogImage,blogLoves;
  _ArticlesDetailsPageState(this.blogTitle,this.blogImage,this.blogLoves,this.blogSource,this.blogSubtitle);
  
  
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
                       icon: Icon(LineIcons.long_arrow_left), onPressed: () {},),
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
                     
                     icon: Icon(LineIcons.heart_o), onPressed: () {},),
                   IconButton(icon: Icon(LineIcons.bookmark_o), onPressed: () {},),

                 ],
               ),
              SizedBox(height: 10,),
              Container(
                height: 250,
                width: w,
                child: FadeInImage(
                  image: NetworkImage(blogImage),
                  placeholder: AssetImage('assets/travel1.png'),
                  fit: BoxFit.cover,
                ),
              ),

              Row(
                children: <Widget>[
                  FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    
                    icon: Icon(LineIcons.eye,color: Colors.grey[500],), label: Text('Views: 2000',style: TextStyle(color: Colors.grey[500]),), onPressed: () {},),
                  SizedBox(width: 30,),
                  FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    
                    icon: Icon(LineIcons.heart_o,color: Colors.grey[500],), label: Text('Loves: 200',style: TextStyle(color: Colors.grey[500]),), onPressed: () {},)
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