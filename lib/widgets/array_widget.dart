import 'package:flutter/material.dart';

import 'animating_height_bar.dart';

class ArrayWidget extends StatelessWidget {
  const ArrayWidget({
    Key? key,
    required this.currLength,
    required this.tileSize,
    required bool hasArrayGenerated,
    required int selectedArrayIndex,
    required this.animationDur,
    required this.currArrayColors,
    required this.currArray,
  })  : _hasArrayGenerated = hasArrayGenerated,
        _selectedArrayIndex = selectedArrayIndex,
        super(key: key);

  final int currLength;
  final double tileSize;
  final bool _hasArrayGenerated;
  final int _selectedArrayIndex;
  final Duration animationDur;
  final List<Color> currArrayColors;
  final List<int> currArray;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        currLength,
        (index) {
          return SizedBox(
            height: tileSize + (_hasArrayGenerated ? 430 : 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (tileSize > 30)
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tileSize > 30 ? index.toString() : ''),
                        AnimatedContainer(
                          height: (_selectedArrayIndex == index)
                              ? tileSize * 1.4
                              : tileSize,
                          width: (_selectedArrayIndex == index)
                              ? tileSize * 1.4
                              : tileSize,
                          duration: animationDur,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: currArrayColors[index],
                              width: (_selectedArrayIndex == index) ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(tileSize * 0.1),
                          ),
                          padding: EdgeInsets.all(tileSize * 0.08),
                          child: Container(
                            decoration: BoxDecoration(
                              color: currArrayColors[index],
                              borderRadius:
                                  BorderRadius.circular(tileSize * 0.1),
                            ),
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 0.1),
                                    Text(
                                      (tileSize > 30)
                                          ? currArray[index].toString()
                                          : '',
                                      key: ValueKey(index.toString() +
                                          currArray[index].toString()),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                AnimatingHeightBar(
                  tileSize: tileSize,
                  color: currArrayColors[index],
                  selectedArrayIndex: _selectedArrayIndex,
                  index: index,
                  value: currArray[index],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
