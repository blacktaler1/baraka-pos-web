part of '../data.dart';

abstract class RemoteRequest<P extends Payload> {
  Map<String, String> path();
  Map<String, String> query();
  Json data();

  const RemoteRequest.fromPayload(P payload);
  FutureOr<FormData>? form() => null;

  CancelToken? get cancelToken => null;

  ProgressCallback? get onSendProgress => null;

  ProgressCallback? get onReceiveProgress => null;
}
