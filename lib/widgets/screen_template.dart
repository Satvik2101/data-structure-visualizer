import 'package:flutter/material.dart';

import '../models/data_structure.dart';

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({
    Key? key,
    required this.index,
    required this.children,
  }) : super(key: key);
  static const routeName = '/screen-template';
  final int index;
  final List<Widget> children;
  @override
  ScreenTemplateState createState() => ScreenTemplateState();
}

class ScreenTemplateState extends State<ScreenTemplate>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
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

      title = dataStructuresList[widget.index].title;
      description = dataStructuresList[widget.index].description;
      imagePath = dataStructuresList[widget.index].imagePath;
      colors = dataStructuresList[widget.index].colors;
      salientFeatures = dataStructuresList[widget.index].salientFeatures;
    }

    super.didChangeDependencies();
  }

  void scrollToBottom() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
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
                    child: SingleChildScrollView(
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
              Container(height: MediaQuery.of(context).size.height),
            ]..addAll(
                widget.children
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: e,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
          ),
        ],
      ),
    );
  }
}
