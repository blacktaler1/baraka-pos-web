import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final GlobalRepository repository;
  CreateCategoryBloc({
    required this.repository,
  }) : super(CreateCategoryInitial()) {
    on<CreateCategoryEvent>(_onCreateCategoryEvent);
  }

  Future<void> _onCreateCategoryEvent(
    CreateCategoryEvent event,
    Emitter<CreateCategoryState> emit,
  ) async {
    emit(CreateCategoryInitial());

    emit(CreateCategoryPrepare());

    final result = await repository.createCategory(
      payload: CreateCategoryPayload(
        title: event.title,
        imageIds: event.list,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateCategorySuccess(model: model),
      ),
      failure: (error) => emit(
        CreateCategoryFailure(error: error),
      ),
    );
  }
}
