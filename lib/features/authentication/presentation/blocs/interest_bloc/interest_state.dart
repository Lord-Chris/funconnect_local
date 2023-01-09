import 'package:equatable/equatable.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';

abstract class InterestsState extends Equatable {
  final List<InterestModel> interests;
  final List<InterestModel> selectedInterest;

  const InterestsState({
    this.interests = const [],
    this.selectedInterest = const [],
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}

class InterestsInitialState extends InterestsState {
  const InterestsInitialState({
    super.interests = const [],
    super.selectedInterest = const [],
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}

class InterestsLoadingState extends InterestsState {
  const InterestsLoadingState({
    super.interests = const [],
    super.selectedInterest = const [],
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}

class InterestsSuccessState extends InterestsState {
  const InterestsSuccessState({
    super.interests = const [],
    super.selectedInterest = const [],
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}

class InterestsErrorState extends InterestsState {
  const InterestsErrorState({
    super.interests = const [],
    super.selectedInterest = const [],
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}
