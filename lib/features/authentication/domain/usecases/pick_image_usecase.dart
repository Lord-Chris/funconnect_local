import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/services/_services.dart';

class PickImageUseCase with UseCases<File?, NoParams> {
  final _mediaService = locator<IMediaService>();

  @override
  Future<File?> call(NoParams params) async {
    final res = await _mediaService.pickImage(fromGallery: true);
    if (res == null) return null;
    return res;
  }
}
