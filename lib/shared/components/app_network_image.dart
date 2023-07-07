import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/_constants.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final bool isCircular;
  final bool cacheImage;
  final Size? size;
  final double borderRadius;
  final Widget? placeholderWidget;
  final String? placeholderAssetImage;
  final Widget? errorWidget;
  final String? errorAssetImage;

  const AppNetworkImage({
    Key? key,
    String? url,
    this.fit,
    this.isCircular = false,
    this.cacheImage = true,
    this.size = const Size.square(40),
    this.borderRadius = 0,
    this.placeholderWidget,
    this.placeholderAssetImage,
    this.errorWidget,
    this.errorAssetImage,
  })  : imageUrl = url ?? "",
        assert(url != null || placeholderAssetImage != null,
            "At least one must be set"),
        assert(placeholderWidget == null || placeholderAssetImage == null),
        assert(errorWidget == null || errorAssetImage == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return FittedBox(
        child: Container(
          height: size?.height,
          width: size?.width,
          decoration: BoxDecoration(
            borderRadius:
                isCircular ? null : BorderRadius.circular(borderRadius),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: placeholderAssetImage!.endsWith(".svg")
              ? SvgPicture.asset(
                  placeholderAssetImage!,
                  fit: fit ?? BoxFit.contain,
                )
              : Image.asset(
                  placeholderAssetImage!,
                  fit: fit,
                ),
        ),
      );
    }
    return CachedNetworkImage(
      key: ValueKey(imageUrl),
      imageUrl: imageUrl,
      useOldImageOnUrlChange: true,
      cacheKey: cacheImage ? null : '$imageUrl ${Random().nextInt(5000)}',
      fadeInDuration: const Duration(milliseconds: 2000),
      fadeOutDuration: const Duration(milliseconds: 2000),
      height: size!.height,
      width: size!.width,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: size?.height,
          width: size?.width,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.black,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:
                isCircular ? null : BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, value) {
        if (placeholderWidget != null) {
          return placeholderWidget!;
        }
        if (placeholderAssetImage != null &&
            placeholderAssetImage!.isNotEmpty) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius:
                  isCircular ? null : BorderRadius.circular(borderRadius),
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: placeholderAssetImage!.endsWith(".svg")
                ? SvgPicture.asset(
                    placeholderAssetImage!,
                    fit: fit ?? BoxFit.contain,
                  )
                : Image.asset(
                    placeholderAssetImage!,
                    fit: fit,
                  ),
          );
        }
        return Shimmer.fromColors(
          baseColor: AppColors.black,
          highlightColor: AppColors.primary,
          child: Container(
            height: size?.height,
            width: size?.width,
            decoration: BoxDecoration(
              color: AppColors.black,
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius:
                  isCircular ? null : BorderRadius.circular(borderRadius),
            ),
          ),
        );
      },
      errorWidget: (context, _, __) {
        if (errorWidget != null) {
          return errorWidget!;
        }
        final errorImage = errorAssetImage ?? placeholderAssetImage ?? '';
        if (errorImage.isNotEmpty) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius:
                  isCircular ? null : BorderRadius.circular(borderRadius),
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: errorImage.endsWith(".svg")
                ? SvgPicture.asset(
                    errorImage,
                    fit: fit ?? BoxFit.contain,
                  )
                : Image.asset(
                    errorImage,
                    fit: fit,
                  ),
          );
        }
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius:
                isCircular ? null : BorderRadius.circular(borderRadius),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
        );
      },
    );
  }
}
