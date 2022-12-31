import 'package:funconnect/core/usecases/usecase.dart';

class SaveInterestsUseCases with UseCases<void, NoParams> {
  @override
  Future<void> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
