import 'package:funconnect/core/models/_models.dart';

abstract class IDynamicLinkService {
  DeepLinkDataModel? get data;
  Stream<DeepLinkDataModel> get linkStream;

  Future<void> init();
  Future<String> generateLink(
      {required String desc, String? image, required DeepLinkDataModel data});
  Future<void> shareLink(String link);
  void clearData();
}
