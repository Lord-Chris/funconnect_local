import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key, this.openText}) : super(key: key);

  final String? openText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(""),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: AppColors.black.withOpacity(0.3),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
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
                  CircleAvatar(
                    backgroundColor: AppColors.white.withOpacity(0.3),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border_outlined),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
