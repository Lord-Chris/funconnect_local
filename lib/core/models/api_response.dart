import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final T data;

  const ApiResponse({required this.data});

  @override
  List<Object?> get props => [data];
}
