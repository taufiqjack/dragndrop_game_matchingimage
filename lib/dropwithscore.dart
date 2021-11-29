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

      // Image.asset(
      //   'assets/images/bird1.jpg',
      // ),
      // Image.asset(
      //   'assets/images/bird2.jpg',
      // ),
      // Image.asset(
      //   'assets/images/bird3.jpg',
      // ),
      // Image.asset(
      //   'assets/images/bird4.jpg',
      // )
    ];
    item2 = List<ItemModel>.from(items!);
    // item2 = const [
    // Text(
    //   'Burung 1',
    // ),
    // Text(
    //   'Burung 2',
    // ),
    // Text(
    //   'Burung 3',
    // ),
    // Text(
    //   'Burung 3',
    // ),
    // Text(
    //   'Burung 4',
    // ),
    // ];
    items!.shuffle();
    item2!.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (items!.isEmpty) gameOver = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DragnDrop Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text.rich(TextSpan(children: [
              const TextSpan(text: 'Score'),
              TextSpan(
                  text: ' $score',
                  style: const TextStyle(
                    color: Colors.pink,
                  )),
            ])),
            if (!gameOver!)
              Row(
                children: [
                  Column(
                      children: items!.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 2,
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
                          height: 70,
                          width: 70,
                        ),
                        child: Image(
                          image: item.img,
                          height: 70,
                          width: 70,
                        ),

                        // childWhenDragging: Icon(
                        //   item.icon,
                        //   color: Colors.grey,
                        //   size: 50,
                        // ),
                        // feedback: Icon(
                        //   item.icon,
                        //   color: Colors.red,
                        //   size: 50,
                        // ),
                        // child: Icon(
                        //   item.icon,
                        //   color: Colors.red,
                        //   size: 50,
                        // ),
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
                                item2!.remove(item);
                                score = 10;
                                item.accepting = false;
                              });
                            } else {
                              setState(() {
                                score = 5;
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
                          builder: (context, accewptedItem, rejectedItem) =>
                              Container(
                                color: item.accepting
                                    ? Colors.red.shade300
                                    : Colors.red,
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  item.name,
                                  style: const TextStyle(color: Colors.white),
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
