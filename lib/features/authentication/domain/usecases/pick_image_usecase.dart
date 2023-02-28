import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/services/_services.dart';

class PickImageUseCase with UseCases<File?, NoParams> {
  final _mediaService = locator<IMediaService>();

  @override
  Future<File?> call(NoParams params) async {
    File? image = await _mediaService.pickImage(fromGallery: true);
    if (image == null) return null;
    image = await _mediaService.getImageCropped(file: image);
    return image;
  }
}
