import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String message;

  const BaseException({required this.message});

  @override
  List<String> get props => [
        "message: $message",
      ];
}
