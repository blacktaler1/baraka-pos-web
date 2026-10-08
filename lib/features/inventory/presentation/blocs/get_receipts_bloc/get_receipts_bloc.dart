import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'get_receipts_event.dart';
part 'get_receipts_state.dart';

class GetReceiptsBloc extends Bloc<GetReceiptsEvent, GetReceiptsState> {
  final InventoryRepository repository;

  GetReceiptsBloc({required this.repository}) : super(GetReceiptsInitial()) {
    on<GetReceiptsStarted>(_onGetReceiptsStarted);
  }

  Future<void> _onGetReceiptsStarted(
    GetReceiptsStarted event,
    Emitter<GetReceiptsState> emit,
  ) async {
    emit(GetReceiptsPrepare());

    final result = await repository.getReceipts(
      payload: GetReceiptsPayload(
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(GetReceiptsSuccess(model: model)),
      failure: (error) => emit(GetReceiptsFailure(error: error)),
    );
  }
}
