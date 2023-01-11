import 'package:funconnect/core/model/paginated_data.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

abstract class IEventsRepository {
  Future<PaginatedData<EventModel>> getListOfEvents();
  Future<EventModel> getEventDescription(String eventId);

  Future<EventModel> createEvent();
}
