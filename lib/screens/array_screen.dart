import 'dart:math';

import '../models/data_structure.dart';

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
  int tempLength = 2;
  int _selectedArrayIndex = -1;
  bool _hasArrayGenerated = false;
  late int valueToBeSearched;
  GlobalKey<ScreenTemplateState> _screenTemplateKey = GlobalKey();
  Color get selectedColor => dataStructuresList[indexInDSList].colors[0];
  Color get normalColor => dataStructuresList[indexInDSList].colors.last;

  Duration dur = const Duration(milliseconds: 50);
  Duration animationDur = const Duration(milliseconds: 200);
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

  Future<void> _merge(int start, int end, int mid) async {
    int i = 0;
    int j = 0;
    _selectedArrayIndex = mid;
    int k = start;
    int leftLength = mid - start + 1;
    int rightLength = end - mid;
    List<int> left = [
      ...List.generate(leftLength, (x) => currArray[start + x])
    ];
    List<int> right = [
      ...List.generate(rightLength, (x) => currArray[mid + 1 + x])
    ];

    while (i < left.length && j < right.length) {
      setState(() {
        currArrayColors[mid] = Colors.red;
        currArrayColors[start] = Colors.grey;
        currArrayColors[end] = Colors.grey;
      });
      await Future.delayed(dur);
      if (left[i] <= right[j]) {
        setState(() {
          currArrayColors[k] = selectedColor;
        });
        await Future.delayed(dur);
        setState(() {
          currArray[k] = left[i];
        });
        await Future.delayed(dur);
        setState(() {
          currArrayColors[i] = normalColor;
        });
        i++;
      } else {
        setState(() {
          currArrayColors[k] = selectedColor;
        });
        await Future.delayed(dur);
        setState(() {
          currArray[k] = right[j];
        });
        await Future.delayed(dur);
        setState(() {
          currArrayColors[j] = normalColor;
        });
        j++;
      }
      setState(() {
        currArrayColors[i] = normalColor;
        currArrayColors[j] = normalColor;
        currArrayColors[k] = normalColor;
      });
      k++;
    }
    while (i < left.length) {
      setState(() {
        currArrayColors[k] = Colors.black;
      });
      await Future.delayed(dur);
      setState(() {
        currArray[k] = left[i];
      });
      await Future.delayed(dur);
      setState(() {
        currArrayColors[k] = normalColor;
      });
      i++;
      k++;
    }
    while (j < right.length) {
      setState(() {
        currArrayColors[k] = Colors.black;
      });
      await Future.delayed(dur);
      setState(() {
        currArray[k] = right[j];
      });
      await Future.delayed(dur);
      setState(() {
        currArrayColors[k] = normalColor;
      });
      j++;
      k++;
    }
    setState(() {
      currArrayColors[start] = normalColor;
      currArrayColors[end] = normalColor;
      currArrayColors[mid] = normalColor;
    });
  }

  Future<void> _mergeSort(int start, int end) async {
    if (start >= end) return;
    int mid = (start + end) ~/ 2;
    setState(() {
      overlayTitle = 'Current Mid';
      overlayText = '$mid';
    });

    await _mergeSort(start, mid);
    setState(() {
      overlayTitle = 'Current Mid';
      overlayText = '$mid';
    });
    await _mergeSort(mid + 1, end);
    setState(() {
      overlayTitle = 'Current Mid';
      overlayText = '$mid';
    });
    await _merge(start, end, mid);
    setState(() {
      _selectedArrayIndex = -1;
      overlayText = '';
      overlayTitle = '';
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
    currLength = tempLength;
    List<int> newList = List.generate(currLength, (index) => 0);
    List<Color> newColors = List.generate(currLength, (index) => normalColor);
    for (int i = 0; i < min(currArray.length, currLength); i++) {
      newList[i] = currArray[i];
      newColors[i] = currArrayColors[i];
    }
    setState(() {
      currArray = newList;
      currArrayColors = newColors;
    });
  }

  void _generateRandomArray() async {
    _updateArray();
    var random = Random();
    List<int> indices = List.generate(currLength, (index) => index);
    setState(() {
      _hasArrayGenerated = true;
    });
    await Future.delayed(animationDur);
    _screenTemplateKey.currentState?.scrollToBottom();
    indices.shuffle();
    for (int i = 0; i < currLength; i++) {
      int newVal = random.nextInt(900);
      setState(() {
        currArray[indices[i]] = newVal;
      });
    }
  }

  List<Widget> _buildArrayWidget() {
    List<Widget> list = List.generate(
      currLength,
      (index) {
        return SizedBox(
          height: tileSize + (_hasArrayGenerated ? 420 : 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                            duration: animationDur,
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
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  SizedBox(width: 0.1),
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
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: animationDur,
                width: tileSize * 0.7,
                height: max(
                  0,
                  currArray[index] * 380 / 900 -
                      (_selectedArrayIndex == index ? tileSize * 0.4 : 0),
                ),
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
                max: 50,
                value: tempLength.toDouble(),
                onChanged: (value) {
                  setState(() {
                    tempLength = value.toInt();
                  });

                  print("set length");
                },
                divisions: 48,
                label: '$tempLength',
              ),
            ),
            Text(
              '$tempLength',
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
                  Container(
                    height: tileSize + (_hasArrayGenerated ? 380 : 80),
                    alignment: Alignment.topCenter,
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
                height: tileSize + (_hasArrayGenerated ? 420 : 80),
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
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _mergeSort(0, currLength - 1),
                      child: const Text('Merge Sort'),
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
