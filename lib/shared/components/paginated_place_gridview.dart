import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/models/_models.dart';
import '_components.dart';

class PaginatedPlaceGridView<T> extends HookWidget {
  final PaginatedData<T> initialList;
  final Future<PaginatedData<T>> Function(int) moreFunction;
  final Widget Function(T) itemBuilder;

  const PaginatedPlaceGridView({
    super.key,
    required this.initialList,
    required this.moreFunction,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final pagingController =
        useState(PagingController<int, T>(firstPageKey: 1)).value;
    useEffect(() {
      pagingController.appendPage(
        initialList.data,
        initialList.nextPageUrl == null ? null : initialList.currentPage,
      );
      pagingController.addPageRequestListener(
        (page) async {
          try {
            final res = await moreFunction(page);
            // await FetchPlacesByCategory().call(category.id, page + 1);

            if (res.nextPageUrl == null) {
              pagingController.appendLastPage(res.data);
            } else {
              pagingController.appendPage(
                res.data,
                res.currentPage,
              );
            }
          } on Failure catch (error) {
            pagingController.error = error.message;
          }
        },
      );

      return () {
        pagingController.removePageRequestListener((_) {});
        pagingController.dispose();
      };
    }, []);
    return PagedGridView<int, T>(
      pagingController: pagingController,
      shrinkWrap: true,
      padding: REdgeInsets.symmetric(horizontal: 16),
      // physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 182.r * 1.3,
        childAspectRatio: 1,
        mainAxisSpacing: 10.r,
        crossAxisSpacing: 8.r,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        newPageProgressIndicatorBuilder: (context) => const AppLoader(),
        itemBuilder: (context, _, index) {
          final item = (pagingController.itemList ?? [])[index];
          return itemBuilder(item);
        },
      ),
    );
  }
}
