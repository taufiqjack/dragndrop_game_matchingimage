import 'package:dragndrop/ui/data/data.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final Birds bird;

  const DraggableWidget({
    Key? key,
    required this.bird,
  }) : super(key: key);

  static double size = 150;

  @override
  Widget build(BuildContext context) => Draggable<Birds>(
        data: bird,
        feedback: buildImage(),
        child: buildImage(),
        childWhenDragging: Container(),
      );

  Widget buildImage() => SizedBox(
        height: size,
        width: size,
        child: Image.asset(bird.imgAsset),
      );
}
