import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/enums/search_filter_enum.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../domain/entities/search_query_param.dart';

class SearchFilterSheet extends HookWidget {
  final List<CategoryModel> categories;
  const SearchFilterSheet({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = useState(const SearchQueryParam());
    // final sortBy = useState(SearchEnum.date);
    return Container(
      constraints: BoxConstraints(
        maxHeight: .8.sh,
      ),
      color: AppColors.black,
      child: Column(
        children: [
          Spacing.vertMedium(),
          Row(
            children: [
              const Spacer(),
              Text(
                'Filters',
                style: AppTextStyles.regular16,
              ),
              const Spacer(),
              Text(
                'Clear',
                style: AppTextStyles.regular16,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing.vertRegular(),
                  Text(
                    'You’re in the mood for?',
                    style: AppTextStyles.regular14,
                  ),
                  ...categories.map(
                    (e) => CheckboxListTile(
                      value: selected.value.categories.contains(e),
                      onChanged: (val) {
                        final list =
                            List<CategoryModel>.from(selected.value.categories);
                        if (list.contains(e)) {
                          list.remove(e);
                        } else {
                          if (list.length > 4) return;
                          list.add(e);
                        }
                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        selected.value =
                            selected.value.copyWith(categories: list);
                      },
                      contentPadding: REdgeInsets.only(right: 20),
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      title: Text(
                        e.name,
                        style: AppTextStyles.medium20,
                      ),
                    ),
                  ),
                  Spacing.vertMedium(),
                  Spacing.vertMedium(),
                  Text(
                    'Sort by',
                    style: AppTextStyles.regular14,
                  ),
                  Spacing.vertRegular(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray333,
                      borderRadius: BorderRadius.circular(41),
                    ),
                    child: Row(
                      children: SearchEnum.values
                          .map(
                            (e) => Expanded(
                              child: InkWell(
                                onTap: () => selected.value =
                                    selected.value.copyWith(searchEnum: e),
                                child: Container(
                                  padding: REdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: selected.value.searchEnum == e
                                        ? AppColors.primary
                                        : null,
                                    borderRadius: BorderRadius.circular(41),
                                  ),
                                  child: Center(
                                    child: Text(
                                      e.parsed,
                                      style: AppTextStyles.regular14.copyWith(
                                        color: selected.value.searchEnum == e
                                            ? AppColors.black
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppOrangeBtn(
            label: 'Apply Filter',
            onTap: () => Navigator.pop(context, selected),
          ),
        ],
      ),
    );
  }
}
