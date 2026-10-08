import '../../../../shared/shared.dart';
import '../../../auth/auth.dart';

final class GlobalProductItemModel extends Model {
  final String title;
  final String unit;
  final String qrCode;
  final ImageCollection images;

  const GlobalProductItemModel({
    required this.title,
    required this.unit,
    required this.qrCode,
    required this.images,
  });

  @override
  List<String> get props => [
        "title: $title",
        "unit: $unit",
        "qrCode: $qrCode",
        "imageCollection: $images",
      ];
}
