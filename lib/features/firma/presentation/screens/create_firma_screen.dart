import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../media/presentation/blocs/post_media_bloc/post_media_bloc.dart';
import '../../domain/model/firma_model.dart';
import '../blocs/create_firma_bloc/create_firma_bloc.dart';
import '../blocs/get_by_id_firma_bloc/get_by_id_firma_bloc.dart';
import '../blocs/get_firma_bloc/get_firma_bloc.dart';
import '../blocs/update_frima_bloc/update_firma_bloc.dart';

/// Yangi firma yaratilsa, o'sha firma qaytariladi
Future<FirmaModel?> showFirmaPanel(BuildContext context, {FirmaModel? firma}) {
  return showAppSidePanel<FirmaModel>(
    context,
    builder: (_) => FirmaFormPanel(firma: firma),
  );
}

class FirmaFormPanel extends StatefulWidget {
  final FirmaModel? firma;

  const FirmaFormPanel({super.key, this.firma});

  @override
  State<FirmaFormPanel> createState() => _FirmaFormPanelState();
}

class _FirmaFormPanelState extends State<FirmaFormPanel> {
  final _formKey = GlobalKey<FormState>();
  late final nameController =
      TextEditingController(text: widget.firma?.title ?? '');
  late final numberController =
      TextEditingController(text: widget.firma?.phone ?? '');
  late final addressController =
      TextEditingController(text: widget.firma?.address ?? '');

  XFile? pickedImage;
  bool loading = false;

  bool get _isEdit => widget.firma != null;

  String? get _imageUrl => widget.firma?.images.models.isNotEmpty == true
      ? widget.firma!.images.models.first.file
      : null;

  bool get _changed {
    final orig = widget.firma;
    if (orig == null) return true;
    return nameController.text.trim() != orig.title ||
        numberController.text.trim() != orig.phone ||
        addressController.text.trim() != orig.address ||
        pickedImage != null;
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    if (pickedImage != null) {
      context.read<PostMediaBloc>().add(PostMediaStarted(image: pickedImage!));
    } else {
      _submit(_isEdit && widget.firma!.images.models.isNotEmpty
          ? [widget.firma!.images.models.first.id]
          : []);
    }
  }

  void _submit(List<int> imageIds) {
    final name = nameController.text.trim();
    final phone = numberController.text.trim();
    final address = addressController.text.trim();

    if (!_isEdit) {
      context.read<CreateFirmaBloc>().add(
            CreateFirmaStarted(
              title: name,
              phone: phone,
              address: address,
              imageIds: imageIds,
            ),
          );
      return;
    }

    final orig = widget.firma!;
    context.read<UpdateFirmaBloc>().add(
          UpdateFirmaStarted(
            pk: orig.id,
            title: name != orig.title ? name : "",
            phone: phone != orig.phone ? phone : "",
            address: address != orig.address ? address : "",
            imageIds: pickedImage != null ? imageIds : [],
          ),
        );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? tr("field_required") : null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) => _submit([model.id]),
              failure: (err) {
                setState(() => loading = false);
                _snack(err.message);
              },
            );
          },
        ),
        BlocListener<CreateFirmaBloc, CreateFirmaState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (created) {
                context.read<GetFirmaBloc>().add(
                      const GetFirmaStarted(
                        search: '',
                        cursor: '',
                        pageSize: 10,
                        debt: false,
                      ),
                    );
                Navigator.pop(context, created);
                _snack(tr("firma_created_successfully"));
              },
              failure: (err) {
                setState(() => loading = false);
                _snack(err.message);
              },
            );
          },
        ),
        BlocListener<UpdateFirmaBloc, UpdateFirmaState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                context
                    .read<GetByIdFirmaBloc>()
                    .add(GetByIdFirmaStarted(id: model.id));
                Navigator.pop(context);
                _snack(tr("firma_updated_successfully"));
              },
              failure: (err) {
                setState(() => loading = false);
                _snack(err.message);
              },
            );
          },
        ),
      ],
      child: AppSidePanel(
        title: _isEdit ? tr("update_firma") : tr("add_new"),
        icon: _isEdit ? Icons.edit_note_rounded : Icons.add_business_rounded,
        subtitle: _isEdit ? widget.firma!.title : tr("company_information"),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFieldLabel(tr("photo")),
              AppImagePicker(
                file: pickedImage,
                imageUrl: _imageUrl,
                placeholderIcon: Icons.add_photo_alternate_rounded,
                onPicked: (file) => setState(() => pickedImage = file),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppTextField(
                label: tr("company_name"),
                required: true,
                prefix: const Icon(Icons.business_rounded, size: 18),
                controller: nameController,
                validator: _required,
                onChanged: (_) => setState(() {}),
              ),
              const AppFormGap(),
              AppTextField(
                label: tr("firma_number"),
                required: true,
                prefix: const Icon(Icons.call_rounded, size: 18),
                controller: numberController,
                keyboardType: TextInputType.phone,
                validator: _required,
                onChanged: (_) => setState(() {}),
              ),
              const AppFormGap(),
              AppTextField(
                label: tr("address"),
                required: true,
                prefix: const Icon(Icons.location_on_rounded, size: 18),
                controller: addressController,
                validator: _required,
                onChanged: (_) => setState(() {}),
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
            label: tr("save"),
            icon: Icons.check_circle_rounded,
            loading: loading,
            onPressed: _changed ? _save : null,
          ),
        ],
      ),
    );
  }
}
