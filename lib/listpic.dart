import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class ListPic extends StatefulWidget {
  const ListPic({Key? key}) : super(key: key);

  @override
  _ListPic createState() => _ListPic();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _ListPic extends State<ListPic> {
  List<InnerList>? _lists;

  @override
  void initState() {
    super.initState();

    _lists = List.generate(2, (outerIndex) {
      return InnerList(
          name: outerIndex.toString(),
          children: List.generate(
            4,
            (innerIndex) => 'assets/images/bird1.jpg',
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drop n Drag'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Score : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 70, 25, 10),
          child: DragAndDropLists(
            children:
                List.generate(_lists!.length, (index) => _buildList(index)),
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
            axis: Axis.horizontal,
            listWidth: 150,
            listDraggingWidth: 150,
            listDecoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 3.0,
                  blurRadius: 6.0,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            listPadding: const EdgeInsets.all(8.0),
          ),
        )
      ]),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists![outerIndex];
    return DragAndDropList(
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
      footer: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
      leftSide: const VerticalDivider(
        width: 1.5,
        thickness: 1.5,
      ),
      rightSide: const VerticalDivider(
        width: 1.5,
        thickness: 1.5,
      ),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index])),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(title: Image.asset(item)),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists![oldListIndex].children.removeAt(oldItemIndex);
      _lists![newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists!.removeAt(oldListIndex);
      _lists!.insert(newListIndex, movedList);
    });
  }
}
