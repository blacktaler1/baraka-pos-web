import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/data/sources/local_sources.dart';
import '../../settings.dart';

Future<void> showShopInfoPanel(BuildContext context) {
  return showAppSidePanel(context, builder: (_) => const UpdateShopInfoModal());
}

class UpdateShopInfoModal extends StatefulWidget {
  const UpdateShopInfoModal({super.key});

  @override
  State<UpdateShopInfoModal> createState() => _UpdateShopInfoModalState();
}

class _UpdateShopInfoModalState extends State<UpdateShopInfoModal> {
  late final _nameController =
      TextEditingController(text: globalUser!.warehouseShopName);
  late final _addressController =
      TextEditingController(text: globalUser!.warehouseAddress);
  late final _contactController =
      TextEditingController(text: globalUser!.warehouseContact);
  late final _phraseController =
      TextEditingController(text: globalUser!.warehousePhrase);
  final _formKey = GlobalKey<FormState>();

  Future<void> _persistLocally(UpdateShopInfoModel response) async {
    await AuthLocalSource(PosLocalDatabase.instance).updateMarketInformation(
      warehouseId: response.id,
      uuid: response.uuid,
      shopName: response.shopName,
      address: response.address,
      contact: response.contact,
      phrase: response.phrase,
      owner: response.owner,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _phraseController.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.isEmpty) ? "fill_the_field".tr() : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<UpdateShopInfoBloc>().add(
          UpdateShopInfoEvent(
            shopInfo: _nameController.text,
            address: _addressController.text,
            contact: _contactController.text,
            phrase: _phraseController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateShopInfoBloc, UpdateShopInfoState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (model) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("saved_successfully".tr())),
            );
            _persistLocally(model);
            Navigator.pop(context);
          },
          failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          ),
        );
      },
      builder: (context, state) {
        return AppSidePanel(
          title: "store_information".tr(),
          icon: Icons.storefront_rounded,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  label: "store_name".tr(),
                  required: true,
                  controller: _nameController,
                  prefix: const Icon(Icons.store_rounded, size: 18),
                  validator: _required,
                ),
                const AppFormGap(),
                AppTextField(
                  label: "address".tr(),
                  required: true,
                  controller: _addressController,
                  prefix: const Icon(Icons.location_on_rounded, size: 18),
                  validator: _required,
                ),
                const AppFormGap(),
                AppTextField(
                  label: "contact".tr(),
                  required: true,
                  controller: _contactController,
                  prefix: const Icon(Icons.call_rounded, size: 18),
                  keyboardType: TextInputType.phone,
                  validator: _required,
                ),
                const AppFormGap(),
                AppTextField(
                  label: "phrase".tr(),
                  required: true,
                  controller: _phraseController,
                  maxLines: 3,
                  validator: _required,
                ),
              ],
            ),
          ),
          actions: [
            AppButton.secondary(
              label: tr("cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            AppButton(
              label: "save".tr(),
              icon: Icons.check_circle_rounded,
              loading: state is UpdateShopInfoPrepare,
              onPressed: _save,
            ),
          ],
        );
      },
    );
  }
}
