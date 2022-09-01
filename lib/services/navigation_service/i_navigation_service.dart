import 'package:flutter/widgets.dart';

abstract class INavigationService {
  Future<T?>? toNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  Future<T?>? offNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  Future<T?>? offAllNamed<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  });

  void back<T extends Object?>([T? result]);
}
