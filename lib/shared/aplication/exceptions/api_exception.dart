import 'package:flutter/material.dart';

import 'base_exception.dart';

final class ApiException extends BaseException {
  final int code;
  final Object? data;

  const ApiException({required super.message, required this.code, this.data});

  @mustCallSuper
  @override
  List<String> get props => [...super.props, "code: $code", "data: $data"];
}

final class NotFoundException extends ApiException {
  const NotFoundException({required super.message}) : super(code: 404);

  @override
  List<String> get props => [...super.props, "Not Found"];
}

final class FormValidationException extends ApiException {
  final Map<String, List<String>> fields;
  const FormValidationException({required super.message, required this.fields})
      : super(code: 422);

  @override
  List<String> get props => [
        ...super.props,
        "fields: ${fields..entries.map((final entry) => "${entry.key}: ${entry.value},").join("\n\t")}",
      ];
}
