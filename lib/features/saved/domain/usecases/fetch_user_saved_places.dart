import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';

import '../../../places/domain/entities/saved_place_model.dart';
import '../../data/repository/i_saved_repository.dart';

class FetchUserSavedPlaces
    with UseCases<PaginatedData<SavedPlaceModel>, NoParams> {
  final _savedPlaceRepository = locator<ISavedRepository>();

  @override
  Future<PaginatedData<SavedPlaceModel>> call(NoParams params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final places = await _savedPlaceRepository.fetchUserSavedPlaces();
    return places;
  }
}
