import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/constants/_constants.dart';
import 'i_media_service.dart';

class MediaService extends IMediaService {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  @override
  Future<File?> pickImage({required bool fromGallery}) async {
    final XFile? image = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (image == null) return null;

    final file = File(image.path);
    return file;
  }

  @override
  Future<File?> pickVideo({required bool fromGallery}) async {
    final XFile? image = await _picker.pickVideo(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (image == null) return null;

    final file = File(image.path);
    return file;
  }

  @override
  Future<File?> getImageCropped({required File file}) async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      // maxWidth: 200,
      // maxHeight: 200,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        IOSUiSettings(title: 'Crop'),
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: AppColors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        )
      ],
    );

    if (croppedFile == null) return null;

    return File(croppedFile.path);
  }
}
