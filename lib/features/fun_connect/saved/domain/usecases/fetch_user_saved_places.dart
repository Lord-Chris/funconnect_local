import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';

import '../../data/repository/i_saved_repository.dart';
import '../entities/saved_place_model.dart';

class FetchUserSavedPlaces with UseCases<PaginatedData<SavedPlaceModel>, SavedPlaceModel> {
  final _savedPlaceRepository = locator<ISavedRepository>();
 

  @override
  Future<PaginatedData<SavedPlaceModel>> call(SavedPlaceModel params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final places = await _savedPlaceRepository.fetchUserSavedPlaces(
        params.userId);
    return places;
  }
 
}
