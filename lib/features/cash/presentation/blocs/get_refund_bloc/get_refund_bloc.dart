import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/all_refunds_model.dart';
import '../../../domain/payload/get_refund_payload.dart';
import '../../../domain/repository/cash_repository.dart';

part 'get_refund_event.dart';
part 'get_refund_state.dart';

class GetRefundBloc extends Bloc<GetRefundEvent, GetRefundState> {
  final CashRepository repository;

  GetRefundBloc({required this.repository}) : super(GetRefundInitial()) {
    on<GetRefundStarted>(_onGetRefundStarted);
  }

  Future<void> _onGetRefundStarted(
    GetRefundStarted event,
    Emitter<GetRefundState> emit,
  ) async {
    emit(GetRefundInitial());
    emit(GetRefundPrepare());
    final result = await repository.getAllRefunds(
      payload: GetRefundPayload(
        from: event.from,
        to: event.to,
        search: event.search,
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );
    result.when(
      success: (model) {
        emit(GetRefundSuccess(model: model));
      },
      failure: (error) {
        emit(GetRefundFailure(error: error));
      },
    );
  }
}
