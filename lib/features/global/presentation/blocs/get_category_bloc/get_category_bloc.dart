import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final GlobalRepository repository;
  GetCategoryBloc({required this.repository}) : super(GetCategoryInitial()) {
    on<GetCategoryStarted>(_onGetCategoryStarted);
  }

  Future<void> _onGetCategoryStarted(
    GetCategoryStarted event,
    Emitter<GetCategoryState> emit,
  ) async {
    emit(GetCategoryInitial());

    emit(GetCategoryPrepare());

    final result = await repository.getCategory(
        payload: CategoryPayload(
      cursor: event.cursor,
      pageSize: event.pageSize,
    ));

    result.when(
      success: (model) => emit(
        GetCategorySuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        GetCategoryFailure(
          error: error,
        ),
      ),
    );
  }
}

class GetCategoryPagBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final GlobalRepository repository;
  GetCategoryPagBloc({required this.repository}) : super(GetCategoryInitial()) {
    on<GetCategoryStarted>(_onGetCategoryStarted);
  }

  Future<void> _onGetCategoryStarted(
    GetCategoryStarted event,
    Emitter<GetCategoryState> emit,
  ) async {
    emit(GetCategoryInitial());

    emit(GetCategoryPrepare());

    final result = await repository.getCategory(
        payload: CategoryPayload(
      cursor: event.cursor,
      pageSize: event.pageSize,
    ));

    result.when(
      success: (model) => emit(
        GetCategorySuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        GetCategoryFailure(
          error: error,
        ),
      ),
    );
  }
}
