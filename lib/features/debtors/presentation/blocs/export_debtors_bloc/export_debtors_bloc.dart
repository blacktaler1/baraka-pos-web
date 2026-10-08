import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../global/domain/domain.dart';
import '../../../domain/domain.dart';

part 'export_debtors_event.dart';
part 'export_debtors_state.dart';

class ExportDebtorsBloc extends Bloc<ExportDebtorsEvent, ExportDebtorsState> {
  final DebtorsRepository repository;

  ExportDebtorsBloc({required this.repository})
      : super(ExportDebtorsInitial()) {
    on<ExportDebtorsStarted>(_onExportDebtorsStarted);
  }

  Future<void> _onExportDebtorsStarted(
    ExportDebtorsStarted event,
    Emitter<ExportDebtorsState> emit,
  ) async {
    emit(ExportDebtorsPrepare());

    final result = await repository.exportDebtors(
      payload: ExportDebtorsPayload(),
    );

    result.when(
      success: (model) => emit(ExportDebtorsSuccess(model: model)),
      failure: (error) => emit(ExportDebtorsFailure(error: error)),
    );
  }
}
