import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/generated_code_model.dart';
import '../../../domain/payload/generated_code_payload.dart';
import '../../../domain/repository/store_repository.dart';

part 'generated_code_event.dart';
part 'generated_code_state.dart';

class GeneratedCodeBloc extends Bloc<GeneratedCodeEvent, GeneratedCodeState> {
  final StoreRepository repository;
  GeneratedCodeBloc({required this.repository})
      : super(GeneratedCodeInitial()) {
    on<GeneratedCodeStarted>(_onGeneratedCodeEvent);
  }

  Future<void> _onGeneratedCodeEvent(
    GeneratedCodeEvent event,
    Emitter<GeneratedCodeState> emit,
  ) async {
    emit(GeneratedCodeInitial());

    emit(GeneratedCodePrepare());

    final result =
        await repository.getGeneratedCode(payload: GeneratedCodePayload());

    result.when(
      success: (model) => emit(
        GeneratedCodeSuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        GeneratedCodeFailure(
          error: error,
        ),
      ),
    );
  }
}
