import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';

class RemotePlaceDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();


  Future<ProfileModel> getUserProfile() async {
    final res = await _networkService.get(
      ApiConstants.profileSetup,
      headers: headers,
    );

    final data = res.data['data'];
    return ProfileModel.fromMap(data);

  }


}
