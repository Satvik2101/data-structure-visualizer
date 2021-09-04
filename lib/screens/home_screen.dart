import 'package:ds_visualizer/widgets/data_structute_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:ds_visualizer/models/data_structure.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final List<DataStructure> dataStructuresList = [
    DataStructure(
      title: 'Stack',
      description:
          'Stack is a linear data structure which follows a First In Last Out (FILO), or Last In First Out (LIFO) order of operations\nInsertion and extraction happens from the same end.',
      routeName: '/',
      color: Colors.orange[700]!,
      imagePath: 'assets/images/stack.png',
    ),
    DataStructure(
      title: 'Queue',
      description:
          'Queue is a linear data structure which follows a First In First Out (FIFO).\nA queue is open at both ends, insertion happens at the rear of the queue and extraction happens from the front.',
      routeName: '/',
      color: Colors.purple,
      imagePath: 'assets/images/queue.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Structures Visualizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Select a data structure to visualize',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(fontSize: 50),
                      ),
                    ),
                  ),
                  Image.network(
                    'https://miro.medium.com/max/1400/0*UVG1F-0kLAEWAT3k',
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: dataStructuresList
                        .map(
                          (e) => DataStructureListTile(
                            title: e.title,
                            color: e.color,
                            description: e.description,
                            routeName: e.routeName,
                            imagePath: e.imagePath,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            //color: Colors.deepPurple[200],
          ),
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          width: double.infinity,
        ),
      ),
    );
  }
}
