import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/settings/settings.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'update_shop_info_event.dart';
part 'update_shop_info_state.dart';

class UpdateShopInfoBloc
    extends Bloc<UpdateShopInfoEvent, UpdateShopInfoState> {
  final SettingsRepository repository;
  UpdateShopInfoBloc({required this.repository})
      : super(UpdateShopInfoInitial()) {
    on<UpdateShopInfoEvent>(_onUpdateShopInfoEvent);
  }

  Future<void> _onUpdateShopInfoEvent(
    UpdateShopInfoEvent event,
    Emitter<UpdateShopInfoState> emit,
  ) async {
    emit(UpdateShopInfoInitial());

    emit(UpdateShopInfoPrepare());

    final result = await repository.updateShopInfo(
      payload: UpdateShopInfoPayload(
        shopInfo: event.shopInfo,
        address: event.address,
        contact: event.contact,
        phrase: event.phrase,
      ),
    );

    result.when(
      success: (model) => emit(
        UpdateShopInfoSuccess(model: model),
      ),
      failure: (error) => emit(
        UpdateShopInfoFailure(error: error),
      ),
    );
  }
}
