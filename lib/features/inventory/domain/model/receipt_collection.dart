import '../../../../shared/domain/domain.dart';
import 'receipt_model.dart';

final class ReceiptCollection extends Collection<ReceiptModel> {
  const ReceiptCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
