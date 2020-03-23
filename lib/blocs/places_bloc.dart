import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:talio_travel/models/icons.dart';

import 'package:talio_travel/models/places_data.dart';

class PlacesBloc extends ChangeNotifier {
  
  PlaceData placeData = PlaceData();
  List<PlaceData1> _allData = [];
  Icon _loveIcon = LoveIcon().loveIcon;
  Icon _bookmarkIcon = BookmarkIcon().bookmarkIcon;
  List<String> _placeList = [];
  List<int> _placeListInt = [];
  List<PlaceData1> _filteredData = [];


  //all procedures same as blog_bloc.dart

  PlacesBloc() {
    getData();
    getBookmarkedPlaceList();
  }

  set allData(newValue) {
    _allData = newValue;
  }

  set loveIcon(newIcon) {
    _loveIcon = newIcon;
  }

  set bookmarkIcon(newIcon) {
    _bookmarkIcon = newIcon;
  }

  set placeList(newItem) {
    _placeList = newItem;
  }

  set placeListInt(newItem) {
    _placeListInt = newItem;
  }

  set filteredData(newData) {
    _filteredData = newData;
  }

  List get allData => _allData;
  Icon get loveIcon => _loveIcon;
  Icon get bookmarkIcon => _bookmarkIcon;
  List get placeList => _placeList;
  List get placeListInt => _placeListInt;
  List get filteredData => _filteredData;

  getData() {
    _allData.clear();
    for (var i = 0; i < placeData.placeName.length; i++) {
      PlaceData1 d = PlaceData1(
          placeData.image[i],
          placeData.placeName[i],
          placeData.location[i],
          placeData.loves[i],
          placeData.views[i],
          placeData.comments[i],
          placeData.placeDeatails[i],
          placeData.imageList[i]);
      _allData.add(d);
    }

    // _allData.sort(
    //   (a,b) => a.loves.compareTo(b.loves)
    // );
  }

  viewsIncrement(index) {
    _allData[index].views++;
    notifyListeners();
  }

  loveIconCheck(placeName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.get('uid') ?? 'uid';
    bool checked = sp.getBool('$uid/$placeName/love') ?? false;
    if (checked == false) {
      _loveIcon = LoveIcon().loveIconNormal;
    } else {
      _loveIcon = LoveIcon().loveIconBold;
    }
    notifyListeners();
  }

  loveIconClicked(placeIndex, placeName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$placeName/love') ?? false;
    if (clicked == false) {
      sp.setBool('$uid/$placeName/love', true);
      _allData[placeIndex].loves++;
      _loveIcon = LoveIcon().loveIconBold;
    } else {
      sp.setBool('$uid/$placeName/love', false);
      _allData[placeIndex].loves--;
      _loveIcon = LoveIcon().loveIconNormal;
    }
    notifyListeners();
  }

  bookmarkIconCheck(placeName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool checked = sp.getBool('$uid/$placeName/bookmark') ?? false;
    List<String> _placeList1 = sp.getStringList('placeList') ?? [];
    _placeList = _placeList1;
    print(_placeList);
    if (checked == false) {
      _bookmarkIcon = BookmarkIcon().bookmarkIconNormal;
    } else {
      _bookmarkIcon = BookmarkIcon().bookmarkIconBold;
    }
    notifyListeners();
  }

  bookmarkIconClicked(index, placeName, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$placeName/bookmark') ?? false;
    if (clicked == false) {
      sp.setBool('$uid/$placeName/bookmark', true);
      Toast.show('Added to your bookmark list', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.grey[800]);
      _bookmarkIcon = BookmarkIcon().bookmarkIconBold;
      _placeList.add(index.toString());
      sp.setStringList('placeList', _placeList);
      print(_placeList);
    } else {
      sp.setBool('$uid/$placeName/bookmark', false);

      _bookmarkIcon = BookmarkIcon().bookmarkIconNormal;
      _placeList.remove(index.toString());
      sp.setStringList('placeList', _placeList);
      print(_placeList);
    }
    notifyListeners();
  }

  getBookmarkedPlaceList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> _placeList1 = sp.getStringList('placeList') ?? [];

    //converting stringlist to intlist
    _placeListInt = _placeList1.map(int.parse).toList();
    print(_placeListInt);
    notifyListeners();
  }

  afterSearch(value) {
    _filteredData = _allData
        .where((u) => (u.name.toLowerCase().contains(value.toLowerCase()) ||
            u.location.toLowerCase().contains(value.toLowerCase())))
        .toList();

    notifyListeners();
  }
}
