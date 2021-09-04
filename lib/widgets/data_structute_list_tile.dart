import 'package:flutter/material.dart';

class DataStructureListTile extends StatelessWidget {
  const DataStructureListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.routeName,
    required this.color,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String description;
  final String routeName;
  final Color color;
  final String imagePath;

  final double size = 250;
  final double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Stack(
            children: [
              Image.asset(imagePath),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
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
    );
  }
}
