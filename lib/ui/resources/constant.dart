import 'package:dragndrop/core/model/card_item.dart';
import 'package:dragndrop/ui/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static String SPLASH_SCREEN = 'SPLASH_SCREEN';
  static String HOME_SCREEN = 'HOME_SCREEN';

  static List<CardItem> initializeList(List<CardItem> itemList) {
    itemList = [
      CardItem(content: 'Merpati', cardColor: Colors.green),
      CardItem(content: 'Pipit', cardColor: red_color),
      CardItem(content: 'Cenderawasih', cardColor: orange_color),
      CardItem(content: 'Perkutut', cardColor: green_color),
    ];

    return itemList;
  }
}
