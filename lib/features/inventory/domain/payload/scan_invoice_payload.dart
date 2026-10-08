import 'package:cross_file/cross_file.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class ScanInvoicePayload extends Payload {
  final XFile file;

  const ScanInvoicePayload({required this.file});

  @override
  List<String> get props => ["file: ${file.name}"];
}
