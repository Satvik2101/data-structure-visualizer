import 'package:flutter/material.dart';

class StackOverlayWidget extends StatelessWidget {
  const StackOverlayWidget({
    Key? key,
    required this.overlayTitle,
    required this.overlayText,
  }) : super(key: key);

  final String overlayTitle;
  final String overlayText;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    overlayTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  overlayText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
