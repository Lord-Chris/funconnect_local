import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';

class BookmarkPlace with UseCases<bool, bool> {
  final FullPlaceModel place;

  BookmarkPlace(this.place);

  final _repo = locator<IPlaceRepository>();

  @override
  Future<bool> call(bool params) async {
    final isBookmarked = await _repo.toggleBookmark(place, params);
    return isBookmarked;
  }
}
