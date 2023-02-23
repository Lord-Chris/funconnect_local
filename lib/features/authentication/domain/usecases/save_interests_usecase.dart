import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';

import '../../data/repositories/i_authentication_repository.dart';

class SaveInterestsUseCases with UseCases<void, List<InterestModel>> {
  final _repo = locator<IAuthenticationRepository>();
  @override
  Future<void> call(List<InterestModel> params) async {
    await _repo.saveInterests(params);
  }
}
