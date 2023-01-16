import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/events/data/repositories/i_events_repository.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

class FetchEventsUsecase with UseCases<List<EventModel>, NoParams> {
  final _eventsRepo = locator<IEventsRepository>();
  @override
  Future<List<EventModel>> call(NoParams params) async {
    final result = await _eventsRepo.getListOfEvents();
    return result.data;
  }
}
