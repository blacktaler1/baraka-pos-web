import 'package:baraka_pos/shared/domain/domain.dart';

final class DeleteCategoryPayload extends Payload {
  final int pk;

  const DeleteCategoryPayload({
    required this.pk,
  });

  @override
  List<Object> get props => [
        "pk: $pk",
      ];
}
