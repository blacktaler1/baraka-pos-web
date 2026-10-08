import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class ImageCollection extends Collection<ImageModel> {
  const ImageCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
