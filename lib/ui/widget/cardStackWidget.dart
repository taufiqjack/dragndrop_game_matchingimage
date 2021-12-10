import 'package:dragndrop/core/viewmodel/data.dart';
import 'package:dragndrop/ui/resources/colors.dart';
import 'package:dragndrop/ui/widget/draggableWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardStackWidget extends StatelessWidget {
  const CardStackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: cardItems(context),
    );
  }

  List<Widget> cardItems(BuildContext context) {
    var cardItemdraggable;
    List<Widget> carditemLIst = [];
    if (Provider.of<Data>(context).itemsList!.length - 1 < 1) {
      cardItemdraggable = Container(
        height: 200.0,
        width: 200.0,
        child: const Card(
          color: Colors.grey,
          child: Center(
            child: Text(
              'NO_ITEMS_LEFT',
              style: TextStyle(
                fontSize: 25.0,
                color: white_color,
              ),
            ),
          ),
        ),
      );
    } else {
      for (int i = 0; i < Provider.of(context).itemList; i++) {
        cardItemdraggable = Container(
          child: DraggableWidget(i: i),
        );
      }
    }
    carditemLIst.add(cardItemdraggable);
    return carditemLIst;
  }
}
