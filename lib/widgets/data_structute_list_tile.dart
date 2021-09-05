import '../models/data_structure.dart';
import 'package:flutter/material.dart';

class DataStructureListTile extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DataStructureListTile(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  _DataStructureListTileState createState() => _DataStructureListTileState();
}

class _DataStructureListTileState extends State<DataStructureListTile> {
  late final String title;

  late final String description;

  late final String routeName;

  late final Color color;

  final double size = 200;

  final double borderRadius = 20;
  bool isSelected = false;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      title = dataStructuresList[widget.index].title;
      description = dataStructuresList[widget.index].description;
      routeName = dataStructuresList[widget.index].routeName;
      color = dataStructuresList[widget.index].colors[0];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: isSelected ? 280 : 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isSelected) const SizedBox(height: 40),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(routeName, arguments: widget.index);
              },
              onHover: (value) {
                setState(() {
                  isSelected = value;
                });
              },
              borderRadius: BorderRadius.circular(borderRadius),
              child: Ink(
                height: isSelected ? 240 : 200,
                // width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(borderRadius).copyWith(
                          bottomLeft: Radius.zero,
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                        ),
                        child: CustomPaint(
                          painter: TrianglePainter(
                            paintingStyle: PaintingStyle.fill,
                            strokeColor: color,
                          ),
                          child: const SizedBox(
                            height: 170,
                            width: 130,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style:
                                Theme.of(context).textTheme.headline3?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          Text(
                            description,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, 0)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
