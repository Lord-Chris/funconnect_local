import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

import '../../../../core/models/_models.dart';

class UpdateProfileImage with UseCases<UserModel, File> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<UserModel> call(File params) async {
    await _profileRepository.updateProfileImage(params);
    return await _profileRepository.fetchUserProfile();
  }
}
