import '../screens/array_screen.dart';
import 'package:flutter/material.dart';

class DataStructure {
  final String title;
  final String description;
  final String routeName;
  final List<Color> colors;
  final String imagePath;
  final String salientFeatures;
  DataStructure({
    required this.title,
    required this.description,
    required this.routeName,
    required this.colors,
    required this.imagePath,
    required this.salientFeatures,
  });
}

final List<DataStructure> dataStructuresList = [
  DataStructure(
    title: 'Array',
    description:
        'Array is a linear data structure, the simplest data structure of all. It is a collection of items stored at contiguous memory locations.',
    colors: [
      Colors.deepPurple[900]!,
      Colors.indigo[900]!,
      Colors.blue[900]!,
    ],
    imagePath: 'assets/images/array.png',
    salientFeatures: '''1. Allow random access to elements (by index).
2. Store elements of the same type together by a single name
3. Store elements in a contiguous block of memory
4. Once declared and initialized, the size of an array cannot be changed
      ''',
    routeName: ArrayScreen.routeName,
  ),
  DataStructure(
    title: 'Vector',
    description:
        'Vectors are the C++ representation of a resizable array, that grows in size if it needs to. Dynamic memory allocation is used for this.',
    routeName: ArrayScreen.routeName,
    colors: [
      Colors.deepOrange[800]!,
      Colors.orange[900]!,
      Colors.orange[700]!,
    ],
    imagePath: '',
    salientFeatures: '',
  ),
  DataStructure(
    title: 'Linked List',
    description:
        'It is a linear data structure whose order is not determined by the placement in memory, which can be non-linear as well. Instead each element contains a pointer to the next element.',
    routeName: ArrayScreen.routeName,
    colors: [
      Colors.green[800]!,
      Colors.greenAccent[700]!,
      Colors.lightGreenAccent[700]!
    ],
    imagePath:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwIaAcgdQlGML-EEWFOH296Flik0hHmzI_77V20Um9UmBO2jLhsTWSBWBCEE6qFfs56gM&usqp=CAU',
    salientFeatures: '',
  ),
  DataStructure(
    title: 'Stack',
    description:
        'Stack is a linear data structure which follows a First In Last Out (FILO), or Last In First Out (LIFO) order of operations\nInsertion and extraction happens from the same end.',
    routeName: ArrayScreen.routeName,
    colors: [
      Colors.red[800]!,
      Colors.red,
      Colors.orange[900]!,
    ],
    salientFeatures: '',
    imagePath: 'assets/images/stack.png',
  ),
  DataStructure(
    title: 'Queue',
    description:
        'Queue is a linear data structure which follows a First In First Out (FIFO).\nA queue is open at both ends, insertion happens at the rear of the queue and extraction happens from the front.',
    routeName: ArrayScreen.routeName,
    colors: [
      Colors.purple[900]!,
      Colors.purple[800]!,
      Colors.purple[700]!,
    ],
    imagePath: 'assets/images/queue.png',
    salientFeatures: '',
  ),
];
