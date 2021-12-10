import 'package:dragndrop/core/model/card_item.dart';
import 'package:dragndrop/ui/resources/constant.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  bool? successdDrop;
  List<CardItem>? items;
  CardItem? acceptedData;
  Color? acceptedColor;

  Data() {
    successdDrop = false;
    acceptedColor = Colors.blue;

    items = Constants.initializeList(items!);
  }

  bool get isSucessDrop => successdDrop!;
  List<CardItem> get itemsList => items!;
  CardItem get getAcceptedData => acceptedData!;
  Color get getAcceptedColor => acceptedColor!;

  set setSuccessDrop(bool status) {
    successdDrop = status;
    notifyListeners();
  }

  changeAcceptedData(CardItem data) {
    acceptedData = data;
    notifyListeners();
  }

  changeAcceptedColor(Color color) {
    acceptedColor = color;
    notifyListeners();
  }

  changeSuccesDrop(bool status) {
    setSuccessDrop = status;
  }

  removeLastItem() {
    items!.removeLast();
    notifyListeners();
  }

  addItemList(CardItem item) {
    items!.add(item);
    notifyListeners();
  }

  initializeDraggableList() {
    items = Constants.initializeList(items!);
    notifyListeners();
  }
}
