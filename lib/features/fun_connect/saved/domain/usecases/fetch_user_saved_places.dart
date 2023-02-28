import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';

import '../../data/repository/i_saved_repository.dart';
import '../entities/saved_place_model.dart';

class FetchUserSavedPlaces with UseCases<List, SavedPlaceModel> {
  final _savedPlaceRepository = locator<ISavedRepository>();

  @override
  Future<List> call(SavedPlaceModel params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
   final places = await _savedPlaceRepository.fetchSavedPlaces(params.id);
    return [places];
  }
}



 

