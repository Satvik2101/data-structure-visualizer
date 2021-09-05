import 'package:flutter/material.dart';

import '../models/data_structure.dart';
import '../widgets/data_structute_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select a data structure to visualize',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 50),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'By - Satvik Gupta',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
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
                child: Container(
                  height: 250,
                  constraints: BoxConstraints(maxHeight: 250, minHeight: 200),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: dataStructuresList
                        .map(
                          (e) => DataStructureListTile(
                            dataStructuresList.indexOf(e),
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
