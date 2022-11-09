class OnBoardingCarouselModel {
  String title;
  String Subtitle;
  String ImgUrl;

  OnBoardingCarouselModel(
      {required this.title, required this.Subtitle, required this.ImgUrl});
}

List<OnBoardingCarouselModel> onBoardingCarouselItems = [
  OnBoardingCarouselModel(
      title: 'Create events for\nmeet-ups',
      Subtitle:
          "Let’s help you create memorable moments by \n planning your next hangout",
      ImgUrl: "assets/images/splashImg.png"),
  OnBoardingCarouselModel(
      title: "Explore amazing\nplaces near you",
      Subtitle:
          "Every place has its specialty, we ought to feel\nthe freedom that comes with adventures",
      ImgUrl: "assets/images/splashImg2.png"),
  OnBoardingCarouselModel(
      title: "Share your best\nexperiences",
      Subtitle:
          "We help you establish human connections within\nthe context of shared experience.",
      ImgUrl: "assets/images/SplashImg3.png"),
];

final List<String> _ImgList = [
  "assets/images/splashImg.png",
  "assets/images/splashImg2.png",
  "assets/images/SplashImg3.png"
];
