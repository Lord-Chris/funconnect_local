import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.image,
    this.buttonColor,
    this.function,
    this.isImage = false,
    this.borderColor,
    this.radius = 50,
    this.textColor,
    this.fontSize = 20,
    this.fontWeight,
    this.widget,
    this.height = 64,
    this.width,
    this.borderWidth,
    this.showLoader = false,
  }) : super(key: key);

  final String? text;
  final String? image;
  final Color? buttonColor;
  final Function()? function;
  final bool isImage;
  final Color? borderColor;
  final double? radius;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? widget;
  final double? height;
  final double? width, borderWidth;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: function, //showLoader ? null : function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(radius!),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? .5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 58, 213, 0.22),
              blurRadius: 0.5,
            ),
          ],
        ),
        child: Center(
          child: Visibility(
            visible: !showLoader,
            replacement: CircularProgressIndicator(
              color: textColor ?? Theme.of(context).textTheme.button!.color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  if (!isImage) return const SizedBox();
                  if (image == null) return const SizedBox();
                  if (image!.endsWith("svg")) {
                    return SvgPicture.asset(image!);
                  }
                  return Image.asset(image!);
                }),
                if (image != null) const SizedBox(width: 8),
                widget ??
                    Text(
                      text!,
                      style: TextStyle(
                        color: textColor ??
                            Theme.of(context).textTheme.button!.color,
                        fontSize: fontSize ??
                            Theme.of(context).textTheme.button!.fontSize,
                        fontWeight: fontWeight ??
                            Theme.of(context).textTheme.button!.fontWeight,
                        fontFamily: AppFonts.gtWalshPro,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
