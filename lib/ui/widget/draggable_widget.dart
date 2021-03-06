import 'package:dragndrop/ui/data/data.dart';
import 'package:dragndrop/ui/view/listdragndrop.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final Birds bird;

  const DraggableWidget({
    Key? key,
    required this.bird,
  }) : super(key: key);

  static double size = 100;

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            bird.imgAsset,
            fit: BoxFit.fill,
          ),
        ),
      );
}
