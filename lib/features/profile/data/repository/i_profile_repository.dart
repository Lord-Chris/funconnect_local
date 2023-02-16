import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel> fetchProfile();
  Future<void> updateProfile(ProfileModel profileModel);
}
