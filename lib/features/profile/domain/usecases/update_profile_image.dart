import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/features/profile/domain/entities/profile_location_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

class UpdateProfileImage with UseCases<ProfileModel, File> {
  final _profileRepository = locator<IProfileRepository>();


  @override
  Future<ProfileModel> call(File params) async {
    await _profileRepository.updateProfileImage(params);
    return await _profileRepository.fetchUserProfile();
  }
}