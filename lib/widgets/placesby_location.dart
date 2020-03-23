import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:talio_travel/pages/placelist.dart';


// used in home page

Widget placesBylocation(w) {
  
    List placesByLocation = [
    'Dhaka',
    'Chittagong',
    'Sylhet',
    'Rajshahi',
    'Khulna',
    'Barisal',
    'Rangpur',
    'Mymensingh'
  ];

    return Container(
      height: 900,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: placesByLocation.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: w * 0.92,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(5, 5),
                        blurRadius: 1)
                  ]),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      LineIcons.location_arrow,
                      size: 25,
                      color: Colors.white,
                    )),
                title: Text(
                  placesByLocation[index],
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '5 Places',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                  icon: Icon(
                    LineIcons.arrow_right,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceListPage(
                                title: placesByLocation[index],
                              )));
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceListPage(
                                title: placesByLocation[index],
                              )));
                },
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
