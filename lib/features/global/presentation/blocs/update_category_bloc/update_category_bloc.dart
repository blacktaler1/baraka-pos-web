import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/category_model.dart';
import '../../../domain/payload/update_category_payload.dart';
import '../../../domain/repository/global_repository.dart';

part 'update_category_event.dart';
part 'update_category_state.dart';

class UpdateCategoryBloc
    extends Bloc<UpdateCategoryEvent, UpdateCategoryState> {
  final GlobalRepository repository;

  UpdateCategoryBloc({required this.repository})
      : super(UpdateCategoryInitial()) {
    on<UpdateCategoryStarted>(_onUpdateCategoryEvent);
  }

  Future<void> _onUpdateCategoryEvent(
    UpdateCategoryStarted event,
    Emitter<UpdateCategoryState> emit,
  ) async {
    emit(UpdateCategoryInitial());

    emit(UpdateCategoryPrepare());
    final result = await repository.updateCategory(
      payload: UpdateCategoryPayload(
        pk: event.pk,
        title: event.title,
        imageIds: event.list,
      ),
    );

    result.when(
      success: (model) => emit(
        UpdateCategorySuccess(model: model),
      ),
      failure: (error) => emit(
        UpdateCategoryFailure(error: error),
      ),
    );
  }
}
