import 'dart:math';

import 'package:flutter/material.dart';

class AnimatingHeightBar extends StatelessWidget {
  const AnimatingHeightBar({
    Key? key,
    required this.selectedArrayIndex,
    required this.tileSize,
    required this.value,
    required this.index,
    required this.color,
  }) : super(key: key);

  final double tileSize;
  final int value;
  final int index;
  final int selectedArrayIndex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double height = max(0, value * 380 / 900);
    return AnimatedContainer(
      alignment: Alignment.topCenter,
      width: tileSize * (selectedArrayIndex == index ? 1.2 : 0.93),
      height: height,
      duration: const Duration(milliseconds: 100),
      child: Container(
        margin: selectedArrayIndex == index
            ? const EdgeInsets.all(1.5)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(height * 0.01),
            bottomRight: Radius.circular(height * 0.01),
          ),
          color: color,
        ),
      ),
    );
  }
}
