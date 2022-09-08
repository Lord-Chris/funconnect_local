import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key, required this.iconFav, this.openText, this.text})
      : super(key: key);

  final String? text;
  final String? openText;
  final Icon iconFav;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("url"),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: false,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    openText ?? " Open",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.gtWalshPro,
                      color: Color.fromRGBO(118, 125, 133, 1),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: IconButton(
                    icon: iconFav,
                    color: Colors.red,
                    onPressed: () {}),
              ),
            ],
          ),
          Text(
            text ?? " ",
            style: const TextStyle(
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.gtWalshPro,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
