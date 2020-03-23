import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/places_bloc.dart';


// search page

import 'package:talio_travel/pages/details.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  String txt = 'SUGGESTED PLACES';
  var formKey = GlobalKey<FormState>();  // getting global key for textfield
  var textFieldCtrl = TextEditingController();


  

  
  // building suggestion list
  Widget beforeSearchUI(placesBloc) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.8,
      children: List.generate(placesBloc.allData.length, (index) {
        return InkWell(
          child: Hero(
            tag: 'heroExplore$index',
            child: GridTile(
                child: Stack(
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: placesBloc.allData[index].image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey[200],
                              offset: Offset(5, 5),
                              blurRadius: 2),
                        ],
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Icon(
                      LineIcons.photo,
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),

                  
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  right: 5,
                  child: Text(
                    placesBloc.allData[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    placesBloc.allData[index].location,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 80,
                    child: FlatButton.icon(
                      padding: EdgeInsets.all(0),
                      color: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      icon: Icon(
                        LineIcons.heart,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        '${placesBloc.allData[index].loves.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            )),
          ),
          onTap: () {
            placesBloc.viewsIncrement(index);
            placesBloc.loveIconCheck(placesBloc.allData[index].name);
            placesBloc.bookmarkIconCheck(placesBloc.allData[index].name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          placeName: placesBloc.allData[index].name,
                          placeLocation: placesBloc.allData[index].location,
                          loves: placesBloc.allData[index].loves,
                          views: placesBloc.allData[index].views,
                          comments: placesBloc.allData[index].comments,
                          picturesList: placesBloc.allData[index].imageList,
                          placeDetails: placesBloc.allData[index].details,
                          heroTag: 'heroExplore$index',
                          placeIndex: index,
                        )));
          },
        );
      }),
    ));
  }


  // building a list of search item
  Widget afterSearchUI(placesBloc) {
    return Expanded(
      child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.8,
      children: List.generate(placesBloc.filteredData.length, (index) {
        return InkWell(
          child: Hero(
            tag: 'heroExplore$index',
            child: GridTile(
                child: Stack(
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: placesBloc.filteredData[index].image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey[200],
                              offset: Offset(5, 5),
                              blurRadius: 2),
                        ],
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Icon(
                      LineIcons.photo,
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),

                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  right: 5,
                  child: Text(
                    placesBloc.filteredData[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    placesBloc.filteredData[index].location,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 80,
                    child: FlatButton.icon(
                      padding: EdgeInsets.all(0),
                      color: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      icon: Icon(
                        LineIcons.heart,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        '${placesBloc.filteredData[index].loves.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            )),
          ),
          onTap: () {
            placesBloc.viewsIncrement(index);
            placesBloc.loveIconCheck(placesBloc.filteredData[index].name);
            placesBloc.bookmarkIconCheck(placesBloc.filteredData[index].name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          placeName: placesBloc.filteredData[index].name,
                          placeLocation: placesBloc.filteredData[index].location,
                          loves: placesBloc.filteredData[index].loves,
                          views: placesBloc.filteredData[index].views,
                          comments: placesBloc.filteredData[index].comments,
                          picturesList: placesBloc.filteredData[index].imageList,
                          placeDetails: placesBloc.filteredData[index].details,
                          heroTag: 'heroExplore$index',
                          placeIndex: index,
                        )));
          },
        );
      }),
    ));
  }



  @override
  Widget build(BuildContext context) {
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context);
    double w = MediaQuery.of(context).size.width;
    

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 24,
          ),

          // search bar

          Container(
            alignment: Alignment.center,
            height: 65,
            width: w,
            decoration: BoxDecoration(
                //color: Colors.white
                ),
            child: Form(
              key: formKey,
              child: TextFormField(
                autofocus: true,
                controller: textFieldCtrl,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search & Explore Places",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500]),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.grey[800],
                      ),
                      color: Colors.grey[800],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[800],
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        textFieldCtrl.clear();
                      });
                    },
                  ),
                ),

                //keyboardType: TextInputType.datetime,

                validator: (value) {
                  if (value.length == 0) return ("Comments can't be empty!");

                  return value = null;
                },
                // onSaved: (String value) {},
                onChanged: (String value) {
                  placesBloc.afterSearch(value);
                },
              ),
            ),
          ),

          Container(
            height: 1,
            child: Divider(
              color: Colors.grey,
            ),
          ),

          // suggestion text

          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              txt,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            ),
          ),

          
          //afterSearchUI()
          placesBloc.filteredData.isEmpty ? beforeSearchUI(placesBloc) : afterSearchUI(placesBloc)    //choosing which page appear first
        ],
      ),
    );
  }
}
