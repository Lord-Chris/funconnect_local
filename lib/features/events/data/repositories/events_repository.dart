import 'package:funconnect/core/model/paginated_data.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

import 'i_events_repository.dart';

class EventsRepository extends IEventsRepository {
  @override
  Future<EventModel> createEvent() {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<EventModel> getEventDescription(String eventId) {
    // TODO: implement getEventDescription
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<EventModel>> getListOfEvents() {
    // TODO: implement getListOfEvents
    throw UnimplementedError();
  }
}
