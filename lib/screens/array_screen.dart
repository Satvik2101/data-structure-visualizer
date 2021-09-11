import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/data_structure.dart';
import '../widgets/screen_template.dart';
import '../widgets/animating_height_bar.dart';
import '../widgets/stack_overlay_widget.dart';
import '../widgets/array_widget.dart';

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
  GlobalKey<ScreenTemplateState> _screenTemplateKey = GlobalKey();
  Color get selectedColor => dataStructuresList[indexInDSList].colors[0];
  Color get normalColor => dataStructuresList[indexInDSList].colors.last;

  Duration dur = const Duration(milliseconds: 50);
  Duration animationDur = const Duration(milliseconds: 150);
  String overlayTitle = '';
  String overlayText = '';
  int timeTaken = 0;

  Future<void> _callSort(Function fun) async {
    List<int> sortedArray =
        List.generate(currLength, (index) => currArray[index]);

    sortedArray.sort();

    await fun();
    setState(() {
      _selectedArrayIndex = -1;
      overlayText = '';
      overlayTitle = '';
    });

    assert(listEquals(currArray, sortedArray));
    for (int i = 0; i < currLength; i++) {
      setState(() {
        currArrayColors[i] = Colors.green;
      });
      await Future.delayed(const Duration(milliseconds: 0));
    }
  }

  Future<void> _swapIndicesValue(int i, int j) async {
    currArrayColors[i] = Colors.red;
    currArrayColors[j] = Colors.green;
    await Future.delayed(dur);
    int temp = currArray[i];
    setState(() {
      currArray[i] = currArray[j];
      currArray[j] = temp;
    });
    await Future.delayed(dur);
    currArrayColors[i] = normalColor;
    currArrayColors[j] = normalColor;
  }

  Future<void> _heapify(int i, int heapSize,
      [bool setOverlayValues = false]) async {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (left < heapSize && currArray[left] > currArray[largest]) {
      largest = left;
    }
    if (right < heapSize && currArray[right] > currArray[largest]) {
      largest = right;
    }
    if (i != largest) {
      if (setOverlayValues) {
        setState(() {
          overlayTitle = 'Building Max Heap:\nSwapping';
          overlayText = '$i and $largest';
        });
      }
      await _swapIndicesValue(i, largest);
      await _heapify(largest, heapSize, setOverlayValues);
    }
  }

  Future<void> _heapSort() async {
    int heapSize = currLength;
    //Build max heap
    for (int i = heapSize ~/ 2 - 1; i >= 0; i--) {
      await _heapify(i, heapSize, true);
    }

    setState(() {
      overlayTitle = 'Elements in place';
    });

    for (int i = heapSize - 1; i > 0; i--) {
      _selectedArrayIndex = i;

      await _swapIndicesValue(i, 0);

      setState(() {
        currArrayColors[i] = Colors.black;
        overlayText = '${heapSize - i}';
      });
      await _heapify(0, i);
      currArrayColors[i] = selectedColor;
    }
    setState(() {
      overlayText = '$currLength';
    });
    await Future.delayed(animationDur);
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
      currArrayColors[mid] = Colors.red;
      currArrayColors[start] = Colors.grey;
      currArrayColors[end] = Colors.grey;

      await Future.delayed(dur);
      if (left[i] <= right[j]) {
        currArrayColors[k] = selectedColor;
        await Future.delayed(dur);
        setState(() {
          currArray[k] = left[i];
        });
        await Future.delayed(dur);
        currArrayColors[i] = normalColor;

        i++;
      } else {
        currArrayColors[k] = selectedColor;
        await Future.delayed(dur);
        setState(() {
          currArray[k] = right[j];
        });
        await Future.delayed(dur);
        currArrayColors[j] = normalColor;
        j++;
      }
      currArrayColors[i] = normalColor;
      currArrayColors[j] = normalColor;
      currArrayColors[k] = normalColor;

      k++;
    }
    while (i < left.length) {
      currArrayColors[k] = Colors.black;

      await Future.delayed(dur);
      setState(() {
        currArray[k] = left[i];
      });
      await Future.delayed(dur);
      currArrayColors[k] = normalColor;

      i++;
      k++;
    }
    while (j < right.length) {
      currArrayColors[k] = Colors.black;

      await Future.delayed(dur);
      setState(() {
        currArray[k] = right[j];
      });
      await Future.delayed(dur);
      currArrayColors[k] = normalColor;

      j++;
      k++;
    }
    currArrayColors[start] = normalColor;
    currArrayColors[end] = normalColor;
    currArrayColors[mid] = normalColor;
  }

  Future<void> _mergeSort([int? start = null, int? end = null]) async {
    start = start ?? 0;
    end = end ?? currArray.length - 1;
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

  Future<void> _quickSort([int? start = null, int? end = null]) async {
    start = start ?? 0;
    end = end ?? currArray.length - 1;
    setState(() {
      overlayTitle = 'Current Pivot';
    });
    if (start >= end) return;
    int pivot = await _partition(start, end);

    setState(() {
      _selectedArrayIndex = pivot;
      overlayText = 'Index:$pivot, Value: ${currArray[pivot]}';
      currArrayColors[pivot] = selectedColor;
    });
    await _quickSort(start, pivot - 1);
    await _quickSort(pivot + 1, end);
  }

  Future<void> _bubbleSort() async {
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
      currArrayColors[currLength - i - 1] = normalColor;
    }
  }

  Future<void> _insertionSort() async {
    int i, j, val;
    setState(() {
      overlayTitle = 'Current value';
    });
    for (i = 1; i < currArray.length; i++) {
      currArrayColors[i] = Colors.black;
      setState(() {
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
        });
        currArrayColors[j] = Colors.green;
        await Future.delayed(dur);
        currArrayColors[j] = normalColor;
        j--;
      }
      setState(() {
        currArray[j + 1] = val;
      });
      currArrayColors[i] = normalColor;

      await Future.delayed(dur);
    }
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
        currArrayColors[indices[i]] = normalColor;
      });
    }
  }

  double get tileSize {
    return min(
        (MediaQuery.of(context).size.width - 50) * 0.9 / currLength, 100);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      key: _screenTemplateKey,
      index: 0,
      children: [
        Row(
          children: [
            Expanded(
              child: Slider(
                min: 2,
                max: 100,
                value: tempLength.toDouble(),
                onChanged: (value) {
                  setState(() {
                    tempLength = value.toInt();
                  });
                },
                divisions: 98,
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
                    height: tileSize + (_hasArrayGenerated ? 430 : 80),
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: ArrayWidget(
                          currLength: currLength,
                          tileSize: tileSize,
                          hasArrayGenerated: _hasArrayGenerated,
                          selectedArrayIndex: _selectedArrayIndex,
                          animationDur: animationDur,
                          currArrayColors: currArrayColors,
                          currArray: currArray),
                    ),
                  ),
                  if (overlayText.isNotEmpty)
                    StackOverlayWidget(
                        overlayTitle: overlayTitle, overlayText: overlayText),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: tileSize + (_hasArrayGenerated ? 420 : 80),
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    ElevatedButton(
                      child: const Text('Generate random array'),
                      onPressed: _generateRandomArray,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Insertion Sort'),
                      onPressed: () => _callSort(_insertionSort),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Bubble Sort'),
                      onPressed: () => _callSort(_bubbleSort),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: const Text('Quick Sort'),
                      onPressed: () => _callSort(_quickSort),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _callSort(_mergeSort),
                      child: const Text('Merge Sort'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _callSort(_heapSort),
                      child: const Text('Heap Sort'),
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
