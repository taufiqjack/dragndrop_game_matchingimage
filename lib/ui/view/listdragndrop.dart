import 'package:dotted_border/dotted_border.dart';
import 'package:dragndrop/ui/data/data.dart';
import 'package:dragndrop/ui/data/string.dart';
import 'package:dragndrop/ui/widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListDragDrop extends StatefulWidget {
  const ListDragDrop({Key? key}) : super(key: key);

  @override
  _ListDragDropState createState() => _ListDragDropState();
}

class _ListDragDropState extends State<ListDragDrop> {
  final List<Birds> all = allBirds;
  final List<Birds> _merpati = [];
  final List<Birds> _pipit = [];
  final List<Birds> _perkutut = [];
  final List<Birds> _cenderawasih = [];
  final List<Birds> _beo = [];
  final List<Birds> _elang = [];

  void removeAll(Birds toRemove) {
    all.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    _merpati.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    _pipit.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    _perkutut.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    _cenderawasih.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Matching Images',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pasangkan gambar dibawah ini:',
                ),
              ),
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    imgList(
                      context,
                      birds: all,
                      birdsName: BirdsName.values,
                      onAccept: (data) => setState(() {
                        removeAll(data);
                        all.add(data);
                      }),
                    ),
                    Column(
                      children: [
                        target(
                          context,
                          text: MERPATI,
                          birds: _merpati,
                          birdsName: [BirdsName.merpati],
                          onAccept: (data) => setState(() {
                            removeAll(data);
                            _merpati.add(data);
                          }),
                        ),
                        target(
                          context,
                          text: PIPIT,
                          birds: _pipit,
                          birdsName: [BirdsName.pipit],
                          onAccept: (data) => setState(() {
                            removeAll(data);
                            _pipit.add(data);
                          }),
                        ),
                        target(
                          context,
                          text: PERKUTUT,
                          birds: _perkutut,
                          birdsName: [BirdsName.perkutut],
                          onAccept: (data) => setState(() {
                            removeAll(data);
                            _perkutut.add(data);
                          }),
                        ),
                        target(
                          context,
                          text: CENDERAWASIH,
                          birds: _cenderawasih,
                          birdsName: [BirdsName.cenderawasih],
                          onAccept: (data) => setState(() {
                            removeAll(data);
                            _cenderawasih.add(data);
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: null,
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imgList(
    BuildContext context, {
    required List<Birds> birds,
    required List<BirdsName> birdsName,
    required DragTargetAccept<Birds> onAccept,
  }) =>
      DragTarget<Birds>(
        builder: (context, cd, rj) => Column(
          children: [
            ...birds
                .map((bird) => Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SizedBox(
                        height: 70,
                        width: 100,
                        child: DraggableWidget(bird: bird))))
                .toList()
              ..shuffle()
          ],
        ),
        onWillAccept: (data) => true,
        onAccept: (data) {
          onAccept(data);
        },
      );

  Widget target(
    BuildContext context, {
    String? text,
    required List<Birds> birds,
    required List<BirdsName> birdsName,
    required DragTargetAccept<Birds> onAccept,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 20),
        child: DottedBorder(
          borderType: BorderType.RRect,
          strokeWidth: 2,
          radius: const Radius.circular(5),
          color: Colors.grey.shade400,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade500,
            ),
            height: 70,
            width: 100,
            child: DragTarget<Birds>(
              builder: (context, cd, rj) => Stack(
                children: [
                  Center(
                    child: buildText(text!),
                  ),
                  ...birds.map((bird) => DraggableWidget(bird: bird)).toList(),
                ],
              ),
              onWillAccept: (data) => true,
              onAccept: (data) {
                onAccept(data);
              },
            ),
          ),
        ),
      );

  Widget buildText(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );

  _listReorder(int oldListIndex, int newList) {
    setState(() {
      var movedList = allBirds.removeAt(oldListIndex);
      allBirds.insert(newList, movedList);
    });
  }
}
