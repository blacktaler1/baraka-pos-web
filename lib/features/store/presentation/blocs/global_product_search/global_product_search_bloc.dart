import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'global_product_search_event.dart';
part 'global_product_search_state.dart';

class GlobalProductSearchBloc
    extends Bloc<GlobalProductSearchEvent, GlobalProductSearchState> {
  final StoreRepository repository;
  GlobalProductSearchBloc({required this.repository})
      : super(GlobalProductSearchInitial()) {
    on<GlobalProductSearchEvent>(_onGlobalProductSearchEvent);
  }
  Future<void> _onGlobalProductSearchEvent(
    GlobalProductSearchEvent event,
    Emitter<GlobalProductSearchState> emit,
  ) async {
    emit(GlobalProductSearchInitial());

    emit(GlobalProductSearchPrepare());

    final result = await repository.globalSearchProduct(
      payload: GlobalProductPayload(search: event.search),
    );

    result.when(
      success: (model) => emit(
        GlobalProductSearchSuccess(model: model),
      ),
      failure: (error) => emit(
        GlobalProductSearchFailure(error: error),
      ),
    );
  }
}
