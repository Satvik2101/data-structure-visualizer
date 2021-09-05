import 'package:flutter/material.dart';

import '../models/data_structure.dart';

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({Key? key}) : super(key: key);
  static const routeName = '/screen-template';
  @override
  _ScreenTemplateState createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  late final int index;
  late final String title;
  late final String description;
  late final String imagePath;
  late final List<Color> colors;
  late final String salientFeatures;
  late final ScrollController _controller;
  late final AnimationController _animationController;
  double offset = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        offset = _controller.offset;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    Future.delayed(Duration.zero, () {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      index = ModalRoute.of(context)!.settings.arguments as int;
      title = dataStructuresList[index].title;
      description = dataStructuresList[index].description;
      imagePath = dataStructuresList[index].imagePath;
      colors = dataStructuresList[index].colors;
      salientFeatures = dataStructuresList[index].salientFeatures;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Array'),
        leading: const SizedBox(width: 0),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors[0],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            bottom: offset * 0.3 - 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    color: Colors.white,
                                    fontSize: 80,
                                  ),
                        ),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Salient Features: ',
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          salientFeatures,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        imagePath,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView(
            controller: _controller,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
              Container(
                height: 50,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Text('test'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
