import 'package:equatable/equatable.dart';
import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';

class SearchQueryParam extends Equatable {
  final String param;
  final List<CategoryModel> categories;
  final SearchEnum searchEnum;

  const SearchQueryParam({
    this.param = '',
    this.categories = const [],
    this.searchEnum = SearchEnum.date,
  });

  @override
  List<Object> get props => [param, categories, searchEnum];

  SearchQueryParam copyWith({
    String? param,
    List<CategoryModel>? categories,
    SearchEnum? searchEnum,
  }) {
    return SearchQueryParam(
      param: param ?? this.param,
      categories: categories ?? this.categories,
      searchEnum: searchEnum ?? this.searchEnum,
    );
  }

  String get toCategoryParam => categories.isEmpty
      ? ''
      : '&categories=${categories.map((e) => e.id).join(',')}';

  String get toSearchEnumParam {
    if (searchEnum == SearchEnum.location) return '';
    if (searchEnum == SearchEnum.date) {
      return '&date=0';
    } else {
      return '&interest=0';
    }
  }

  String get toParam => toCategoryParam + toSearchEnumParam;

  bool get isEmpty => this == const SearchQueryParam();
}
