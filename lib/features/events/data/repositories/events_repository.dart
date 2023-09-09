import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/events/data/data_sources/i_events_data_source.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

import 'i_events_repository.dart';

class EventsRepository extends IEventsRepository {
  final _httpDS = locator<IEventsDataSource>();

  @override
  Future<EventModel> createEvent() {
    throw UnimplementedError();
  }

  @override
  Future<EventModel> getEventDescription(String eventId) {
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<EventModel>> getListOfEvents() async {
    return await _httpDS.getListOfEvents();
  }
}
