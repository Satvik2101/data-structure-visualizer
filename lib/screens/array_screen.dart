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

  List<TextEditingController> controllers = [
    TextEditingController(text: '0'),
    TextEditingController(text: '0'),
  ];
  int _selectedArrayIndex = -1;
  int _indexToBeSet = 0;
  bool _isIndexSettingError = false;
  int _valueToBeSet = 0;
  bool _isValueSettingError = false;
  var _indexInputController = TextEditingController();
  var _valueInputController = TextEditingController();

  void _updateArray() {
    List<int> newList = List.generate(currLength, (index) => 0);
    for (int i = 0; i < min(currArray.length, currLength); i++) {
      newList[i] = currArray[i];
    }
    setState(() {
      currArray = newList;
    });
    controllers = List.generate(currLength, (index) {
      return TextEditingController(text: currArray[index].toString());
    });
  }

  void _generateRandomArray() async {
    var random = Random();
    currLength = random.nextInt(19) + 2;
    List<int> indices = List.generate(currLength, (index) => index);
    indices.shuffle();
    _updateArray();
    for (int i = 0; i < currLength; i++) {
      int newVal = random.nextInt(100);
      setState(() {
        currArray[indices[i]] = newVal;
        _selectedArrayIndex = indices[i];
      });
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _selectedArrayIndex = -1;
      });
    }
  }

  Widget _buildInputField(
    TextEditingController controller,
    bool errorIndicator,
    Function(String) onChanged,
  ) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        autocorrect: false,
        decoration: InputDecoration(
          errorText: errorIndicator ? 'Invalid input' : null,
          border: const OutlineInputBorder(),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]'),
          ),
        ],
        onChanged: onChanged,
        onEditingComplete: () {
          if (controller.text.isEmpty) {
            setState(() {
              errorIndicator = true;
            });
            return;
          }
          setState(() {
            errorIndicator = false;
          });
        },
      ),
    );
  }

  List<Widget> _buildArrayWidget() {
    List<Widget> list = List.generate(
      currLength,
      (index) {
        return Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(index.toString()),
              AnimatedContainer(
                height: _selectedArrayIndex == index ? tileSize + 25 : tileSize,
                width: _selectedArrayIndex == index ? tileSize + 25 : tileSize,
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedArrayIndex == index
                        ? Colors.green
                        : Colors.black,
                    width: _selectedArrayIndex == index ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(tileSize * 0.1),
                ),
                padding: EdgeInsets.all(tileSize * 0.08),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedArrayIndex == index
                        ? Colors.green
                        : dataStructuresList[indexInDSList].colors.last,
                    borderRadius: BorderRadius.circular(tileSize * 0.1),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      currArray[index].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return list;
  }

  double get tileSize {
    return min((MediaQuery.of(context).size.width - 50) / currLength, 100);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
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
        SizedBox(
          height: tileSize + 60,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              //scrollDirection: Axis.horizontal,
              children: _buildArrayWidget(),
            ),
          ),
        ),
        const Text(
            'Arrays have two main operations => Setting values, and getting values.\n Let\'s try them both out.'),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            child: const Text('Generate random array'),
            onPressed: _generateRandomArray,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Text(
                        'Choose an array index to set\nRemember, it must be from 0 to n-1'),
                  ),
                  const SizedBox(width: 20),
                  _buildInputField(_indexInputController, _isIndexSettingError,
                      (val) {
                    if (val.isEmpty) return;
                    if (int.tryParse(val) == null) {
                      return;
                    }
                    int newIndex = int.parse(val);

                    if (newIndex < 0 || newIndex >= currLength) {
                      setState(() {
                        _isIndexSettingError = true;
                      });
                      return;
                    }
                    setState(() {
                      _isIndexSettingError = false;
                      _indexToBeSet = newIndex;
                    });
                  }),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Text(
                      'Choose an the value to set at the index chosen, which can be any value you want.\nHere we restrict it to 3 digits to make visualization better.',
                    ),
                  ),
                  const SizedBox(width: 20),
                  _buildInputField(
                    _valueInputController,
                    _isValueSettingError,
                    (value) {
                      if (value.isEmpty) return;
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      int newValue = int.parse(value);
                      if (newValue >= 1000) {
                        setState(() {
                          _isValueSettingError = true;
                        });
                        return;
                      }
                      setState(() {
                        _valueToBeSet = newValue;
                        _isValueSettingError = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: dataStructuresList[indexInDSList].colors.last,
              ),
              onPressed: () async {
                setState(() {
                  currArray[_indexToBeSet] = _valueToBeSet;
                  _selectedArrayIndex = _indexToBeSet;
                });
                await Future.delayed(const Duration(milliseconds: 300));
                setState(() {
                  _selectedArrayIndex = -1;
                });
              },
              child: const Text('Set'),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
