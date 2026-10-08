import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/delete_category_model.dart';
import '../../../domain/payload/delete_category_payload.dart';
import '../../../domain/repository/global_repository.dart';

part 'delete_category_event.dart';
part 'delete_category_state.dart';

class DeleteCategoryBloc
    extends Bloc<DeleteCategoryEvent, DeleteCategoryState> {
  final GlobalRepository repository;

  DeleteCategoryBloc({required this.repository})
      : super(DeleteCategoryInitial()) {
    on<DeleteCategoryStarted>(_onDeleteCategoryEvent);
  }

  Future<void> _onDeleteCategoryEvent(
    DeleteCategoryStarted event,
    Emitter<DeleteCategoryState> emit,
  ) async {
    emit(DeleteCategoryInitial());
    emit(DeleteCategoryPrepare());
    final result = await repository.deleteCategory(
      payload: DeleteCategoryPayload(
        pk: event.pk,
      ),
    );

    result.when(
      success: (model) => emit(
        DeleteCategorySuccess(model: model),
      ),
      failure: (error) => emit(
        DeleteCategoryFailure(error: error),
      ),
    );
  }
}
