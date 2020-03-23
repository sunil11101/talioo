//icons data

import 'package:flutter/material.dart';

class LoveIcon {
  Icon loveIcon = Icon(
    Icons.favorite_border,
    color: Colors.grey,
  );
  Icon loveIconNormal = Icon(
    Icons.favorite_border,
    color: Colors.grey,
  );
  Icon loveIconBold = Icon(
    Icons.favorite,
    color: Colors.pinkAccent,
  );
}

class BookmarkIcon {
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
}

class CategoryIcon {
  IconData categoryIcon;
  bool isSelected;
  CategoryIcon(this.categoryIcon, this.isSelected);
}

List<CategoryIcon> categoryIcons = [
  CategoryIcon(Icons.flight, false),
  CategoryIcon(Icons.directions_car, true),
  CategoryIcon(Icons.panorama, false),
  CategoryIcon(Icons.motorcycle, false),
];