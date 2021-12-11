import 'dart:math';

import 'package:dragndrop/ui/data/data.dart';
import 'package:dragndrop/ui/data/string.dart';
import 'package:dragndrop/ui/widget/draggableWidget.dart';
import 'package:flutter/material.dart';

class ListDragDrop extends StatefulWidget {
  ListDragDrop({Key? key}) : super(key: key);

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
        title: const Text(
          'Drag n Drop',
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              target(
                context,
                text: '',
                birds: all,
                birdsName: BirdsName.values,
                onAccept: (data) => setState(() {
                  removeAll(data);
                  all.add(data);
                }),
              ),
              target(
                context,
                text: '',
                birds: all,
                birdsName: BirdsName.values,
                onAccept: (data) => setState(() {
                  removeAll(data);
                  all.add(data);
                }),
              ),
              target(
                context,
                text: '',
                birds: all,
                birdsName: BirdsName.values,
                onAccept: (data) => setState(() {
                  removeAll(data);
                  all.add(data);
                }),
              ),
              target(
                context,
                text: '',
                birds: all,
                birdsName: BirdsName.values,
                onAccept: (data) => setState(() {
                  removeAll(data);
                  all.add(data);
                }),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          )
        ],
      ),
    );
  }

  Widget target(
    BuildContext context, {
    String? text,
    required List<Birds> birds,
    required List<BirdsName> birdsName,
    required DragTargetAccept<Birds> onAccept,
  }) =>
      Container(
          height: 100,
          width: 100,
          color: Colors.blue,
          child: DragTarget<Birds>(
            builder: (context, cd, rj) => Stack(
              children: [
                ...birds.map((bird) => DraggableWidget(bird: bird)).toList(),
                IgnorePointer(
                  child: Center(
                    child: buildText(text!),
                  ),
                ),
              ],
            ),
            onWillAccept: (data) => true,
            onAccept: (data) {
              onAccept(data);
            },
          ));

  Widget buildText(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
}
