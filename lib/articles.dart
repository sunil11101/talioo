
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/articles_details.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/variables.dart';

String blogImage = 'https://www.motherjones.com/wp-content/uploads/2019/07/20180529__NATURE_2000.jpg?w=990';


class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {

  String blogTitle = 'ভিসা ছাড়া যেসব দেশে ভ্রমণ করতে পারবেন';
  String blogSubtitle = 'টিম সব সময় চেষ্টা করছে আপনাদের কাছে  হালনাগাদ তথ্য উপস্থাপন করতে। যদি কোন তথ্যগত ভুল কিংবা স্থান সম্পর্কে আপনার কোন পরামর্শ থাকে';
  String blogLink = '';
  String blogSource = 'The Daily Star';
  String love = '10';
  



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return 
        Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Travel Hour Blog'),
          elevation: 0.5,
          actions: <Widget>[
            IconButton(icon: Icon(LineIcons.sort), onPressed: () {},)
          ],
          
        ),
        backgroundColor: Colors.grey[100],
        
        body : ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 415,
        //width: w * 0.80,
        child: InkWell(
            child: Card(
            margin: EdgeInsets.only(top: 12,left: 15,right: 15,bottom: 0),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ) ,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 230,
                  width: w,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //shape: circle,
                    image: DecorationImage(
                      image: NetworkImage(imageList[index]),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                // FadeInImage(
                //     placeholder: AssetImage('assets/travel1.png'),
                //     image: NetworkImage(imageList[index]),
                //     fit: BoxFit.cover,
                //     height: 230,
                //     width: w,

                    
                //   ),
                
                
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 15,bottom: 5,right: 5),
                  child: Text(blogTitle,style: textStyleBold,),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 0,left: 15,bottom: 10,right: 5),
                  child: Text(blogSubtitle,style: TextStyle(color: Colors.grey,fontSize: 14),),
                ),

                Expanded(
                                    child: Padding(
                    padding: const EdgeInsets.only(top: 5,left: 15,right: 5,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(LineIcons.copyright,color: Colors.blueAccent,),
                        SizedBox(width: 5,),
                        Text(blogSource,style: TextStyle(color: Colors.grey[700],fontSize: 14,fontWeight: FontWeight.w600),),
                        Spacer(),
                        FlatButton.icon(
                          
                          padding: EdgeInsets.all(0),
                          
                          icon: Icon(LineIcons.heart_o,size: 20,), onPressed: () {}, label: Text('200'),),
                        // IconButton(icon: Icon(LineIcons.bookmark,size: 20,), onPressed: () {},),


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          onTap:(){ Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticlesDetailsPage(
              blogTitle: blogTitle,
              blogImage: imageList[index],
              blogSubtitle: blogSubtitle,
              
              blogSource: blogSource,
              blogLoves: love
            )
          ));}
        ),
      );
     },
    )
      );
   
  }
}




