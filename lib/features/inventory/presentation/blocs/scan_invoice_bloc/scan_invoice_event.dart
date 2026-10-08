part of 'scan_invoice_bloc.dart';

sealed class ScanInvoiceEvent extends Equatable {
  const ScanInvoiceEvent();

  @override
  List<Object> get props => [];
}

final class ScanInvoiceStarted extends ScanInvoiceEvent {
  final XFile file;

  const ScanInvoiceStarted({required this.file});

  @override
  List<Object> get props => ["file: ${file.name}"];
}
