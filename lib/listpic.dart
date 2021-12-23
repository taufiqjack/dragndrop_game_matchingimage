import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:dragndrop/ui/data/data.dart';
import 'package:dragndrop/ui/view/listdragndrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

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
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    super.initState();

    List _listImage = allBirds;

    _lists = List.generate(2, (outerIndex) {
      return InnerList(
          name: outerIndex.toString(),
          children: List.generate(
            4,
            (innerIndex) => 'assets/images/merpati.jpg',
          ));
    });
  }

  @override
  void dispose() {
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drop n Drag',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Stack(alignment: Alignment.topCenter, children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text('Pasangkan Gambar dibawah ini'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            // child: Text(
            //   'Score : ',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey)),
              height: double.infinity,
              width: double.infinity,
              child: DragAndDropLists(
                children:
                    List.generate(_lists!.length, (index) => _buildList(index)),

                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
                axis: Axis.horizontal,
                disableScrolling: false,
                listWidth: 150,
                listDraggingWidth: double.infinity,
                // listDecoration: BoxDecoration(
                //   color: Colors.grey[200],
                //   borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                // boxShadow: const <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.black45,
                //     spreadRadius: 3.0,
                //     blurRadius: 6.0,
                //     offset: Offset(2, 3),
                //   ),
                // ],
                // ),
                listPadding: const EdgeInsets.all(8.0),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListDragDrop()));
                },
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                )),
              )),
        ]),
      ),
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
              padding: const EdgeInsets.all(5),
            ),
          ),
        ],
      ),
      // leftSide: const VerticalDivider(
      //   width: 1.5,
      //   thickness: 1.5,
      // ),
      // rightSide: const VerticalDivider(
      //   width: 1.5,
      //   thickness: 1.5,
      // ),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index])),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
        child: Column(
      children: [
        Image.asset(item),
        const SizedBox(
          height: 10,
        )
      ],
    ));
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
