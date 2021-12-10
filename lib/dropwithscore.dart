import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropWithScore extends StatefulWidget {
  const DropWithScore({Key? key}) : super(key: key);

  @override
  _DropWithScoreState createState() => _DropWithScoreState();
}

class _DropWithScoreState extends State<DropWithScore> {
  List<ItemModel>? items;
  List<ItemModel>? item2;
  int? score;
  bool? gameOver;

  @override
  void initState() {
    super.initState();
    gameScore();
  }

  gameScore() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
        name: "Pipit",
        value: 'pipit',
        icon: FontAwesomeIcons.google,
        img: const AssetImage('assets/images/pipit.jpg'),
      ),
      ItemModel(
          name: "Perkutut",
          value: 'perkutut',
          icon: FontAwesomeIcons.linkedin,
          img: const AssetImage(
            'assets/images/perkutut.jpg',
          )),
      ItemModel(
        name: "Merpati",
        value: 'merpati',
        icon: FontAwesomeIcons.twitter,
        img: const AssetImage(
          'assets/images/merpati.jpg',
        ),
      ),
      ItemModel(
        name: "Cenderawasih",
        value: 'cenderawasih',
        icon: FontAwesomeIcons.instagram,
        img: const AssetImage(
          'assets/images/cenderawasih.jpg',
        ),
      ),
    ];
    item2 = List<ItemModel>.from(items!);
    items!.shuffle();
    item2!.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (items!.isEmpty) gameOver = true;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Soal Matching Images',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. cocokkan gambar dibawah ini : '),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.grey.shade300)),
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Column(
                  children: [
                    // Text.rich(TextSpan(children: [
                    //   const TextSpan(
                    //     text: 'Score',
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    //   TextSpan(
                    //       text: ' $score',
                    //       style: const TextStyle(
                    //         color: Colors.pink,
                    //         fontSize: 16,
                    //       )),
                    // ])),
                    // if (!gameOver!)
                    Row(
                      children: [
                        Column(
                            children: items!.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 1,
                            ),
                            child: Draggable<ItemModel>(
                              data: item,
                              childWhenDragging: Image(
                                image: item.img,
                                height: 70,
                                width: 70,
                              ),
                              feedback: Image(
                                image: item.img,
                                height: 100,
                                width: 100,
                              ),
                              child: Image(
                                image: item.img,
                                height: 70,
                                width: 70,
                              ),
                            ),
                          );
                        }).toList()),
                        const Spacer(),
                        Column(
                          children: item2!.map((item) {
                            return DragTarget<ItemModel>(
                                onAccept: (receivedItem) {
                                  if (item.value == receivedItem.value) {
                                    setState(() {
                                      items!.remove(receivedItem);
                                      // item2!.remove(item);
                                      score = score! + 10;
                                      item.accepting = true;
                                    });
                                  } else {
                                    setState(() {
                                      if (score! <= 0) {
                                        score = 0;
                                      } else {
                                        score = score! - 5;
                                      }
                                      item.accepting = false;
                                    });
                                  }
                                },
                                onLeave: (receivedItem) {
                                  setState(() {
                                    item.accepting = false;
                                  });
                                },
                                onWillAccept: (receivedItem) {
                                  setState(() {
                                    item.accepting = true;
                                  });
                                  return true;
                                },
                                builder: (context, accepted, rejectedItem) =>
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        strokeWidth: 2,
                                        color: Colors.grey.shade400,
                                        child: item.accepting
                                            ? Image(
                                                image: item.img,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Container(
                                                color: Colors.red,
                                                height: 50,
                                                width: 100,
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                      ),
                                    ));
                          }).toList(),
                        ),
                      ],
                    ),
                    if (gameOver!)
                      const Center(
                        child: Text(
                          'Game Over',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (gameOver!)
                      Center(
                          child: TextButton(
                              onPressed: () {
                                gameScore();
                                setState(() {});
                              },
                              child: const Text('Mulai Game'))),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent.shade700)),
                child: const Text(
                  'Berikutnya',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  late final String name;
  late final String value;
  late final IconData icon;
  late final AssetImage img;
  late bool accepting;

  ItemModel(
      {required this.name,
      required this.value,
      required this.icon,
      required this.img,
      this.accepting = false});
}
