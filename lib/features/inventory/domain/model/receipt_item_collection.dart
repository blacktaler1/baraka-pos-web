import '../../../../shared/domain/domain.dart';
import 'receipt_item_model.dart';

final class ReceiptItemCollection extends Collection<ReceiptItemModel> {
  const ReceiptItemCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
