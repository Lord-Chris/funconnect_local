import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';

class AddFriendUseCase with UseCases<MiniPlanFriend, AddFriendsParams> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<MiniPlanFriend> call(params) async {
    return await _planRepository.addFriend(params);
  }
}
