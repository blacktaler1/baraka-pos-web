import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'create_receipt_event.dart';
part 'create_receipt_state.dart';

class CreateReceiptBloc extends Bloc<CreateReceiptEvent, CreateReceiptState> {
  final InventoryRepository repository;

  CreateReceiptBloc({required this.repository})
      : super(CreateReceiptInitial()) {
    on<CreateReceiptStarted>(_onCreateReceiptStarted);
  }

  Future<void> _onCreateReceiptStarted(
    CreateReceiptStarted event,
    Emitter<CreateReceiptState> emit,
  ) async {
    emit(CreateReceiptPrepare());

    final result = await repository.createReceipt(
      payload: CreateReceiptPayload(
        firmaId: event.firmaId,
        paidAmount: event.paidAmount,
        note: event.note,
        items: event.items,
      ),
    );

    result.when(
      success: (model) => emit(CreateReceiptSuccess(model: model)),
      failure: (error) => emit(CreateReceiptFailure(error: error)),
    );
  }
}
