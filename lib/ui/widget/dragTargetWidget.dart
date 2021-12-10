import 'package:dotted_border/dotted_border.dart';
import 'package:dragndrop/core/model/card_item.dart';
import 'package:dragndrop/core/viewmodel/data.dart';
import 'package:dragndrop/ui/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragTargetWidget extends StatelessWidget {
  const DragTargetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget(onWillAccept: (data) {
      return true;
    }, onAccept: (CardItem data) {
      if (Provider.of<Data>(context).itemsList.length >= 1) {
        Provider.of<Data>(context).removeLastItem();
        Provider.of<Data>(context).changeSuccesDrop(true);
        Provider.of<Data>(context).changeAcceptedData(data);
      }
    }, builder: (BuildContext context, List<CardItem?> cd, List<dynamic> rd) {
      //  builder: (context, List<CardItem> cd, rd) {
      if (Provider.of<Data>(context).isSucessDrop) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children:
                buildTargetList(Provider.of<Data>(context).getAcceptedData)!,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: DottedBorder(
            color: Colors.black,
            strokeCap: StrokeCap.round,
            strokeWidth: 3,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.grey.shade400,
              child: const Center(
                child: Text(
                  'DROP ITEM HERE',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  List<Widget>? buildTargetList(CardItem cardItem) {
    List<Widget> targetList = [];
    targetList.add(DottedBorder(
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      strokeWidth: 3,
      color: Colors.black,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${cardItem.content}',
            style: TextStyle(fontSize: 25, color: white_color),
          ),
        ),
      ),
    ));
  }
}
