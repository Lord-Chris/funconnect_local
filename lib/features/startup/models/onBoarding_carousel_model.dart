import 'package:funconnect/core/presentation/widgets/app_smart_strings.dart';

class OnBoardingCarouselModel {
  String title;
  String Subtitle;
  String ImgUrl;

  OnBoardingCarouselModel(
      {required this.title, required this.Subtitle, required this.ImgUrl});
}

List<OnBoardingCarouselModel> onBoardingCarouselItems = [
  OnBoardingCarouselModel(
    title: AppSmartString.carouselItemTitle1,
    Subtitle: AppSmartString.carouselItemSubTitle1,
    ImgUrl: AppSmartString.carouselImage1,
  ),
  OnBoardingCarouselModel(
    title: AppSmartString.carouselItemTitle2,
    Subtitle: AppSmartString.carouselItemSubTitle2,
    ImgUrl: AppSmartString.carouselImage2,
  ),
  OnBoardingCarouselModel(
    title: AppSmartString.carouselItemTitle3,
    Subtitle: AppSmartString.carouselItemSubTitle3,
    ImgUrl: AppSmartString.carouselImage3,
  ),
];

//final List<String> _ImgList = [
//   AppSmartString.carouselImage1,
//   AppSmartString.carouselImage2,
//   AppSmartString.carouselImage3,
// ];
