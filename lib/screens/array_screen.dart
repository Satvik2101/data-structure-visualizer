import 'dart:math';

import 'package:ds_visualizer/models/data_structure.dart';
import 'package:flutter/services.dart';

import '../widgets/screen_template.dart';
import 'package:flutter/material.dart';

class ArrayScreen extends StatefulWidget {
  const ArrayScreen({Key? key}) : super(key: key);
  static const routeName = '/array';
  @override
  _ArrayScreenState createState() => _ArrayScreenState();
}

class _ArrayScreenState extends State<ArrayScreen> {
  int indexInDSList = 0;
  int currLength = 2;
  List<int> currArray = [0, 0];
  List<Color> currArrayColors = [
    dataStructuresList[0].colors.last,
    dataStructuresList[0].colors.last,
  ];
  List<TextEditingController> controllers = [
    TextEditingController(text: '0'),
    TextEditingController(text: '0'),
  ];

  int _selectedArrayIndex = -1;
  bool _hasArrayGenerated = false;
  late int valueToBeSearched;
  GlobalKey<ScreenTemplateState> _screenTemplateKey = GlobalKey();
  Color get selectedColor => dataStructuresList[indexInDSList].colors[0];
  Color get normalColor => dataStructuresList[indexInDSList].colors.last;

  Duration dur = const Duration(milliseconds: 200);
  String overlayTitle = '';
  String overlayText = '';
  Future<void> _swapIndicesValue(int i, int j) async {
    setState(() {
      currArrayColors[i] = Colors.red;
      currArrayColors[j] = Colors.green;
    });
    await Future.delayed(dur);
    int temp = currArray[i];
    setState(() {
      currArray[i] = currArray[j];
      currArray[j] = temp;
    });
    await Future.delayed(dur);
    setState(() {
      currArrayColors[i] = normalColor;
      currArrayColors[j] = normalColor;
    });
  }

  Future<int> _partition(int start, int end) async {
    int pivot = currArray[end];
    int i = start - 1;
    for (int j = start; j < end; j++) {
      if (currArray[j] < pivot) {
        i++;
        await _swapIndicesValue(i, j);
      }
    }

    await _swapIndicesValue(end, i + 1);
    return i + 1;
  }

  Future<void> _quickSort(int start, int end) async {
    setState(() {
      overlayTitle = 'Current Pivot';
    });
    if (start >= end) return;
    int pivot = await _partition(start, end);

    setState(() {
      _selectedArrayIndex = pivot;
      setState(() {
        overlayText = 'Index:$pivot, Value: ${currArray[pivot]}';
      });
      currArrayColors[pivot] = selectedColor;
    });
    await _quickSort(start, pivot - 1);
    await _quickSort(pivot + 1, end);
    setState(() {
      _selectedArrayIndex = -1;
      currArrayColors[pivot] = normalColor;
      overlayText = '';
      overlayTitle = '';
    });
  }

  void _bubbleSort() async {
    setState(() {
      overlayTitle = 'Elements in place:';
    });
    for (int i = 0; i < currLength - 1; i++) {
      setState(() {
        overlayText = '$i';
        currArrayColors[currLength - i - 1] = Colors.black;
        _selectedArrayIndex = currLength - i - 1;
      });
      for (int j = 0; j < currLength - i - 1; j++) {
        if (currArray[j] > currArray[j + 1]) {
          await _swapIndicesValue(j, j + 1);
        }
      }
      await Future.delayed(dur);
      setState(() {
        currArrayColors[currLength - i - 1] = normalColor;
      });
    }
    setState(() {
      overlayTitle = '';
      overlayText = '';
      _selectedArrayIndex = -1;
    });
  }

  void _insertionSort() async {
    int i, j, val;
    setState(() {
      overlayTitle = 'Current value';
    });
    for (i = 1; i < currArray.length; i++) {
      setState(() {
        currArrayColors[i] = Colors.black;
        _selectedArrayIndex = i;
      });

      val = currArray[i];
      setState(() {
        overlayText = '$val';
      });

      await Future.delayed(dur);

      j = i - 1;
      while (j >= 0 && currArray[j] > val) {
        setState(() {
          currArray[j + 1] = currArray[j];
        });
        await Future.delayed(dur);
        setState(() {
          _selectedArrayIndex = j;
          currArrayColors[j] = Colors.green;
        });
        await Future.delayed(dur);
        setState(() {
          currArrayColors[j] = normalColor;
        });

        j--;
      }

      setState(() {
        currArray[j + 1] = val;
        currArrayColors[i] = normalColor;
      });

      await Future.delayed(dur);
    }
    setState(() {
      _selectedArrayIndex = -1;
      overlayText = '';
      overlayTitle = '';
    });
  }

  void _updateArray() {
    List<int> newList = List.generate(currLength, (index) => 0);
    List<Color> newColors = List.generate(
        currLength, (index) => dataStructuresList[indexInDSList].colors.last);
    for (int i = 0; i < min(currArray.length, currLength); i++) {
      newList[i] = currArray[i];
      newColors[i] = currArrayColors[i];
    }
    setState(() {
      currArray = newList;
      currArrayColors = newColors;
    });
    controllers = List.generate(currLength, (index) {
      return TextEditingController(text: currArray[index].toString());
    });
  }

  void _generateRandomArray() async {
    setState(() {
      _hasArrayGenerated = true;
    });
    await Future.delayed(dur);
    _screenTemplateKey.currentState?.scrollToBottom();
    var random = Random();
    List<int> indices = List.generate(currLength, (index) => index);
    indices.shuffle();
    _updateArray();
    for (int i = 0; i < currLength; i++) {
      int newVal = random.nextInt(900);
      setState(() {
        currArray[indices[i]] = newVal;
        _selectedArrayIndex = indices[i];
        currArrayColors[indices[i]] =
            dataStructuresList[indexInDSList].colors[0];
      });
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _selectedArrayIndex = -1;
        currArrayColors[indices[i]] =
            dataStructuresList[indexInDSList].colors.last;
      });
    }
  }

  List<Widget> _buildArrayWidget() {
    List<Widget> list = List.generate(
      currLength,
      (index) {
        return SizedBox(
          height: tileSize + (_hasArrayGenerated ? 380 : 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(index.toString()),
                    AnimatedContainer(
                      height: (_selectedArrayIndex == index)
                          ? tileSize + 25
                          : tileSize,
                      width: (_selectedArrayIndex == index)
                          ? tileSize + 25
                          : tileSize,
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currArrayColors[index],
                          width: (_selectedArrayIndex == index) ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(tileSize * 0.1),
                      ),
                      padding: EdgeInsets.all(tileSize * 0.08),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: currArrayColors[index],
                          borderRadius: BorderRadius.circular(tileSize * 0.1),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: animation.drive(
                                  Tween(
                                    begin: const Offset(-0.5, 0),
                                    end: const Offset(0, 0),
                                  ),
                                ),
                                child: child,
                              ),
                            ),
                            child: Text(
                              currArray[index].toString(),
                              key: ValueKey(index.toString() +
                                  currArray[index].toString()),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: tileSize * 0.7,
                height: currArray[index] * 330 / 900,
                color: currArrayColors[index],
              ),
            ],
          ),
        );
      },
    );

    return list;
  }

  double get tileSize {
    return min(
        (MediaQuery.of(context).size.width - 50) * 0.8 / currLength, 100);
  }

  Widget currentValueWidget() => Positioned(
        bottom: 10,
        left: 10,
        child: Material(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      overlayTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$overlayText',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      key: _screenTemplateKey,
      index: 0,
      children: [
        const Text(
          'Choose the number of elements in your array',
        ),
        Text(
          'A maximum of 20 elements is allowed to make visualization better\nHere we take the default value of a new element as 0, but some compilers will not set any default value and a garbage value will be stored there.',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                min: 2,
                max: 20,
                value: currLength.toDouble(),
                onChanged: (value) {
                  setState(() {
                    currLength = value.toInt();
                  });
                  _updateArray();
                },
                divisions: 18,
                label: '$currLength',
              ),
            ),
            Text(
              '$currLength',
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: tileSize + (_hasArrayGenerated ? 380 : 80),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        //scrollDirection: Axis.horizontal,
                        children: _buildArrayWidget(),
                      ),
                    ),
                  ),
                  if (overlayText.isNotEmpty) currentValueWidget(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: tileSize + (_hasArrayGenerated ? 380 : 80),
                child: ListView(
                  controller: null,
                  children: [
                    ElevatedButton(
                      child: const Text('Generate random array'),
                      onPressed: _generateRandomArray,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Insertion Sort'),
                      onPressed: _insertionSort,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Bubble Sort'),
                      onPressed: _bubbleSort,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _quickSort(0, currLength - 1),
                      child: const Text('Quick Sort'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
