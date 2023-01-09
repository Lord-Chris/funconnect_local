import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/model/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';

class FetchInterestUseCase
    with UseCases<PaginatedData<InterestModel>, NoParams> {
  final repo = locator<IAuthenticationRepository>();
  @override
  Future<PaginatedData<InterestModel>> call(NoParams params) async {
    return await repo.fetchInterests();
  }
}
