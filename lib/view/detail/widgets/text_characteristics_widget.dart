import 'package:flutter/material.dart';

class TextCharacteristicsWidget extends StatelessWidget {
  final String title;
  final String body;

  const TextCharacteristicsWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.blue, fontSize: 20),
        children: [
          TextSpan(
            text: title,
          ),
          TextSpan(
            text: body,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
