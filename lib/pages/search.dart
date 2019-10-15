import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/details.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String txt = 'SUGGESTED PLACES';
  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();

  List<PlaceData1> _allData = [];
  PlaceData placeData = PlaceData();
  List<PlaceData1> _filteredData = [];
  

  _getData() {
    for (var i = 0; i < placeData.placeName.length; i++) {
      PlaceData1 d = PlaceData1(
          placeData.image[i],
          placeData.placeName[i],
          placeData.location[i],
          placeData.loves[i],
          placeData.views[i],
          placeData.comments[i],
          placeData.placeDeatails[i]);
      _allData.add(d);
    }
  }

  _afterSearch(value) {
    setState(() {
      _filteredData = _allData
          .where((u) => (u.name.toLowerCase().contains(value.toLowerCase()) ||
              u.location.toLowerCase().contains(value.toLowerCase())))
          .toList();
    });
  }

  Widget beforeSearchUI() {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.8,
      children: List.generate(_allData.length, (index) {
        return InkWell(
          child: Hero(
            tag: 'heroExplore$index',
            child: GridTile(
                child: Stack(
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: imageList[index],
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

                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10),
                  //   boxShadow: <BoxShadow> [
                  //     BoxShadow(
                  //       blurRadius: 2,
                  //       color: Colors.grey[200],
                  //       offset: Offset(5, 5)
                  //     )
                  //   ],
                  //   image: DecorationImage(

                  //     image: NetworkImage(imageList[index],),
                  //     fit: BoxFit.cover
                  //   )
                  // ),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  child: Text(
                    _allData[index].name,
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
                    _allData[index].location,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
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
                        '${_allData[index].loves.toString()}',
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          placeName: _allData[index].name,
                          placeLocation: _allData[index].location,
                          loves: _allData[index].loves.toString(),
                          views: _allData[index].views.toString(),
                          comments: _allData[index].comments.toString(),
                          picturesList: imageList,
                          placeDetails: _allData[index].details,
                          heroTag: 'heroExplore$index',
                          placeIndex: index,
                        )));
          },
        );
      }),
    ));
  }

  Widget afterSearchUI() {
    return Expanded(
      child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.8,
      children: List.generate(_filteredData.length, (index) {
        return InkWell(
          child: Hero(
            tag: 'heroExplore$index',
            child: GridTile(
                child: Stack(
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: _filteredData[index].image,
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

                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10),
                  //   boxShadow: <BoxShadow> [
                  //     BoxShadow(
                  //       blurRadius: 2,
                  //       color: Colors.grey[200],
                  //       offset: Offset(5, 5)
                  //     )
                  //   ],
                  //   image: DecorationImage(

                  //     image: NetworkImage(imageList[index],),
                  //     fit: BoxFit.cover
                  //   )
                  // ),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  right: 5,
                  child: Text(
                    _filteredData[index].name,
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
                    _filteredData[index].location,
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
                        '${_filteredData[index].loves.toString()}',
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          placeName: _filteredData[index].name,
                          placeLocation: _filteredData[index].location,
                          loves: _filteredData[index].loves.toString(),
                          views: _filteredData[index].views.toString(),
                          comments: _filteredData[index].comments.toString(),
                          picturesList: imageList,
                          placeDetails: _filteredData[index].details,
                          heroTag: 'heroExplore$index',
                          placeIndex: index,
                        )));
          },
        );
      }),
    ));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

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
                onSaved: (String value) {},
                onChanged: (String value) {
                  this._afterSearch(value);
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
          _filteredData.isEmpty ? beforeSearchUI() : afterSearchUI()
        ],
      ),
    );
  }
}
