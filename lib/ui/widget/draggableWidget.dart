import 'package:dragndrop/ui/data/data.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final Birds bird;

  const DraggableWidget({
    required this.bird,
  });

  static double size = 150;

  @override
  Widget build(BuildContext context) => Draggable<Birds>(
        data: bird,
        feedback: buildImage(),
        child: buildImage(),
        childWhenDragging: Container(height: size),
      );

  Widget buildImage() => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Image.asset(bird.imgAsset),
      );
}
