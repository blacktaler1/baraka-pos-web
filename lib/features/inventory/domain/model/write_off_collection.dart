import '../../../../shared/domain/domain.dart';
import 'write_off_model.dart';

final class WriteOffCollection extends Collection<WriteOffModel> {
  const WriteOffCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
