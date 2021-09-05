import 'dart:math';

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
  int currLength = 2;
  List<int> currArray = [0, 0];

  List<TextEditingController> controllers = [
    TextEditingController(text: '0'),
    TextEditingController(text: '0'),
  ];
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
        var controller = controllers[index];
        return Column(
          children: [
            Text(index.toString()),
            SizedBox(
              height: tileSize,
              width: tileSize,
              child: Card(
                child: Center(
                  child: TextField(
                    enabled: false,
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controllers[index].selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );
                      if (value.isEmpty) return;
                      if (int.tryParse(value) == null) {
                        controller.text = currArray[index].toString();
                        return;
                      }
                      int newValue = int.parse(value);
                      print(controller.text);
                      setState(() {
                        currArray[index] = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
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
          height: tileSize + 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildArrayWidget(),
          ),
        ),
        const Text(
            'Arrays have two main operations => Setting values, and getting values.\n Let\'s try them both out.'),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Choose an array index to set\nRemember, it must be from 0 to n-1'),
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
            })
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'Choose an the value to set at the index chosen, which can be any value you want.\nHere we restrict it to 3 digits to make visualization better.',
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
                if (newValue >= 1000)
                  setState(() {
                    _valueToBeSet = newValue;
                    _isValueSettingError = false;
                  });
              },
            ),
          ],
        ),
      ],
    );
  }
}
