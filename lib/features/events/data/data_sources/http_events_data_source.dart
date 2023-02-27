import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/services/_services.dart';

import 'i_events_data_source.dart';

class HttpEventsDataSource extends IEventsDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();
  // final _localStorageService = locator<ILocalStorageService>();

  @override
  Future<PaginatedData<EventModel>> getListOfEvents() async {
    final res =
        await _networkService.get(ApiConstants.events, headers: headers);
    return PaginatedData.fromMap(
      res.data['data'],
      (e) => EventModel.fromMap(e),
    );
  }
}
