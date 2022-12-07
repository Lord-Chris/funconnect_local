// import 'package:video_player/video_player.dart';
//
// class AppVideoPlayer {
//   late String _videoPath;
//
//   String get videoPath => _videoPath;
//   // VideoPlayerController controller = VideoPlayerController.network(videoPath!
//   //     // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
//   //     )
//   //   ..initialize().then((_) {
//   //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//   //     // setState(() {});
//   //   });
//
//   VideoPlayerController controller = VideoPlayerController.network(videoPath)
//     ..initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//       // setState(() {});
//     });
//
//   Future<void> PlayVideoFromCache({required String videoPath}) async {
//     await VideoPlayerController.asset(videoPath)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         // setState(() {});
//       });
//   }
// }
