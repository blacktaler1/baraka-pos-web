part of 'scan_invoice_bloc.dart';

sealed class ScanInvoiceState extends Equatable {
  const ScanInvoiceState();

  T? whenOrNull<T>({
    T Function()? inPrepare,
    T Function(InvoiceScanModel model)? success,
    T Function(BaseException error)? failure,
  }) {
    return switch (this) {
      ScanInvoiceInitial() => null,
      ScanInvoicePrepare() => inPrepare?.call(),
      ScanInvoiceSuccess(:final model) => success?.call(model),
      ScanInvoiceFailure(:final error) => failure?.call(error),
    };
  }

  @override
  List<Object> get props => [];
}

final class ScanInvoiceInitial extends ScanInvoiceState {}

final class ScanInvoicePrepare extends ScanInvoiceState {}

final class ScanInvoiceSuccess extends ScanInvoiceState {
  final InvoiceScanModel model;

  const ScanInvoiceSuccess({required this.model});

  @override
  List<Object> get props => [model];
}

final class ScanInvoiceFailure extends ScanInvoiceState {
  final BaseException error;

  const ScanInvoiceFailure({required this.error});

  @override
  List<Object> get props => [error];
}
