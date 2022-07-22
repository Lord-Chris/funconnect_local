import 'package:flutter/material.dart';
import 'package:funconnect/constants/fonts.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(0, 19, 71, 1),
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        fontFamily: AppFonts.merriweather,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
