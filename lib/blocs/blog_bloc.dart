import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:travel_hour/models/blog.dart';
import 'package:travel_hour/models/icons.dart';







class BlogBloc extends ChangeNotifier{

  

  

  BlogData blogData = BlogData();
  List<BlogData1> _allData = [];
  String _popSelection = 'love';
  Icon _loveIcon = LoveIcon().loveIcon;
  Icon _bookmarkIcon = BookmarkIcon().bookmarkIcon;
  List<String> _blogList = [];
  List<int> _blogListInt = [];


  BlogBloc(){
    getData();
    getBookmarkedBlogList();
  }


  set allData (newValue){
    _allData = newValue;
    
  }

  set popSelection (newValue){
    _popSelection = newValue;
    
  }

  set loveIcon (newIcon){
    _loveIcon = newIcon; 
  }

  set bookmarkIcon (newIcon){
    _bookmarkIcon = newIcon;
    
    
  }

  set blogList (newItem){
    _blogList = newItem;
    
  }

  set blogListInt (newItem){
    _blogListInt = newItem;
  }

  List get allData => _allData;
  String get popSelection => _popSelection;
  Icon get loveIcon => _loveIcon;
  Icon get bookmarkIcon => _bookmarkIcon;
  List get blogList => _blogList;
  List get blogListInt => _blogListInt;


  getData() {
    _allData.clear();
    for (var i = 0; i < blogData.blogTitle.length; i++) {
      BlogData1 d = BlogData1(
          blogData.blogTitle[i],
          blogData.blogDetails[i],
          blogData.blogSource[i],
          blogData.blogImage[i],
          blogData.blogViews[i],
          blogData.blogLoves[i],
          blogData.blogListIndex[i]
          );
          

      _allData.add(d);
    }
    afterPopSelection(_popSelection);
  }

  afterPopSelection (value){
    _popSelection = value;
    _popSelection == 'view'?
    _allData.sort((a, b) => b.views.compareTo(a.views)) :
    _allData.sort((a, b) => b.loves.compareTo(a.loves));
    
    notifyListeners();
    
    
  }





  viewsIncrement (index){
    _allData[index].views++;
    notifyListeners();
    
  }

  loveIconCheck (blogTitle)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.get('uid') ?? 'uid';
    bool checked = sp.getBool('$uid/$blogTitle/love') ?? false;
    if (checked == false) {
      _loveIcon = LoveIcon().loveIconNormal;
      
    } else {
      _loveIcon = LoveIcon().loveIconBold;  
      
    }
    notifyListeners();
    
  }

  loveIconClicked (blogindex,blogTitle)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/love') ?? false;
     if (clicked == false) {
      sp.setBool('$uid/$blogTitle/love', true);
      _allData[blogindex].loves++;
      _loveIcon = LoveIcon().loveIconBold;
    } else {
      sp.setBool('$uid/$blogTitle/love', false);
      _allData[blogindex].loves--;
      _loveIcon = LoveIcon().loveIconNormal;
    }
    
    notifyListeners();
  }

  bookmarkIconCheck (blogTitle) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool checked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;
    List<String> _blogList1 = sp.getStringList('blogList') ?? [];
    _blogList = _blogList1;
    print(_blogList);
    if (checked == false) {
      _bookmarkIcon = BookmarkIcon().bookmarkIconNormal;
    } else {
      _bookmarkIcon = BookmarkIcon().bookmarkIconBold;
    }
    notifyListeners();
    
  }

  bookmarkIconClicked (index, blogTitle, context) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;
    if (clicked == false) {
      sp.setBool('$uid/$blogTitle/bookmark', true);
      Toast.show('Added to your bookmark list', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.grey[800]);
      _bookmarkIcon = BookmarkIcon().bookmarkIconBold;
      _blogList.add(index.toString());
      sp.setStringList('blogList', _blogList);
      print(blogList);
    } else {
      sp.setBool('$uid/$blogTitle/bookmark', false);

      _bookmarkIcon = BookmarkIcon().bookmarkIconNormal;
      _blogList.remove(index.toString());
      sp.setStringList('blogList', _blogList);
      print(blogList);
    }

    notifyListeners();
  }

  getBookmarkedBlogList ()async {
    
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> _blogList1 = sp.getStringList('blogList') ?? [];
    
      //converting stringlist to intlist
      _blogListInt = _blogList1.map(int.parse).toList();
      print(_blogListInt);
      
      notifyListeners();
  }





}



  

