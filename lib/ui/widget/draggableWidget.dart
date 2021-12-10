import 'package:dragndrop/core/model/card_item.dart';
import 'package:dragndrop/core/viewmodel/data.dart';
import 'package:dragndrop/ui/resources/colors.dart';
import 'package:dragndrop/ui/resources/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DraggableWidget extends StatelessWidget {
  final int i;
  CardItem? item;
  DraggableWidget({Key? key, required this.i, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: Provider.of<Data>(context).itemsList[i],
      childWhenDragging: Container(
        height: 200.0,
        width: 200.0,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: i >= 1
              ? Provider.of<Data>(context)
                  .itemsList
                  .elementAt(
                      (Provider.of<Data>(context).itemsList.length - 1) - 1)
                  .cardColor
              : Colors.grey,
          child: Center(
            child: Text(
              i > 1
                  ? '${Provider.of<Data>(context).itemsList.elementAt((Provider.of<Data>(context).itemsList.length - 1) - 1).content}'
                  : NO_ITEM_LEFT,
              style: const TextStyle(fontSize: 25, color: white_color),
            ),
          ),
        ),
      ),
      feedback: SizedBox(
        height: 200,
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          elevation: 2.0,
          color: Provider.of<Data>(context).itemsList[i].cardColor,
          child: Center(
            child: Text(
              '${Provider.of<Data>(context).itemsList[i].content}',
              style: TextStyle(fontSize: 25, color: white_color),
            ),
          ),
        ),
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          color: Provider.of<Data>(context).itemsList[i].cardColor,
          child: Center(
              child: Text(
            '${Provider.of<Data>(context).itemsList[i].content}',
            style: TextStyle(fontSize: 25, color: white_color),
          )),
        ),
      ),
    );
  }
}
