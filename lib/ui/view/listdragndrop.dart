import 'package:dotted_border/dotted_border.dart';
import 'package:dragndrop/ui/data/data.dart';
import 'package:dragndrop/ui/data/string.dart';
import 'package:dragndrop/ui/widget/draggableWidget.dart';
import 'package:flutter/material.dart';

class ListDragDrop extends StatefulWidget {
  const ListDragDrop({Key? key}) : super(key: key);

  @override
  _ListDragDropState createState() => _ListDragDropState();
}

class _ListDragDropState extends State<ListDragDrop> {
  final List<Birds> all = allBirds;
  final List<Birds> merpati = [];
  final List<Birds> pipit = [];
  final List<Birds> perkutut = [];
  final List<Birds> cenderawasih = [];

  void removeAll(Birds toRemove) {
    all.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    merpati.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    pipit.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    perkutut.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
    cenderawasih.removeWhere((bird) => bird.imgAsset == toRemove.imgAsset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {},
        ),
        title: const Text(
          'Matching Images',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pasangkan gambar dibawah ini:',
              ),
            ),
            Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  fromList(
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
                        birds: merpati,
                        birdsName: [BirdsName.Merpati],
                        onAccept: (data) => setState(() {
                          removeAll(data);
                          merpati.add(data);
                        }),
                      ),
                      target(
                        context,
                        text: PIPIT,
                        birds: pipit,
                        birdsName: [BirdsName.Pipit],
                        onAccept: (data) => setState(() {
                          removeAll(data);
                          pipit.add(data);
                        }),
                      ),
                      target(
                        context,
                        text: PERKUTUT,
                        birds: perkutut,
                        birdsName: [BirdsName.Perkutut],
                        onAccept: (data) => setState(() {
                          removeAll(data);
                          perkutut.add(data);
                        }),
                      ),
                      target(
                        context,
                        text: CENDERAWASIH,
                        birds: cenderawasih,
                        birdsName: [BirdsName.Cenderawasih],
                        onAccept: (data) => setState(() {
                          removeAll(data);
                          cenderawasih.add(data);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fromList(
    BuildContext context, {
    required List<Birds> birds,
    required List<BirdsName> birdsName,
    required DragTargetAccept<Birds> onAccept,
  }) =>
      DragTarget<Birds>(
        builder: (context, cd, rj) => Column(
          children: [
            ...birds
                .map((bird) => SizedBox(
                    height: 100,
                    width: 100,
                    child: DraggableWidget(bird: bird)))
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
            height: 75,
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
}
