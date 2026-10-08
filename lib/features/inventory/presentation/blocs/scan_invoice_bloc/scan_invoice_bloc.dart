import 'package:cross_file/cross_file.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'scan_invoice_event.dart';
part 'scan_invoice_state.dart';

class ScanInvoiceBloc extends Bloc<ScanInvoiceEvent, ScanInvoiceState> {
  final InventoryRepository repository;

  ScanInvoiceBloc({required this.repository}) : super(ScanInvoiceInitial()) {
    on<ScanInvoiceStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ScanInvoiceStarted event,
    Emitter<ScanInvoiceState> emit,
  ) async {
    emit(ScanInvoicePrepare());

    final result = await repository.scanInvoice(
      payload: ScanInvoicePayload(file: event.file),
    );

    result.when(
      success: (model) => emit(ScanInvoiceSuccess(model: model)),
      failure: (error) => emit(ScanInvoiceFailure(error: error)),
    );
  }
}
