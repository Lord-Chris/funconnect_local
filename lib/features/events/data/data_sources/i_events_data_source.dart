import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

abstract class IEventsDataSource {
  Future<PaginatedData<EventModel>> getListOfEvents();
}
